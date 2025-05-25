import 'package:driverspy/utils/vehicle_detail.dart';
import 'package:driverspy/widgets/vehicle_detail_widgets/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen(
      {super.key, required this.vehicleNo, this.vehicleDetail});
  final String vehicleNo;

  final VehicleDetail? vehicleDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Vehicle Details",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF2E3A59),
      ),
      backgroundColor: const Color(0xFF1F2633),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: const Color(0xFF2E3A59),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                children: vehicleDetail != null
                    ? [
                        InfoTile(
                          icon: Icons.directions_car,
                          title: "Vehicle No:",
                          value: vehicleNo,
                        ),
                        InfoTile(
                          icon: Icons.category,
                          title: "Vehicle Type:",
                          value: vehicleDetail?.vehicleType ?? "UNKNOWN" ,
                        ),
                        InfoTile(
                          icon: Icons.location_on,
                          title: "Registration State:",
                          value: vehicleDetail?.registrationState ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.business,
                          title: "Manufacturer:",
                          value: vehicleDetail?.manufacturer ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.directions_car_filled,
                          title: "Model:",
                          value: vehicleDetail?.model ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.person,
                          title: "Owner Name:",
                          value: vehicleDetail?.ownerName ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.date_range,
                          title: "Registration Date:",
                          value: vehicleDetail?.registrationDate ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.shield,
                          title: "Insurance Validity:",
                          value: vehicleDetail?.insuranceValidity ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.eco,
                          title: "PUC Validity:",
                          value: vehicleDetail?.pucValidity ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.fitness_center,
                          title: "Fitness Certificate Validity:",
                          value: vehicleDetail?.fitnessCertificateValidity ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.settings,
                          title: "Chassis Number (Partial):",
                          value: vehicleDetail?.chassisNumber ?? "UNKNOWN",
                        ),
                        InfoTile(
                          icon: Icons.settings_applications,
                          title: "Engine Number (Partial):",
                          value: vehicleDetail?.engineNumber ?? "UNKNOWN",
                        ),
                      ]
                    : [
                        InfoTile(
                          icon: Icons.directions_car,
                          title: "Vehicle No:",
                          value: vehicleNo,
                        ),
                        Center(
                          child:
                              Text("No Data available for this vehicle number"),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
