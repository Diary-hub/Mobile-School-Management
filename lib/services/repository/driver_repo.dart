// ignore_for_file: import_of_legacy_library_into_null_safe, file_names
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/models/student_model.dart';
import 'package:schooll/services/utils/exception/firebase_auth_exceptions.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

import '../models/driver_model.dart';

class DriverRepository extends GetxController {
  static DriverRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// Register Method
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw KFormatException;
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "هەڵەیەک ڕویدا تکایە دوبارە هەوڵ بدەرەوە";
    }
  }

  // Save New User After Register
  Future<void> saveDriverRecord(DriverModel user) async {
    try {
      await _db.collection("Drivers").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  // Save New User After Register
  Future<void> deleteDriverRecord(id) async {
    try {
      await _db.collection("Drivers").doc(id).delete();
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  // Save New User After Register
  Future<void> deleteDriverStudent(DriverModel driver, String id) async {
    try {
      await _db.collection("Drivers").doc(driver.id).collection('Students').doc(id).delete();
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  Future<void> addStudentToDriver(DriverModel driver, StudentModel student) async {
    try {
      await _db
          .collection("Drivers")
          .doc(driver.id)
          .collection('Students')
          .doc(student.id)
          .set(student.toJson());
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  //Fetch ALl Data
  Future<List<StudentModel>> fetchDriverStudents(DriverModel driver) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Drivers")
          .doc(driver.id)
          .collection('Students')
          .get();

      List<StudentModel> students = [];
      for (var doc in querySnapshot.docs) {
        students.add(StudentModel.fromSnapshot(doc));
        print(StudentModel.fromSnapshot(doc).address);
      }

      return students;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  // Fetch User Data By ID
  Future<DriverModel> fetchDriverData(id) async {
    try {
      final documentSnapshot = await _db.collection("Drivers").doc(id).get();
      if (documentSnapshot.exists) {
        return DriverModel.fromSnapshot(documentSnapshot);
      } else {
        return DriverModel.empty();
      }
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }

  //Fetch ALl Data
  Future<List<DriverModel>> fetchAllDriverData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Drivers").get();
      List<DriverModel> drivers = [];
      for (var doc in querySnapshot.docs) {
        drivers.add(DriverModel.fromSnapshot(doc));
      }
      return drivers;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const KFormatException();
    } on PlatformException catch (e) {
      throw KPlatformException(e.code).message;
    } catch (e) {
      throw "Some Thing Wrong Please Try Again";
    }
  }
}
