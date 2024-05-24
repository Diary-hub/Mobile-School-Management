// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class EmployeeModel {
  EmployeeModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.secondName,
    required this.birthdate,
    required this.address,
    required this.idNumber,
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
      'BirthDate': birthdate,
      'Address': address,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'IDNumber': idNumber,
      'Type': type,
    };
  }

  static EmployeeModel empty() => EmployeeModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        address: '',
        birthdate: '',
        idNumber: '',
        secondName: '',
        type: '',
      );

  static List<EmployeeModel> emptyList() => []; // Define the static method

  // Create a UserModel instance from a Map
  factory EmployeeModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return EmployeeModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        email: data['Email'] ?? '',
        address: data['Address'] ?? '',
        birthdate: data['BirthDate'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        secondName: data['SecondName'] ?? '',
        type: data['Type'] ?? '',
      );
    } else {
      return EmployeeModel.empty();
    }
  }
}
