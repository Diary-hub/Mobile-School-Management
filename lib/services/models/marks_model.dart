// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class MarksModel {
  MarksModel({
    this.id,
    required this.dailyOne,
    required this.dailyTwo,
    required this.midtermExam,
    required this.finalExam,
  });

  final String? id;
  final String dailyOne;
  final String dailyTwo;
  final String midtermExam;
  final String finalExam;

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'DailyOne': dailyOne,
      'DailyTwo': dailyTwo,
      'MidtermExam': midtermExam,
      'FinalExam': finalExam,
    };
  }

  static List<MarksModel> emptyList() => []; // Define the static method

  static MarksModel empty() => MarksModel(
        id: '',
        dailyOne: '',
        dailyTwo: '',
        midtermExam: '',
        finalExam: '',
      );

  // Create a UserModel instance from a Map
  factory MarksModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return MarksModel(
        id: document.id,
        dailyOne: data['DailyOne'] ?? '',
        dailyTwo: data['DailyTwo'] ?? '',
        midtermExam: data['MidtermExam'] ?? '',
        finalExam: data['FinalExam'] ?? '',
      );
    } else {
      return MarksModel.empty();
    }
  }
}
