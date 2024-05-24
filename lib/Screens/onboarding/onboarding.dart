import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/onboarding/widgets/onboarding_Page.dart';
import 'package:schooll/Screens/onboarding/widgets/onboarding_dotnavigation.dart';
import 'package:schooll/Screens/onboarding/widgets/onboarding_more.dart';
import 'package:schooll/Screens/onboarding/widgets/onboarding_nextbutton.dart';
import 'package:schooll/Screens/onboarding/widgets/onboarding_skipbutton.dart';
import 'package:schooll/services/controller/onboarding_controller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageInicator,
            children: const [
              OnBoardingPage(
                image:
                    "https://img.freepik.com/free-vector/school-building-isolated-illustration-vector_24911-114862.jpg",
                subTitile:
                    "Get started with our innovative school management application tailored for UHD School. Seamlessly manage student records, academic performance, and administrative tasks all in one place. Experience the convenience of modern technology in education management.",
                title: "Welcome to UHD",
              ),
              OnBoardingPage(
                image:
                    "https://img.freepik.com/free-vector/school-building-isolated-illustration-vector_24911-114862.jpg",
                subTitile:
                    "Discover how our UHD School Management app streamlines your school's operations. From attendance tracking to grade management, our intuitive platform empowers educators and administrators to focus more on student success. Join us in revolutionizing the way UHD School operates.",
                title: "School Operations",
              ),
              OnBoardingPage(
                image:
                    "https://img.freepik.com/free-vector/school-building-isolated-illustration-vector_24911-114862.jpg",
                subTitile:
                    'Embark on an educational journey like never before with UHD School Management. Our application empowers students, teachers, and parents alike with tools for efficient communication, academic monitoring, and collaborative learning. Take control of your education with UHD School Management.',
                title: "Empower Educational ",
              ),
            ],
          ),
          const OnBoardingSkipButton(),
          const OnBoardingMoreButton(),
          const OnBoardingDotNavigation(),
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}
