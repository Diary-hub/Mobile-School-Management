import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class StudentModel {
  StudentModel({
    this.id,
    this.pickLat,
    this.pickLong,
    this.dropLat,
    this.dropLong,
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
    required this.type,
    required this.gender,
    required this.parentUID,
  });

  final String? id;
  final String? pickLat;
  final String? pickLong;
  final String? dropLat;
  final String? dropLong;
  final String firstName;
  final String secondName;
  final String lastName;
  final String birthdate;
  final String gender;
  final String address;
  final String phoneNumber;
  final String email;
  final String idNumber;
  final String livesWith;
  final String grade;
  final String type;
  String? parentUID;

  String get getFirstName => firstName;
  String get getlastName => lastName;
  String get getFulltName => "$firstName $secondName $lastName";
  RxString parentName = "".obs;
  Future<String> getParentName() async {
    await ParentController.instance.fetchParentRecord(parentUID);
    parentName.value = ParentController.instance.parent.value.getFulltName;
    return ParentController.instance.parent.value.getFulltName;
  }

  void paretidSetter(String? uid) {
    parentUID = uid;
  }

  String get getPhoneNumber => KFormatter.formatPhoneNumber(phoneNumber);

  LatLng? get getDropLocation =>
      dropLat != '' ? LatLng(double.parse(dropLat!), double.parse(dropLong!)) : null;
  LatLng? get getPickLocation =>
      pickLat != '' ? LatLng(double.parse(pickLat!), double.parse(pickLong!)) : null;

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
      'ParentUID': parentUID,
      'Gender': gender,
      'PickLat': pickLat,
      'PickLong': pickLong,
      'DropLong': dropLong,
      'DropLat': dropLat,
    };
  }

  static List<StudentModel> emptyList() => []; // Define the static method

  static StudentModel empty() => StudentModel(
        id: '',
        dropLong: '',
        dropLat: '',
        pickLong: '',
        pickLat: '',
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
        type: '',
        parentUID: '',
        gender: '',
      );

  // Create a UserModel instance from a Map
  factory StudentModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return StudentModel(
        id: document.id,
        pickLat: data['PickLat'] ?? '',
        pickLong: data['PickLong'] ?? '',
        dropLong: data['DropLong'] ?? '',
        dropLat: data['DropLat'] ?? '',
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
        parentUID: data['ParentUID'] ?? '',
        gender: data['Gender'] ?? '',
      );
    } else {
      return StudentModel.empty();
    }
  }
}
