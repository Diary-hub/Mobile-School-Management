// ignore_for_file: camel_case_types, file_names, import_of_legacy_library_into_null_safe, library_private_types_in_public_api, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Student_Seen/Account.dart';
import 'package:schooll/Screens/Student_Seen/StudentAttendace.dart';
import 'package:schooll/Screens/Student_Seen/StudentDetailCard.dart';
import 'package:schooll/Screens/Student_Seen/StudentExam.dart';
import 'package:schooll/Screens/Student_Seen/Student_Drawer.dart';
import 'package:schooll/Screens/Student_Seen/SubjectStudent.dart';
import 'package:schooll/Screens/Subject.dart';
import 'package:schooll/Widgets/BouncingButton.dart';
import 'package:schooll/Widgets/DashboardCards.dart';
import 'package:schooll/services/controller/attend_controller.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Student_Home extends StatefulWidget {
  const Student_Home({Key? key}) : super(key: key);

  @override
  _Student_HomeState createState() => _Student_HomeState();
}

class _Student_HomeState extends State<Student_Home> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final subjectController = Get.put(SubjectAdderController());
  final examController = Get.put(ExamAdderController());
  final studentController = StudentController.instance;
  final parenntController = ParentController.instance;
  final teacherController = TeacherController.instance;
  final attendanceController = Get.put(AttendanceController());
  final _url =
      'https://docs.google.com/spreadsheets/d/1rq-q4n3rEfxnsY0J8ZRtOvauiF7pf2PkeVeJwHAIw-c/';

  void _launchURL() async => await launch(_url);

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(
            elevation: 0,
            child: Student_Drawer(),
          ),
          appBar: AppBar(
            title: const Text(
              'Home',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: ListView(
            children: [
              const StudentDetailCard(),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Transform(
                          transform:
                              Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const StudentAccount(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "Account",
                              imgpath: "profile.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform:
                              Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const StudentAttendance(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "Attendance",
                              imgpath: "attendance.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Transform(
                          transform:
                              Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const StudentExamResult(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "Exam",
                              imgpath: "exam.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform:
                              Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: _launchURL,
                            child: const DashboardCard(
                              name: "TimeTable",
                              imgpath: "calendar.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Transform(
                          transform:
                              Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const StudentSubject(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "Subjects",
                              imgpath: "library.png",
                            ),
                          ),
                        ),
                        Transform(
                          transform:
                              Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {},
                            child: const DashboardCard(
                              name: "Transport",
                              imgpath: "bus.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  alignment: const Alignment(1.0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Transform(
                          transform:
                              Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const Subject(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "My Marks",
                              imgpath: "homework.png",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
