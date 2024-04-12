// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamModel {
  ExamModel({
    this.id,
    required this.examSubject,
    required this.startChapter,
    required this.endChapter,
    required this.dateOfExam,
    required this.startTime,
    required this.endTime,
    required this.marks,
    required this.grade,
    required this.idNumber,
    required this.mode,
  });

  final String? id;
  final String examSubject;
  final String startChapter;
  final String endChapter;
  final String dateOfExam;
  final String startTime;
  final String endTime;
  final String marks;
  final String grade;
  final String idNumber;
  final String mode;

  String get getDate => dateOfExam;
  String get getDurattion => "$startTime-$endTime";
  String get getChapters => "$startChapter-$endChapter";

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'ExamSubject': examSubject,
      'StartChapter': startChapter,
      'EndChapter': endChapter,
      'DateOfExam': dateOfExam,
      'StartTime': startTime,
      'EndTime': endTime,
      'Marks': marks,
      'Grade': grade,
      "IDNumber": idNumber,
      "Mode": mode,
    };
  }

  static List<ExamModel> emptyList() => []; // Define the static method

  static ExamModel empty() => ExamModel(
        id: '',
        examSubject: '',
        startChapter: '',
        endChapter: '',
        dateOfExam: '',
        startTime: '',
        endTime: '',
        marks: '',
        grade: '',
        idNumber: '',
        mode: '',
      );

  // Create a UserModel instance from a Map
  factory ExamModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ExamModel(
        id: document.id,
        examSubject: data['ExamSubject'] ?? '',
        startChapter: data['StartChapter'] ?? '',
        endChapter: data['EndChapter'] ?? '',
        dateOfExam: data['DateOfExam'] ?? '',
        startTime: data['StartTime'] ?? '',
        endTime: data['EndTime'] ?? '',
        marks: data['Marks'] ?? '',
        grade: data['Grade'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        mode: data['Mode'] ?? '',
      );
    } else {
      return ExamModel.empty();
    }
  }
}
