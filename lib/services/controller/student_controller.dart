// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/repository/student_repo.dart';

import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class StudentController extends GetxController {
  static StudentController get instance => Get.find();

  final deletedIndex = 0.obs;
  final length = 0.obs;
  final profileLoading = false.obs;
  RxList<StudentModel> studentList = <StudentModel>[].obs;
  List<StudentModel> filter = <StudentModel>[];
  Rx<StudentModel> student = StudentModel.empty().obs;

  final studentRepository = Get.put(StudentRepository());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController whoLivesWithController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  Future<void> deleteStudentDataRecord(String id) async {
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
      await studentRepository.deleteStudentRecord(id);
      studentList.removeAt(deletedIndex.value);
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

  Future<void> recordStudentDataRecord() async {
    final parentController = ParentController.instance;

    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Recording Student', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      UserCredential studentAuth = await studentRepository.registerWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);

      final student = StudentModel(
        id: studentAuth.user.uid,
        type: 'Student',
        parentUID: parentController.parent.value.id!,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        secondName: secondNameController.text,
        birthdate: birthdateController.text,
        address: addressController.text,
        idNumber: idNumberController.text,
        livesWith: whoLivesWithController.text,
        grade: gradeController.text,
      );

      // Save Student Record
      await studentRepository.saveStudentRecord(student);
      KLoaders.successSnackBar(title: "Student Record", message: "Record Added", duration: 1);
      gradeController.text = '';
      whoLivesWithController.text = '';
      // idNumberController.text = '';
      addressController.text = '';
      birthdateController.text = '';
      secondNameController.text = '';
      emailController.text = '';
      emailController.text = '';
      phoneController.text = '';
      lastNameController.text = '';
      firstNameController.text = '';
      // Get.back();
      // Get.off(ParSignUp(
      //   studentIDNumber: idNumberController.text,
      // ));
    } catch (e) {
      // This is I Think The Empty Error
      print(e);
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> saveStudentDataRecord() async {
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
      // if (formkey2.currentState!.validate() != true) {
      //   KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");

      //   return;
      // }

      // Save Student Record

      final student = StudentModel(
        type: 'Student',
        parentUID: '',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        secondName: secondNameController.text,
        birthdate: birthdateController.text,
        address: addressController.text,
        idNumber: idNumberController.text,
        livesWith: whoLivesWithController.text,
        grade: gradeController.text,
      );

      this.student.value = student;
      Get.to(ParSignUp(
        studentIDNumber: idNumberController.text,
      ));
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
  Future<void> fetchStudentRecord(id) async {
    try {
      profileLoading.value = true;
      final student = await studentRepository.fetchStudentData(id);
      this.student(student);
    } catch (e) {
      student(StudentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllStudentRecord() async {
    try {
      profileLoading.value = true;
      final studentList = await studentRepository.fetchAllStudentData();
      this.studentList(studentList);
    } catch (e) {
      studentList(StudentModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
