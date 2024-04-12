// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/exception/firebase_auth_exceptions.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

import '../models/teacher_model.dart';

class TeacherRepository extends GetxController {
  static TeacherRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

//delete Id
  Future<void> deleteTeacherRecord(String id) async {
    try {
      await _db.collection("Teachers").doc(id).delete();
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
  Future<void> saveTeacherRecord(TeacherModel teacher) async {
    try {
      await _db.collection("Teachers").doc(teacher.id).set(teacher.toJson());
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
  Future<TeacherModel> fetchTeacherData(id) async {
    try {
      final documentSnapshot = await _db.collection("Teachers").doc(id).get();
      if (documentSnapshot.exists) {
        return TeacherModel.fromSnapshot(documentSnapshot);
      } else {
        return TeacherModel.empty();
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
  Future<List<TeacherModel>> fetchAllTeachersData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Teachers").get();
      List<TeacherModel> teachers = [];
      for (var doc in querySnapshot.docs) {
        teachers.add(TeacherModel.fromSnapshot(doc));
      }
      return teachers;
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
