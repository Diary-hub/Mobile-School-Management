// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/utils/device/device_utility.dart';

class StudentViewMap extends StatefulWidget {
  final StudentModel student;

  const StudentViewMap({
    super.key,
    required this.student,
  });

  @override
  State<StudentViewMap> createState() => _StudentViewMapState();
}

class _StudentViewMapState extends State<StudentViewMap> {
  Location locationControler = Location();
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locations',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: widget.student.getPickLocation == null || widget.student.getDropLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onTap: (argument) {
                KDeviceUtils.hideKeyboard(context);
              },
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: widget.student.getPickLocation!,
                zoom: 17,
              ),
              markers: {
                Marker(
                    markerId: const MarkerId('PickLocation'),
                    infoWindow: const InfoWindow(title: "Pick Up Location"),
                    position: widget.student.getPickLocation!),
                Marker(
                    markerId: const MarkerId('DropLocation'),
                    infoWindow: const InfoWindow(title: "Drop Down Location"),
                    position: widget.student.getDropLocation!),
              },
            ),
    );
  }
}
