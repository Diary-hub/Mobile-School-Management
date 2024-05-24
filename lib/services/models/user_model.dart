import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.type,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String type;

  String get getFirstName => firstName;
  String get getlastName => lastName;
  String get getFulltName => "$firstName $lastName";

  String get getPhoneNumber => KFormatter.formatPhoneNumber(phoneNumber);

  // Convert the UserModel instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Gender': gender,
      'Type': type,
    };
  }

  static UserModel empty() => UserModel(
        gender: '',
        id: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        email: '',
        type: '',
      );

  // Create a UserModel instance from a Map
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        email: data['Email'] ?? '',
        gender: data['Gender'] ?? '',
        type: data['Type'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
