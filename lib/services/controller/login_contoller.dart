// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:schooll/services/repository/auth_repo.dart';
import 'package:schooll/services/utils/helpers/network.dart';
import 'package:schooll/services/utils/loaders/snack_loaders.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> emailAndPasswordLogin() async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Login', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Validate The Data
      if (formkey.currentState!.validate() != true) {
        KLoaders.errorSnackBar(
            title: "Something Wrong !", message: "Please Fill The Informations", duration: 1);

        return;
      }

      // ignore: unused_local_variable
      final userCredential = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text);

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(
            title: "Something Wrong !", message: "Please Fill The Informations", duration: 1);
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }
}
