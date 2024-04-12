// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class ParentModel {
  ParentModel({
    this.id,
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.birthdate,
    required this.address,
    required this.idNumber,
    required this.studentIDNumber,
    required this.type,
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
  final String studentIDNumber;
  final String type;
  final String? password;

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
      'StudentIDNumber': studentIDNumber,
      'Type': type,
    };
  }

  static List<ParentModel> emptyList() => []; // Define the static method

  static ParentModel empty() => ParentModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        address: '',
        birthdate: '',
        idNumber: '',
        secondName: '',
        password: '',
        studentIDNumber: '',
        type: '',
      );

  // Create a UserModel instance from a Map
  factory ParentModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() != null) {
      final data = document.data()!;
      return ParentModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        email: data['Email'] ?? '',
        address: data['Address'] ?? '',
        birthdate: data['BirthDate'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        secondName: data['SecondName'] ?? '',
        studentIDNumber: data['StudentIDNumber'] ?? '',
        type: data['type'] ?? '',
      );
    } else {
      return ParentModel.empty();
    }
  }
}
