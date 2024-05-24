// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Tacher.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/models/teacher_model.dart';
import 'package:schooll/services/repository/auth_repo.dart';
import 'package:schooll/services/repository/teacher_repo.dart';
import 'package:schooll/services/utils/helpers/network.dart';
import 'package:schooll/services/utils/loaders/snack_loaders.dart';

class TeacherController extends GetxController {
  static TeacherController get instance => Get.find();

  final deletedIndex = 0.obs;
  final length = 0.obs;
  final profileLoading = false.obs;
  RxList<TeacherModel> teacherList = <TeacherModel>[].obs;
  RxList<TeacherModel> filter = <TeacherModel>[].obs;
  Rx<TeacherModel> teacher = TeacherModel.empty().obs;

  final teacherRepository = Get.put(TeacherRepository());

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
  String gradeController = '';
  String subjectController = '';
  String departmentController = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> deleteTeacherDataRecord(String id) async {
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
      await teacherRepository.deleteTeacherRecord(id);
      teacherList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(title: "Teacher Deleted", message: "Record Deleted!");
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> saveTeacherDataRecord() async {
    final subjectController1 = SubjectAdderController.instance;

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
      if (formkey.currentState!.validate() != true) {
        KLoaders.errorSnackBar(
            title: "Something Wrong !", message: "Please Fill The Informations", duration: 1);

        return;
      }

      UserCredential teacherAuth = await teacherRepository.registerWithEmailAndPassword(
          emailController.text.trim(), passwordController.text);

      await AuthenticationRepository.instance.logoutNew();
      await AuthenticationRepository.instance.loginWithEmailAndPasswordSaved();

      // Save Teacher Record
      final teacher = TeacherModel(
        subject: subjectController,
        id: teacherAuth.user!.uid,
        type: 'Teacher',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phoneNumber: phoneController.text,
        email: emailController.text,
        secondName: secondNameController.text,
        birthdate: birthdateController.text,
        address: addressController.text,
        idNumber: idNumberController.text,
        livesWith: whoLivesWithController.text,
        grade: gradeController,
        department: departmentController,
      );

      await subjectController1.fetchSubjectRecordByName(subjectController);
      await subjectController1.updateSubjectTeacher(teacher.getFulltName);

      await teacherRepository.saveTeacherRecord(teacher);
      KLoaders.successSnackBar(title: "Teacher Record", message: "Record Added");
      gradeController = '';
      whoLivesWithController.text = '';
      idNumberController.text = '';
      addressController.text = '';
      birthdateController.text = '';
      secondNameController.text = '';
      emailController.text = '';
      emailController.text = '';
      phoneController.text = '';
      lastNameController.text = '';
      firstNameController.text = '';
      Get.offAll(const Teacher());
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

  // Get User Data-=-=-=-=
  Future<void> fetchTeacherRecord(id) async {
    try {
      profileLoading.value = true;
      final teacher = await teacherRepository.fetchTeacherData(id);
      this.teacher(teacher);
    } catch (e) {
      teacher(TeacherModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllTeacherRecord() async {
    try {
      profileLoading.value = true;
      final teachertList = await teacherRepository.fetchAllTeachersData();
      teacherList(teachertList);
    } catch (e) {
      teacherList(TeacherModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
