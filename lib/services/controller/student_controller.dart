// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/Screens/Teacher_Seen/Marks.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/models/driver_model.dart';
import 'package:schooll/services/models/marks_model.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/repository/auth_repo.dart';
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
  Rx<StudentModel> studentUID = StudentModel.empty().obs;
  Rx<MarksModel> marks = MarksModel.empty().obs;

  RxList<MarksModel> marksList = <MarksModel>[].obs;
  Rx<StudentModel> studentEdit = StudentModel.empty().obs;

  final studentRepository = Get.put(StudentRepository());

  GlobalKey<FormState> formkey2 = GlobalKey<FormState>();

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
  final TextEditingController genderController = TextEditingController();

  final TextEditingController dailyOneController = TextEditingController();
  final TextEditingController dailyTwoController = TextEditingController();
  final TextEditingController midtermExamController = TextEditingController();
  final TextEditingController finalExamController = TextEditingController();

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

      await AuthenticationRepository.instance.logoutNew();
      await AuthenticationRepository.instance.loginWithEmailAndPasswordSaved();

      final student = StudentModel(
        id: studentAuth.user!.uid,
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
        gender: genderController.text,
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
        gender: genderController.text,
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
  Future<void> fetchStudentRecordByUID(id) async {
    try {
      profileLoading.value = true;
      final student = await studentRepository.fetchStudentData(id);
      studentUID(student);
    } catch (e) {
      student(StudentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> updateStudent(
      DriverModel driver, StudentModel user, Map<String, dynamic> json) async {
    try {
      profileLoading.value = true;
      await studentRepository.updateStudentRecord(driver, user, json);
      KLoaders.successSnackBar(title: "Student Updated", message: "Record Updated", duration: 1);
    } catch (e) {
      student(StudentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> saveStudentMarks(subject) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Recording Student', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      final marks = MarksModel(
          dailyOne: dailyOneController.text,
          dailyTwo: dailyTwoController.text,
          midtermExam: midtermExamController.text,
          finalExam: finalExamController.text);

      await studentRepository.saveStudentRecordMarks(marks, studentEdit.value.id, subject);
      KLoaders.successSnackBar(title: "Student Marks", message: "Record Updated", duration: 1);
      Get.to(() => const MarksScreen());
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
  Future<void> fetchStudentRecordBySubject(subjectName) async {
    try {
      profileLoading.value = true;
      final marks =
          await studentRepository.fetchStudentDataBySubject(subjectName, studentEdit.value.id);
      this.marks(marks);
      dailyOneController.text = marks.dailyOne;
      dailyTwoController.text = marks.dailyTwo;
      midtermExamController.text = marks.midtermExam;
      finalExamController.text = marks.finalExam;
    } catch (e) {
      student(StudentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchStudentRecordBySubjectID(subjectName, id) async {
    try {
      profileLoading.value = true;
      final marks = await studentRepository.fetchStudentDataBySubject(subjectName, id);
      this.marks(marks);
      dailyOneController.text = marks.dailyOne;
      dailyTwoController.text = marks.dailyTwo;
      midtermExamController.text = marks.midtermExam;
      finalExamController.text = marks.finalExam;
    } catch (e) {
      student(StudentModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<StudentModel> fetchByChangeIDtoUID(id) async {
    try {
      profileLoading.value = true;
      final StudentModel student = await studentRepository.fetchByChangeIDtoUID(id);
      return student;
    } catch (e) {
      return StudentModel.empty();
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

  // Get User Data
  Future<void> fetchAllStudentRecordByGrade(DriverModel driver) async {
    try {
      profileLoading.value = true;
      final studentList = await studentRepository.fetchAllStudentDataByGrade(driver.grade);

      final students = studentList.where((student) {
        for (var driverStudent in driver.students) {
          if (student.id == driverStudent.id) {
            return false;
          }
        }
        return true;
      });
      this.studentList(students.toList());
    } catch (e) {
      studentList(StudentModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
