import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Exam/Exam_Rseult.dart';
import 'package:schooll/Screens/Teacher_Seen/Exam.dart';
import 'package:schooll/services/controller/user_controller.dart';
import 'package:schooll/services/models/exam_model.dart';
import 'package:schooll/services/models/user_model.dart';
import 'package:schooll/services/repository/exam_repo.dart';
import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class ExamAdderController extends GetxController {
  static ExamAdderController get instance => Get.find();

  final length = 0.obs;
  final deletedIndex = 0.obs;
  final profileLoading = false.obs;
  RxList<ExamModel> examList = <ExamModel>[].obs;
  Rx<ExamModel> exam = ExamModel.empty().obs;
  List<ExamModel> filter = <ExamModel>[];

  final examRepository = Get.put(ExamRepository());

  String examSubjectController = '';
  String gradeController = '';
  final TextEditingController startChapterController = TextEditingController();
  final TextEditingController endChapterController = TextEditingController();
  final TextEditingController dateOfExamController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  String selectedMode = '';

  String getUserType() {
    final auth = UserController.instance;
    UserModel user = auth.user.value;

    return user.type;
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> deleteExamDataRecord(String id) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Deleting', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Delete Record
      await examRepository.deleteExamRecord(id);
      examList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(title: "Exam Deleted", message: "Record Deleted!", duration: 1);
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> saveexamDataRecord(String type) async {
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
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");

        return;
      }

      // Save exam Record

      // ignore: prefer_conditional_assignment
      if (selectedMode == null) {
        selectedMode = 'Admin';
      }

      final exam = ExamModel(
        mode: selectedMode,
        examSubject: examSubjectController,
        startChapter: startChapterController.text,
        endChapter: endChapterController.text,
        dateOfExam: dateOfExamController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        marks: marksController.text,
        idNumber: idNumberController.text,
        grade: gradeController,
      );

      await examRepository.saveExamRecord(exam);
      KLoaders.successSnackBar(title: "Exam Record", message: "Record Added");
      examSubjectController = '';
      startChapterController.text = '';
      endChapterController.text = '';
      dateOfExamController.text = '';
      startTimeController.text = '';
      endTimeController.text = '';
      marksController.text = '';
      idNumberController.text = '';
      gradeController = '';
      Get.back();
      if (type == "Teacher") {
        Get.off(const ExamTeacher());
      } else {
        Get.off(const ExamResult());
      }
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
  Future<void> fetchexamRecord(id) async {
    try {
      profileLoading.value = true;
      final exam = await examRepository.fetchExamData(id);
      this.exam(exam);
    } catch (e) {
      exam(ExamModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllexamRecord() async {
    try {
      profileLoading.value = true;
      final examList = await examRepository.fetchAllExamData();
      this.examList(examList);
    } catch (e) {
      examList(ExamModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
