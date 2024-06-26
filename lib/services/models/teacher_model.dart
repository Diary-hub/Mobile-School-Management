// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class TeacherModel {
  TeacherModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.secondName,
    required this.birthdate,
    required this.address,
    required this.idNumber,
    required this.livesWith,
    required this.grade,
    required this.subject,
    required this.type,
    required this.department,
  });

  final String? id;
  final String firstName;
  final String secondName;
  final String lastName;
  final String birthdate;
  final String address;
  final String phoneNumber;
  final String email;
  final String idNumber;
  final String livesWith;
  final String grade;
  final String subject;
  final String type;
  final String department;

  String get getFirstName => firstName;
  String get getlastName => lastName;
  String get getFulltName => "$firstName $secondName $lastName";

  String get getPhoneNumber => KFormatter.formatPhoneNumber(phoneNumber);

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'SecondName': secondName,
      'LastName': lastName,
      'BirthDate': birthdate,
      'Address': address,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'IDNumber': idNumber,
      'LivesWith': livesWith,
      'Grade': grade,
      'Type': type,
      'Subject': subject,
      'Department': department
    };
  }

  static List<TeacherModel> emptyList() => []; // Define the static method

  static TeacherModel empty() => TeacherModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        address: '',
        birthdate: '',
        grade: '',
        idNumber: '',
        livesWith: '',
        secondName: '',
        subject: '',
        type: '',
        department: '',
      );

  // Create a UserModel instance from a Map
  factory TeacherModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return TeacherModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        email: data['Email'] ?? '',
        address: data['Address'] ?? '',
        birthdate: data['BirthDate'] ?? '',
        grade: data['Grade'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        livesWith: data['LivesWith'] ?? '',
        secondName: data['SecondName'] ?? '',
        type: data['Type'] ?? '',
        subject: data['Subject'] ?? '',
        department: data['Department'] ?? '',
      );
    } else {
      return TeacherModel.empty();
    }
  }
}
