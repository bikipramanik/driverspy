import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:driverspy/provider/image_upload_provider.dart';
import 'package:driverspy/screens/vehicle_details_screen.dart';
import 'package:driverspy/widgets/sbi_screen_widgets/choose_buttons.dart';
import 'package:driverspy/widgets/sbi_screen_widgets/custom_elevated_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SearchByImage extends ConsumerStatefulWidget {
  const SearchByImage({super.key});

  @override
  ConsumerState<SearchByImage> createState() => _SearchByImageState();
}

class _SearchByImageState extends ConsumerState<SearchByImage> {
  File? _selectedImage;
  String? base64String;

  Future<String> convertBase64(File selectedImage) async {
    Uint8List bytes = await selectedImage.readAsBytes();
    String base64String = base64.encode(bytes);
    return base64String;
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop and save',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'crop and save',
        ),
      ],
    );

    if (croppedFile == null) return;
    final imageFile = File(croppedFile.path);
    final base64 = await convertBase64(imageFile);

    setState(() {
      _selectedImage = File(croppedFile.path);
      base64String = base64;
    });
  }

  Future _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile == null) return;

    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'crop and save',
          toolbarColor: const Color.fromARGB(113, 255, 86, 34),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'crop and save',
        ),
      ],
    );

    if (croppedFile == null) return;

    final imageFile = File(croppedFile.path);
    final base64 = await convertBase64(imageFile);

    setState(() {
      _selectedImage = File(croppedFile.path);
      base64String = base64;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    void searchOnTap() async {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_selectedImage == null || base64String == null) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No Image Selected, Please Select Image!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      await ref.read(provider.notifier).postImage(base64String!);

      final vehicleState = ref.read(provider);

      vehicleState.when(
        data: (result) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VehicleDetailsScreen(
                vehicleNo: result?.vehicleNo ?? "UNKNOWN",
                vehicleDetail: result?.vehicleDetail,
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error: $error , stackTrace : $stackTrace"),
            ),
          );
        },
        loading: () {},
      );
    }

    return Center(
      child: Container(
        height: screenHeight * 0.6,
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(82, 0, 224, 101),
              const Color.fromARGB(95, 40, 66, 211),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.07,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  InkWell(
                    onTap: _pickImageFromGallery,
                    enableFeedback: true,
                    child: ChooseButtons(
                      screenHeight: screenHeight,
                      screenWidth: double.infinity,
                      buttonText: "Choose From Gallery",
                      buttonIcon: Icon(FluentIcons.storage_28_regular),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  InkWell(
                    onTap: _pickImageFromCamera,
                    enableFeedback: true,
                    child: ChooseButtons(
                      screenHeight: screenHeight,
                      screenWidth: double.infinity,
                      buttonText: "Choose Using Camera",
                      buttonIcon: Icon(FluentIcons.camera_add_24_regular),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _selectedImage != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: screenWidth * 0.35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(75, 244, 225, 54),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            CustomElevatedButton(
                              buttonText: "Remove",
                              buttonIcon: Icon(FluentIcons.delete_12_regular),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              buttonSize: Size(100, 20),
                              fontSize: 10,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                            ),
                          ],
                        )
                      : Text("Select Image")
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              right: 0,
              child: CustomElevatedButton(
                buttonIcon: Icon(FluentIcons.search_24_regular),
                buttonText: "Search",
                backgroundColor: const Color.fromARGB(158, 189, 153, 54),
                foregroundColor: Colors.white,
                buttonSize: Size(180, 50),
                fontSize: 18,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                onPressed: searchOnTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
