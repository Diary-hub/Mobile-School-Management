import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherAttend.dart';
import 'package:schooll/services/models/Attendance_model.dart';
import 'package:schooll/services/repository/attend_repo.dart';
import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class AttendanceController extends GetxController {
  static AttendanceController get instance => Get.find();

  final length = 0.obs;
  final deletedIndex = 0.obs;
  final profileLoading = false.obs;
  RxList<AttendanceModel> attendanceList = <AttendanceModel>[].obs;
  Rx<AttendanceModel> attend = AttendanceModel.empty().obs;
  List<AttendanceModel> filter = <AttendanceModel>[];

  final attendanceRepository = Get.put(AttendanceRepository());

  String attendanceSubjectController = '';
  final TextEditingController gradeController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController studentController = TextEditingController();

  final TextEditingController dateOfAttendanceController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> deleteAttendanceDataRecord(String id) async {
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
      await attendanceRepository.deleteAttendanceRecord(id);
      attendanceList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(
          title: "Attendance Deleted", message: "Record Deleted!", duration: 1);
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> saveattendanceDataRecord() async {
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

      // Save attendance Record

      final attendance = AttendanceModel(
        dateOfAttendance: dateOfAttendanceController.text,
        startTime: startTimeController.text,
        endTime: endTimeController.text,
        grade: gradeController.text,
        studentName: studentController.text,
        subject: subjectController.text,
        isPermeted: false,
      );

      await attendanceRepository.saveAttendanceRecord(attendance);
      KLoaders.successSnackBar(title: "Attendance Record", message: "Record Added");
      attendanceSubjectController = '';
      dateOfAttendanceController.text = '';
      startTimeController.text = '';
      endTimeController.text = '';
      gradeController.text = '';
      studentController.text = '';
      subjectController.text = '';

      Get.back();
      Get.off(const TeacherAttendance());
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
  Future<void> fetchattendanceRecord(id) async {
    try {
      profileLoading.value = true;
      final attend = await attendanceRepository.fetchAttendanceData(id);
      this.attend(attend);
    } catch (e) {
      attend(AttendanceModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllattendanceRecord() async {
    try {
      profileLoading.value = true;
      final attendanceList = await attendanceRepository.fetchAllAttendanceData();
      this.attendanceList(attendanceList);
    } catch (e) {
      attendanceList(AttendanceModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }

  //Update
  Future<void> updateAttendPermet(bool isPermeted, String id) async {
    try {
      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      await attendanceRepository.updateAttendRecord(isPermeted, id);
      fetchAllattendanceRecord();
      KLoaders.successSnackBar(title: "Student Permeted", message: "Student Permeted", duration: 1);
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }
}
