// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectModel {
  SubjectModel({
    this.id,
    required this.subject,
    required this.marks,
    required this.grade,
    required this.idNumber,
    required this.chapters,
    required this.teacherName,
  });

  final String? id;
  final String subject;
  final String chapters;
  final String marks;
  final String grade;
  final String teacherName;
  final String idNumber;

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'Marks': marks,
      'Grade': grade,
      "IDNumber": idNumber,
      "Chapters": chapters,
      "TeacherName": teacherName,
    };
  }

  static List<SubjectModel> emptyList() => []; // Define the static method

  static SubjectModel empty() => SubjectModel(
        id: '',
        subject: '',
        chapters: '',
        marks: '',
        grade: '',
        idNumber: '',
        teacherName: '',
      );

  // Create a UserModel instance from a Map
  factory SubjectModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return SubjectModel(
        id: document.id,
        subject: data['subject'] ?? '',
        marks: data['Marks'] ?? '',
        grade: data['Grade'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        chapters: data['Chapters'] ?? '',
        teacherName: data['TeacherName'] ?? '',
      );
    } else {
      return SubjectModel.empty();
    }
  }
}
