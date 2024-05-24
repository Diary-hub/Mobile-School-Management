// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class DriverModel {
  DriverModel({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.idNumber,
    required this.email,
    required this.grade,
    required this.carBrand,
    required this.carModel,
    required this.carNumber,
    required this.type,
  });

  final String id;
  final String firstName;
  final String secondName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String idNumber;
  final String email;
  final String grade;
  final String carBrand;
  final String carModel;
  final String carNumber;
  final String type;

  RxList<StudentModel> students = <StudentModel>[].obs;

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
      'Email': email,
      'Grade': grade,
      'Type': type,
    };
  }

  static List<DriverModel> emptyList() => []; // Define the static method

  static DriverModel empty() => DriverModel(
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        address: '',
        idNumber: '',
        secondName: '',
        type: '',
        email: '',
        carBrand: '',
        carModel: '',
        carNumber: '',
        grade: '',
      );

  // Create a UserModel instance from a Map
  factory DriverModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return DriverModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        address: data['Address'] ?? '',
        idNumber: data['IDNumber'] ?? '',
        secondName: data['SecondName'] ?? '',
        type: data['Type'] ?? '',
        email: data['Email'] ?? '',
        carBrand: data['CarBrand'] ?? '',
        carModel: data['CarModel'] ?? '',
        carNumber: data['CarNumber'] ?? '',
        grade: data['Grade'] ?? '',
      );
    } else {
      return DriverModel.empty();
    }
  }
}
