// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/models/driver_model.dart';
import 'package:schooll/services/models/marks_model.dart';
import 'package:schooll/services/utils/exception/firebase_auth_exceptions.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

import '../models/student_model.dart';

class StudentRepository extends GetxController {
  static StudentRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save New User After Register
  Future<void> saveStudentRecord(StudentModel user) async {
    try {
      await _db.collection("Students").doc(user.id).set(user.toJson());
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

  Future<void> updateStudentRecord(
      DriverModel driver, StudentModel user, Map<String, dynamic> json) async {
    try {
      await _db.collection('Students').doc(user.id).update(json);
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
  Future<void> deleteStudentRecord(String id) async {
    try {
      await _db.collection("Students").doc(id).delete();
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
  Future<StudentModel> fetchStudentData(id) async {
    try {
      final documentSnapshot = await _db.collection("Students").doc(id).get();
      if (documentSnapshot.exists) {
        return StudentModel.fromSnapshot(documentSnapshot);
      } else {
        return StudentModel.empty();
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

  // Fetch User Data By ID

  Future<StudentModel> fetchByChangeIDtoUID(String id) async {
    try {
      final querySnapshot =
          await _db.collection("Students").where("IDNumber", isEqualTo: id).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Extract the data from the document
        final data = querySnapshot.docs.first;
        // Create your StudentModel object here using the extracted data
        StudentModel student =
            StudentModel.fromSnapshot(data); // Example: assuming you have a fromJson constructor
        return student;
      } else {
        // Handle case when no document is found
        return StudentModel.empty();
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

  // Save New User After Register
  Future<void> saveStudentRecordMarks(MarksModel marks, studentID, subject) async {
    try {
      await _db
          .collection("Students")
          .doc(studentID)
          .collection(subject)
          .doc('marks')
          .set(marks.toJson());
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
  Future<MarksModel> fetchStudentDataBySubject(subject, studentID) async {
    try {
      final documentSnapshot =
          await _db.collection("Students").doc(studentID).collection(subject).doc('marks').get();
      if (documentSnapshot.exists) {
        return MarksModel.fromSnapshot(documentSnapshot);
      } else {
        return MarksModel.empty();
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
  Future<List<MarksModel>> fetchStudentDataBySubjectList(subject, studentID) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Students")
          .doc(studentID)
          .collection(subject)
          .get();
      List<MarksModel> students = [];
      for (var doc in querySnapshot.docs) {
        students.add(MarksModel.fromSnapshot(doc));
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

  //Fetch ALl Data
  Future<List<StudentModel>> fetchAllStudentData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Students").get();
      List<StudentModel> students = [];
      for (var doc in querySnapshot.docs) {
        students.add(StudentModel.fromSnapshot(doc));
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

  //Fetch ALl Data
  Future<List<StudentModel>> fetchAllStudentDataWithDriver() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Students").get();
      List<StudentModel> students = [];
      for (var doc in querySnapshot.docs) {
        students.add(StudentModel.fromSnapshot(doc));
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

  Future<List<StudentModel>> fetchAllStudentDataByGrade(String grade) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Students")
          .where('Grade', isEqualTo: grade.toString())
          .get();
      List<StudentModel> students = [];
      for (var doc in querySnapshot.docs) {
        students.add(StudentModel.fromSnapshot(doc));
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
}
