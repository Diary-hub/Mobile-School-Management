// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/models/subject_model.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

class SubjectRepository extends GetxController {
  static SubjectRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save Subject
  Future<void> saveSubjectRecord(SubjectModel subject) async {
    try {
      await _db.collection("Subjects").doc(subject.idNumber).set(subject.toJson());
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

  // Update Teacher Subject
  Future<void> updateSubjectRecord(String teacherName, String id) async {
    try {
      await _db.collection("Subjects").doc(id).update({'TeacherName': teacherName});
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

  // Delete
  Future<void> deleteSubjectRecord(String id) async {
    try {
      await _db.collection("Subjects").doc(id).delete();
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
  Future<SubjectModel> fetchSubjectData(id) async {
    try {
      final documentSnapshot = await _db.collection("Subjects").doc(id).get();
      if (documentSnapshot.exists) {
        return SubjectModel.fromSnapshot(documentSnapshot);
      } else {
        return SubjectModel.empty();
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
  Future<List<SubjectModel>> fetchAllSubjectData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Subjects").get();
      List<SubjectModel> subjects = [];
      for (var doc in querySnapshot.docs) {
        subjects.add(SubjectModel.fromSnapshot(doc));
      }
      return subjects;
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
  Future<List<SubjectModel>> fetchAllSubjectDataByGrade(grade) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("Subjects")
          .where('Grade', isEqualTo: grade.toString())
          .get();

      List<SubjectModel> subjects = [];
      for (var doc in querySnapshot.docs) {
        subjects.add(SubjectModel.fromSnapshot(doc));
      }

      return subjects;
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
