// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  AttendanceModel({
    this.id,
    required this.dateOfAttendance,
    required this.startTime,
    required this.endTime,
    required this.grade,
    required this.subject,
    required this.studentName,
    required this.isPermeted,
    required this.parentUID,
  });

  final String? id;
  final String startTime;
  final String endTime;
  final String dateOfAttendance;
  final String grade;
  final String subject;
  final String studentName;
  final bool isPermeted;
  final String parentUID;

  String get getDate => dateOfAttendance;
  String get getDurattion => "$startTime-$endTime";

  // Convert the AttendanceModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'DateOfAttendance': dateOfAttendance,
      'StartTime': startTime,
      'EndTime': endTime,
      'Grade': grade,
      'Subject': subject,
      'StudentName': studentName,
      'IsPermeted': isPermeted,
      'ParentUID': parentUID,
    };
  }

  static List<AttendanceModel> emptyList() => []; // Define the static method

  static AttendanceModel empty() => AttendanceModel(
        id: '',
        dateOfAttendance: '',
        startTime: '',
        endTime: '',
        grade: '',
        subject: '',
        parentUID: '',
        studentName: '',
        isPermeted: false,
      );

  // Create a AttendanceModel instance from a Map
  factory AttendanceModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AttendanceModel(
        id: document.id,
        dateOfAttendance: data['DateOfAttendance'] ?? '',
        startTime: data['StartTime'] ?? '',
        endTime: data['EndTime'] ?? '',
        grade: data['Grade'] ?? '',
        subject: data['Subject'] ?? '',
        studentName: data['StudentName'] ?? '',
        isPermeted: data['IsPermeted'] ?? '',
        parentUID: data['ParentUID'] ?? '',
      );
    } else {
      return AttendanceModel.empty();
    }
  }
}
