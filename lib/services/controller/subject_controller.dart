import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Subject.dart';
import 'package:schooll/services/models/subject_model.dart';
import 'package:schooll/services/repository/subject_repo.dart';
import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class SubjectAdderController extends GetxController {
  static SubjectAdderController get instance => Get.find();

  final length = 0.obs;
  final deletedIndex = 0.obs;

  final profileLoading = false.obs;
  RxList<SubjectModel> subjectList = <SubjectModel>[].obs;
  Rx<SubjectModel> subject = SubjectModel.empty().obs;
  List<SubjectModel> filter = <SubjectModel>[];

  final subjectRepository = Get.put(SubjectRepository());

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController chaptersController = TextEditingController();
  final TextEditingController marksController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  String gradeValue = '';

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> deleteSubjectDataRecord(String id) async {
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
      await subjectRepository.deleteSubjectRecord(id);
      subjectList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(title: "Subject Deleted", message: "Record Deleted!", duration: 1);
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

  Future<void> saveSubjectDataRecord() async {
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

      // Save exam Record

      final subject = SubjectModel(
        teacherName: '',
        subject: subjectController.text,
        chapters: chaptersController.text,
        marks: marksController.text,
        idNumber: idNumberController.text,
        grade: gradeValue,
      );

      await subjectRepository.saveSubjectRecord(subject);
      KLoaders.successSnackBar(title: "Subject Record", message: "Record Added", duration: 1);
      marksController.text = '';
      idNumberController.text = '';
      gradeValue = '';
      Get.back();
      Get.off(const Subject());
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
  Future<void> fetchSubjectRecord(id) async {
    try {
      profileLoading.value = true;
      final subject = await subjectRepository.fetchSubjectData(id);
      this.subject(subject);
    } catch (e) {
      subject(SubjectModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchSubjectRecordByName(name) async {
    try {
      profileLoading.value = true;

      late String id = '';

      await fetchAllSubjectRecord();
      for (var element in subjectList) {
        if (element.subject.toString().trim() == name.toString().trim()) {
          id = element.idNumber;
        }
      }

      final subject = await subjectRepository.fetchSubjectData(id);
      this.subject(subject);
    } catch (e) {
      subject(SubjectModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllSubjectRecord() async {
    try {
      profileLoading.value = true;
      final subjectList = await subjectRepository.fetchAllSubjectData();
      this.subjectList(subjectList);
    } catch (e) {
      subjectList(SubjectModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }

// Get User Data
  Future<void> fetchAllSubjectRecordByGrade(grade) async {
    try {
      profileLoading.value = true;
      final subjectList = await subjectRepository.fetchAllSubjectDataByGrade(grade);
      this.subjectList(subjectList);
    } catch (e) {
      subjectList(SubjectModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }

  Future<void> updateSubjectTeacher(String techerNmae) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Updatin', duration: 2);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      await subjectRepository.updateSubjectRecord(techerNmae, subject.value.idNumber);
      KLoaders.successSnackBar(title: "Subject Updated", message: "Subject Teacher is Set");
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
}
