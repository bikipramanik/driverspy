class VehicleDetail {
  final String vehicleNo;
  final String chassisNumber;
  final String engineNumber;
  final String fitnessCertificateValidity;
  final String insuranceValidity;
  final String manufacturer;
  final String model;
  final String ownerName;
  final String pucValidity;
  final String registrationDate;
  final String registrationState;

  final String vehicleType;

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
      chassisNumber: json["chassisNumber"],
      registrationState: json["registrationState"],
      registrationDate: json["registrationDate"],
      pucValidity: json["pucValidity"],
      ownerName: json["ownerName"],
      model: json["model"],
      manufacturer: json["manufacturer"],
      insuranceValidity: json["insuranceValidity"],
      fitnessCertificateValidity: json["fitnessCertificateValidity"],
      engineNumber: json["engineNumber"],
      vehicleNo: json["vehicleNo"],
      vehicleType: json["vehicleType"],
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
