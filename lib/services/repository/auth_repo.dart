// ignore_for_file: import_of_legacy_library_into_null_safe, avoid_print
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schooll/Screens/LoginPage.dart';
import 'package:schooll/Screens/Parent_Seen/ParentHome.dart';
import 'package:schooll/Screens/Student_Seen/St_Home.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherHome.dart';
import 'package:schooll/Screens/home.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/exception/firebase_auth_exceptions.dart';
import 'package:schooll/services/utils/exception/firebase_exceptions.dart';
import 'package:schooll/services/utils/exception/format_exceptions.dart';
import 'package:schooll/services/utils/exception/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    screenRedirect();
  }

  // Check For Login or First Time
  void screenRedirect() async {
    final user = _auth.currentUser;
    // ignore: unnecessary_null_comparison
    if (user != null) {
      try {
        final studentController = Get.put(StudentController());
        final parentController = Get.put(ParentController());
        final teacherController = Get.put(TeacherController());

        await studentController.fetchStudentRecord(user.uid);
        await parentController.fetchParentRecord(user.uid);
        await teacherController.fetchTeacherRecord(user.uid);

        if (studentController.student.value.id == user.uid) {
          Get.to(() => const Student_Home());
        } else if (parentController.parent.value.id == user.uid) {
          Get.to(() => const Parent_Home());
        } else if (teacherController.teacher.value.id == user.uid) {
          Get.to(() => const Teacher_Home());
        } else {
          Get.to(() => const Home());
        }
      } catch (e) {
        throw e.toString();
      }
    } else {
      Get.offAll(() => const LoginPage(title: 'home'));
    }
  }

  // Login Method
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw KFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw KFormatException;
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
      throw "Some Thing Wrong Please Try Again";
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginPage(title: 'home'));
    } on FirebaseAuthException catch (e) {
      throw KFirebaseAuthException(e.code).message;
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
