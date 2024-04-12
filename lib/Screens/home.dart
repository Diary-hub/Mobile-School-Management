// ignore_for_file: non_constant_identifier_names, import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Attendance/Attendance.dart';
import 'package:schooll/Screens/Exam/Exam_Rseult.dart';
import 'package:schooll/Screens/Student.dart';
import 'package:schooll/Screens/Subject.dart';
import 'package:schooll/Screens/all_staff.dart';
import 'package:schooll/Widgets/BouncingButton.dart';
import 'package:schooll/Widgets/DashboardCards.dart';
import 'package:schooll/Widgets/MainDrawer.dart';
import 'package:schooll/Widgets/UserDetailCard.dart';
import 'package:schooll/services/controller/attend_controller.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/controller/subject_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final subjectController = Get.put(SubjectAdderController());
  final examController = Get.put(ExamAdderController());
  final studentController = StudentController.instance;
  final parenntController = ParentController.instance;
  final teacherController = TeacherController.instance;
  final attendanceController = Get.put(AttendanceController());
  final _url = 'https://flutter.dev';

  void _launchURL() async => await launch(_url);

  @override
  void initState() {
    super.initState();
    studentController.fetchAllStudentRecord();
    parenntController.fetchAllParentRecord();
    teacherController.fetchAllTeacherRecord();

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
            child: MainDrawer(),
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
              const UserDetailCard(),
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
                              // print(AuthenticationRepository.instance.authUser?.uid);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Allstaff(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "All Staff",
                              imgpath: "stafff.jpg",
                            ),
                          ),
                        ),
                        Transform(
                          transform:
                              Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                          child: Bouncing(
                            onPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const Student(),
                                  ));
                            },
                            child: const DashboardCard(
                              name: "Student",
                              imgpath: "profile.png",
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
                                    builder: (BuildContext context) => const ExamResult(),
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
                                    builder: (BuildContext context) => const Subject(),
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
                                    builder: (BuildContext context) => const Attendance(),
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
            ],
          ),
        );
      },
    );
  }
}
