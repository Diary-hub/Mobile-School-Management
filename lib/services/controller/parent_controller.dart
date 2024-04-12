// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Student.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/models/parent_model.dart';
import 'package:schooll/services/repository/parent_repo.dart';

import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class ParentController extends GetxController {
  static ParentController get instance => Get.find();

  final profileLoading = false.obs;
  RxList<ParentModel> parentList = <ParentModel>[].obs;
  Rx<ParentModel> parent = ParentModel.empty().obs;

  final parentRepository = Get.put(ParentRepository());
  final studentController = StudentController.instance;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController studentIDNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey1 = GlobalKey<FormState>();

  Future<void> saveParentDataRecord() async {
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

      // Save Parent Record

      UserCredential parentsData = await parentRepository.registerWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);

      final parent = ParentModel(
        type: 'Parent',
        id: parentsData.user.uid!,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text.trim(),
        secondName: secondNameController.text,
        birthdate: birthdateController.text,
        address: addressController.text,
        idNumber: idNumberController.text,
        studentIDNumber: studentIDNumberController.text,
        password: passwordController.text,
      );
      this.parent.value = parent;
      await parentRepository.saveParentRecord(parent);

      KLoaders.successSnackBar(title: "Parent Record", message: "Record Added", duration: 1);
      await studentController.recordStudentDataRecord();
      secondNameController.text = '';
      idNumberController.text = '';
      addressController.text = '';
      birthdateController.text = '';
      secondNameController.text = '';
      emailController.text = '';
      emailController.text = '';
      phoneController.text = '';
      lastNameController.text = '';
      firstNameController.text = '';
      Get.back();
      Get.off(const Student());
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

  // Get User Data
  Future<void> fetchParentRecord(id) async {
    try {
      profileLoading.value = true;
      final parent = await parentRepository.fetchParentData(id);
      this.parent(parent);
    } catch (e) {
      parent(ParentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllParentRecord() async {
    try {
      profileLoading.value = true;
      final parentList = await parentRepository.fetchAllParentData();
      this.parentList(parentList);
    } catch (e) {
      parentList(ParentModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
