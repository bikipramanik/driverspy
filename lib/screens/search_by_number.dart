import 'package:driverspy/screens/vehicle_details_screen.dart';
import 'package:driverspy/widgets/sbi_screen_widgets/custom_elevated_button.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class SearchByNumber extends StatefulWidget {
  const SearchByNumber({super.key});

  @override
  State<SearchByNumber> createState() => _SearchByNumberState();
}

class _SearchByNumberState extends State<SearchByNumber> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? input;
  bool showReset = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    void searchOnTap() {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      final sanitizedInput = _controller.text.replaceAll(' ', '');

      if (sanitizedInput.length != 10) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please enter exactly 10 characters in capital (excluding spaces).',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      setState(() {
        input = sanitizedInput;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VehicleDetailsScreen(
            vehicleNo: "98313748",
            vehicleDetail: null,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Container(
          height: screenHeight * 0.6,
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(82, 224, 216, 0),
                const Color.fromARGB(95, 40, 211, 171),
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
                    TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      onChanged: (value) {
                        setState(() {
                          showReset = true;
                        });
                        final upper = value.toUpperCase();
                        if (value != upper) {
                          _controller.value = _controller.value.copyWith(
                            text: upper,
                            selection:
                                TextSelection.collapsed(offset: upper.length),
                          );
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Plate Number",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: showReset
                          ? CustomElevatedButton(
                              buttonIcon: Icon(FluentIcons.delete_12_regular),
                              buttonText: " Clear",
                              backgroundColor:
                                  const Color.fromARGB(187, 255, 0, 0),
                              foregroundColor: Colors.white,
                              buttonSize: Size(100, 20),
                              fontSize: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onPressed: () {
                                setState(() {
                                  showReset = false;
                                });
                                _controller.clear();
                              },
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                right: 0,
                child: CustomElevatedButton(
                  buttonIcon: Icon(FluentIcons.search_24_regular),
                  buttonText: "Search",
                  backgroundColor: const Color.fromARGB(158, 54, 189, 171),
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
      ),
    );
  }
}
