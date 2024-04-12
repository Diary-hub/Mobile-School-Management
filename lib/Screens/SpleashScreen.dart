// ignore_for_file: file_names, import_of_legacy_library_into_null_safe, library_private_types_in_public_api

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/LoginPage.dart';
import 'package:schooll/firebase_options.dart';
import 'package:schooll/services/repository/auth_repo.dart';

class SpleashScreen extends StatefulWidget {
  const SpleashScreen({Key? key}) : super(key: key);

  @override
  _SpleashScreenState createState() => _SpleashScreenState();
}

class _SpleashScreenState extends State<SpleashScreen> {
  @override
  // ignore: must_call_super
  void initState() {
    _initializeAppAndNavigate();
  }

  Future<void> _initializeAppAndNavigate() async {
    // Wait for both Firebase and GetStorage initialization to be completed
    WidgetsFlutterBinding.ensureInitialized();
    await Future.wait([
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).then((FirebaseApp value) => null),
      Future.delayed(const Duration(seconds: 2)),
    ]);
    // print("DONE INistion");
    Get.put(AuthenticationRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width * 0.35,
            child: const FlareActor(
              "assets/school spleash.flr",
              animation: "start",
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  start() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(title: 'Home'),
        ),
      );
    });
  }
}
