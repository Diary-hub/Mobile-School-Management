import 'dart:async';
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooll/services/models/employee_model.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

class EmpRepository extends GetxController {
  static EmpRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save Emp
  Future<void> saveEmpRecord(EmployeeModel emp) async {
    try {
      await _db.collection("Employees").doc(emp.idNumber).set(emp.toJson());
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
  Future<void> deleteEmpRecord(String id) async {
    try {
      await _db.collection("Employees").doc(id).delete();
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
  Future<EmployeeModel> fetchEmpData(id) async {
    try {
      final documentSnapshot = await _db.collection("Employees").doc(id).get();
      if (documentSnapshot.exists) {
        return EmployeeModel.fromSnapshot(documentSnapshot);
      } else {
        return EmployeeModel.empty();
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
  Future<List<EmployeeModel>> fetchAllEmpData() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection("Employees").get();
      List<EmployeeModel> emps = [];
      for (var doc in querySnapshot.docs) {
        emps.add(EmployeeModel.fromSnapshot(doc));
      }
      return emps;
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
