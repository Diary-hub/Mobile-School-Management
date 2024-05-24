import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schooll/Screens/LoginPage.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageInicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final deviceStorage = GetStorage();
      deviceStorage.write("isFirstTime", false);
      Get.to(const LoginPage(title: "Login"));
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    final deviceStorage = GetStorage();
    deviceStorage.write("isFirstTime", false);
    Get.to(const LoginPage(
      title: "Login",
    ));
  }
}
