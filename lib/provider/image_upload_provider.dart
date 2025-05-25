import 'dart:convert';
import 'package:driverspy/utils/vehicle_detail.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class _ImageUploadStateNotifier
    extends StateNotifier<AsyncValue<VehicleResult?>> {
  _ImageUploadStateNotifier() : super(const AsyncValue.data(null));

  Future<void> postImage(String? base64string) async {
    // final uri = Uri.parse("http://localhost:8000/api/vehicle");
    final uri = Uri.parse("http://192.168.0.103:8000/api/vehicle");
    if (base64string == null) {
      state = AsyncValue.error("Image data is null", StackTrace.current);
      return;
    }
    final body = jsonEncode({"image": base64string});

    state = const AsyncValue.loading();

    try {
      final response = await http.post(
        uri,
        headers: {"content-type": "application/json"},
        body: body,
      );
      print(
          "$response-------------------------------------------------------??????????????????????????????");
      if (response.statusCode >= 200) {
        final data = jsonDecode(response.body);
        final vehicleNO = data["vehicle_no"];
        final vehicleInfoJson = data["vehicle_info"];
        print('--------------------------------$vehicleNO');
        print(
            '----------------------------------------------------------------$vehicleInfoJson');

        final vehicleResult = VehicleResult(
          vehicleNo: vehicleNO,
          vehicleDetail: vehicleInfoJson != null
              ? VehicleDetail.fromJson(vehicleInfoJson)
              : null,
        );

        state = AsyncValue.data(vehicleResult);
      } else {
        state = AsyncValue.error(
          "Failed with ${response.statusCode}",
          StackTrace.fromString("HAHAHAHA"),
        );
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final provider = StateNotifierProvider<_ImageUploadStateNotifier,
    AsyncValue<VehicleResult?>>(
  (ref) => _ImageUploadStateNotifier(),
);
