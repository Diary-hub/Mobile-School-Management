// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:schooll/services/controller/driver_controller.dart';
import 'package:schooll/services/models/driver_model.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/utils/device/device_utility.dart';

class MapDriver extends StatefulWidget {
  final StudentModel student;
  final DriverModel driver;
  const MapDriver({super.key, required this.student, required this.driver});

  @override
  State<MapDriver> createState() => _MapDriverState();
}

class _MapDriverState extends State<MapDriver> {
  Location locationControler = Location();
  LatLng? currentLocation;

  GoogleMapController? mapController;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await locationControler.serviceEnabled();

    if (serviceEnabled) {
      serviceEnabled = await locationControler.requestService();
    } else {
      return;
    }

    permissionGranted = await locationControler.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationControler.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        return;
      }
    }

    locationControler.onLocationChanged.listen((LocationData current) {
      if (current.latitude != null && current.longitude != null) {
        setState(() {
          currentLocation = LatLng(current.latitude!, current.longitude!);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final driverController = DriverController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locations',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              onTap: (argument) {
                KDeviceUtils.hideKeyboard(context);
              },
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 17,
              ),
              markers: {
                Marker(markerId: const MarkerId('CurrectLoatin'), position: currentLocation!)
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              driverController.updateStudentPick(widget.driver, widget.student, currentLocation!);
            } else {
              driverController.updateStudentDrop(widget.driver, widget.student, currentLocation!);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Pick Up"),
            BottomNavigationBarItem(icon: Icon(Icons.download_sharp), label: "Drop Down"),
          ]),
    );
  }
}
