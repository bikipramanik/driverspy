class VehicleDetail {
  final String? vehicleNo;
  final String? chassisNumber;
  final String? engineNumber;
  final String? fitnessCertificateValidity;
  final String? insuranceValidity;
  final String? manufacturer;
  final String? model;
  final String? ownerName;
  final String? pucValidity;
  final String? registrationDate;
  final String? registrationState;
  final String? vehicleType;

  VehicleDetail({
    required this.vehicleNo,
    required this.chassisNumber,
    required this.registrationState,
    required this.registrationDate,
    required this.pucValidity,
    required this.ownerName,
    required this.model,
    required this.manufacturer,
    required this.insuranceValidity,
    required this.fitnessCertificateValidity,
    required this.engineNumber,
    required this.vehicleType,
  });

  factory VehicleDetail.fromJson(Map<String, dynamic> json) {
    return VehicleDetail(
      chassisNumber: json["chassisNumber"] ?? "Unknown",
      registrationState: json["registrationState"] ?? "Unknown",
      registrationDate: json["registrationDate"] ?? "Unknown",
      pucValidity: json["pucValidity"] ?? "Unknown",
      ownerName: json["ownerName"] ?? "Unknown",
      model: json["model"] ?? "Unknown",
      manufacturer: json["manufacturer"] ?? "Unknown",
      insuranceValidity: json["insuranceValidity"] ?? "Unknown",
      fitnessCertificateValidity:
          json["fitnessCertificateValidity"] ?? "Unknown",
      engineNumber: json["engineNumber"] ?? "Unknown",
      vehicleNo: json["vehicleNo"] ?? "Unknown",
      vehicleType: json["vehicleType"] ?? "Unknown",
    );
  }
}

class VehicleResult {
  final String vehicleNo;
  final VehicleDetail? vehicleDetail;

  VehicleResult({
    required this.vehicleNo,
    this.vehicleDetail,
  });
}
