// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';

class TeacherDetailCard extends StatefulWidget {
  const TeacherDetailCard({super.key});

  @override
  _TeacherDetailCardState createState() => _TeacherDetailCardState();
}

class _TeacherDetailCardState extends State<TeacherDetailCard> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final studentController = StudentController.instance;
    final teacherController = TeacherController.instance;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 3),
          child: Container(
            alignment: const Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.20,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform(
                            transform:
                                Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage("assets/home.png"),
                              ),
                            ),
                          ),
                          Transform(
                            transform:
                                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Obx(() {
                                      return Text(
                                        teacherController.teacher.value.getFulltName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21,
                                          color: Colors.white,
                                        ),
                                      );
                                    }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Grade: ${teacherController.teacher.value.grade}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        Text(
                                          "Students: ${studentController.studentList.length}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        Text(
                                          teacherController.teacher.value.department,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
