import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class StudentModel {
  StudentModel({
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
    required this.type,
    required this.parentUID,
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
    };
  }

  static List<StudentModel> emptyList() => []; // Define the static method

  static StudentModel empty() => StudentModel(
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
        type: '',
        parentUID: '',
      );

  // Create a UserModel instance from a Map
  factory StudentModel.fromSnapshot(DocumentSnapshot document) {
    if (document.data() != null) {
      final data = document.data()!;
      return StudentModel(
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
        parentUID: data['ParentUID'] ?? '',
      );
    } else {
      return StudentModel.empty();
    }
  }
}
