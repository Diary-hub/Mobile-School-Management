// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class TeacherModel {
  TeacherModel({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.idNumber,
    required this.type,
  });

  final String id;
  final String firstName;
  final String secondName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String idNumber;
  final String type;

  String get getFirstName => firstName;
  String get getlastName => lastName;
  String get getFulltName => "$firstName $lastName";

  String get getPhoneNumber => KFormatter.formatPhoneNumber(phoneNumber);

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'SecondName': secondName,
      'LastName': lastName,
      'Address': address,
      'PhoneNumber': phoneNumber,
      'IDNumber': idNumber,
      'Type': type,
    };
  }

  static TeacherModel empty() => TeacherModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        address: '',
        idNumber: '',
        secondName: '',
        type: '',
      );

  // Create a UserModel instance from a Map
  factory TeacherModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() != null) {
      final data = document.data()!;
      return TeacherModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        address: data['Address'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        secondName: data['SecondName'] ?? '',
        type: data['Type'] ?? '',
      );
    } else {
      return TeacherModel.empty();
    }
  }
}
