// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

import 'dart:async';
import '../models/attendance_model.dart';

class AttendanceRepository extends GetxController {
  static AttendanceRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

// Update Teacher Subject
  Future<void> updateAttendRecord(bool isPermeted, String id) async {
    try {
      await _db.collection("Attendances").doc(id).update({'IsPermeted': isPermeted});
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

  // Save Attendance
  Future<void> saveAttendanceRecord(AttendanceModel attendance) async {
    try {
      await _db.collection("Attendances").doc().set(attendance.toJson());
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
  Future<void> deleteAttendanceRecord(String id) async {
    try {
      await _db.collection("Attendances").doc(id).delete();
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
  Future<AttendanceModel> fetchAttendanceData(id) async {
    try {
      final documentSnapshot = await _db.collection("Attendances").doc(id).get();
      if (documentSnapshot.exists) {
        return AttendanceModel.fromSnapshot(documentSnapshot);
      } else {
        return AttendanceModel.empty();
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
  Future<List<AttendanceModel>> fetchAllAttendanceData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Attendances").get();
      List<AttendanceModel> attendances = [];
      for (var doc in querySnapshot.docs) {
        attendances.add(AttendanceModel.fromSnapshot(doc));
      }
      return attendances;
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
