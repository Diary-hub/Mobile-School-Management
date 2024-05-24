// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schooll/Screens/home.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/models/driver_model.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/repository/auth_repo.dart';
import 'package:schooll/services/repository/driver_repo.dart';
import 'package:schooll/services/utils/helpers/network.dart';
import 'package:schooll/services/utils/loaders/snack_loaders.dart';

class DriverController extends GetxController {
  static DriverController get instance => Get.find();

  final profileLoading = false.obs;

  final deletedIndex = 0.obs;
  final length = 0.obs;
  RxList<DriverModel> driverList = <DriverModel>[].obs;
  List<DriverModel> filter = <DriverModel>[];
  Rx<DriverModel> driver = DriverModel.empty().obs;

  final DriverRepository driverRepository = Get.put(DriverRepository());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  final TextEditingController carBrandController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController carNumberController = TextEditingController();

  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

  Future<void> saveDriverDataRecord() async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Saving', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Validate The Data
      if (formkey1.currentState!.validate() != true) {
        KLoaders.errorSnackBar(
            title: "Something Wrong !", message: "Please Fill The Informations", duration: 1);

        return;
      }

      // Save Driver Record

      UserCredential driversData = await driverRepository.registerWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);
      await AuthenticationRepository.instance.logoutNew();
      await AuthenticationRepository.instance.loginWithEmailAndPasswordSaved();

      final driver = DriverModel(
        type: 'Driver',
        id: driversData.user!.uid,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text.trim(),
        secondName: secondNameController.text,
        address: addressController.text,
        idNumber: idNumberController.text,
        carBrand: carBrandController.text,
        carModel: carModelController.text,
        carNumber: carNumberController.text,
        grade: gradeController.text,
      );
      this.driver.value = driver;
      await driverRepository.saveDriverRecord(driver);

      KLoaders.successSnackBar(title: "Driver Record", message: "Record Added", duration: 1);
      resetFields();
      Get.back();
      Get.off(const Home());
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(
            title: "Something Wrong !", message: "Please Fill The Informations", duration: 1);
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  void resetFields() {
    secondNameController.text = '';
    idNumberController.text = '';
    addressController.text = '';
    secondNameController.text = '';
    emailController.text = '';
    emailController.text = '';
    phoneController.text = '';
    lastNameController.text = '';
    firstNameController.text = '';
    passwordController.text = '';
    carBrandController.text = '';
    carModelController.text = '';
    carNumberController.text = '';
    gradeController.text = '';
  }

  // Get User Data
  Future<void> fetchDriverRecord(id) async {
    try {
      profileLoading.value = true;
      final driver = await driverRepository.fetchDriverData(id);
      this.driver(driver);
    } catch (e) {
      driver(DriverModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateStudentPick(DriverModel driverr, StudentModel student, LatLng location) async {
    try {
      await StudentController.instance.updateStudent(driverr, student, {
        "PickLat": location.latitude.toString(),
        "PickLong": location.longitude.toString(),
      });
    } catch (e) {
      driver(DriverModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateStudentDrop(DriverModel driverr, StudentModel student, LatLng location) async {
    try {
      await StudentController.instance.updateStudent(driverr, student, {
        "DropLat": location.latitude.toString(),
        "DropLong": location.longitude.toString(),
      });
    } catch (e) {
      driver(DriverModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> deleteDriverDataRecord(String id) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Deleting', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Save Student Record
      await driverRepository.deleteDriverRecord(id);
      driverList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(title: "Driver Deleted", message: "Record Deleted!");
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> deleteDriverStudent(String id, DriverModel driver, int deletedIndex) async {
    try {
      // Save Student Record
      await driverRepository.deleteDriverStudent(driver, id);
      driver.students.removeAt(deletedIndex);
      KLoaders.successSnackBar(title: "Student Deleted", message: "Record Deleted!");
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> addStudentToDriver(DriverModel driver, StudentModel student, index) async {
    try {
      // Save Student Record
      await driverRepository.addStudentToDriver(driver, student);
      KLoaders.successSnackBar(title: "Student Added", message: "Record Deleted!");
      StudentController.instance.studentList.removeAt(index);
      DriverController.instance.fetchDriverStudents(driver);
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  // Get User Data
  Future<void> fetchDriverStudents(DriverModel driver) async {
    try {
      profileLoading.value = true;
      print('11');
      final driverList = await driverRepository.fetchDriverStudents(driver);

      driver.students(driverList);
    } catch (e) {
      driver.students(StudentModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllDriverRecord() async {
    try {
      profileLoading.value = true;
      final driverList = await driverRepository.fetchAllDriverData();
      this.driverList(driverList);
    } catch (e) {
      driverList(DriverModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
