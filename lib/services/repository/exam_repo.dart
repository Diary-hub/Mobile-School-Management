import 'dart:async';
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

import '../models/exam_model.dart';

class ExamRepository extends GetxController {
  static ExamRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save Exam
  Future<void> saveExamRecord(ExamModel exam) async {
    try {
      await _db.collection("Exams").doc(exam.idNumber).set(exam.toJson());
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
  Future<void> deleteExamRecord(String id) async {
    try {
      await _db.collection("Exams").doc(id).delete();
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
  Future<ExamModel> fetchExamData(id) async {
    try {
      final documentSnapshot = await _db.collection("Exams").doc(id).get();
      if (documentSnapshot.exists) {
        return ExamModel.fromSnapshot(documentSnapshot);
      } else {
        return ExamModel.empty();
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
  Future<List<ExamModel>> fetchAllExamData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Exams").get();
      List<ExamModel> exams = [];
      for (var doc in querySnapshot.docs) {
        exams.add(ExamModel.fromSnapshot(doc));
      }
      return exams;
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
