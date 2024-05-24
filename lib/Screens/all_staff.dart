// ignore_for_file: library_private_types_in_public_api, camel_case_types, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooll/Screens/Driver.dart';
import 'package:schooll/Screens/Employee.dart';
import 'package:schooll/Screens/Tacher.dart';
import 'package:schooll/Widgets/BouncingButton.dart';
import 'package:schooll/Widgets/DashboardCards.dart';

class Allstaff extends StatefulWidget {
  const Allstaff({super.key});

  @override
  _All_Staff createState() => _All_Staff();
}

class _All_Staff extends State<Allstaff> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController =
        AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
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
          // drawer: Drawer(
          //   elevation: 0,
          //   child: MainDrawer(),
          // ),
          appBar: AppBar(
            title: const Text(
              'All Staff',
            ),
            backgroundColor: Colors.blueGrey,
            centerTitle: true,
          ),

          body: ListView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30.0, 40, 30, 10),
                      child: Container(
                        alignment: const Alignment(2.0, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 150.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Transform(
                              //   transform: Matrix4.translationValues(
                              //       muchDelayedAnimation.value * width, 0, 0),
                              //   child: Bouncing(
                              //     onPress: () {
                              //       Navigator.push(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (BuildContext context) =>
                              //                 Attendance(),
                              //           ));
                              //     },
                              //     child: DashboardCard(
                              //       name: "Student",
                              //       imgpath: "profile.png",
                              //     ),
                              //   ),
                              // ),
                              Transform(
                                transform:
                                    Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                                child: Bouncing(
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => const Teacher(),
                                        ));
                                  },
                                  child: const DashboardCard(
                                    name: "Teacher",
                                    imgpath: "classroom.png",
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
                        alignment: const Alignment(2.0, 0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * width, 0, 0),
                                child: Bouncing(
                                  onPress: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) => const Employee(),
                                        ));
                                  },
                                  child: const DashboardCard(
                                    name: "Employee",
                                    imgpath: "stafff.jpg",
                                  ),
                                ),
                              ),
                              Center(
                                child: Transform(
                                  transform: Matrix4.translationValues(
                                      delayedAnimation.value * width, 0, 0),
                                  child: Bouncing(
                                    onPress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) => const Driver(),
                                          ));
                                    },
                                    child: const DashboardCard(
                                      name: "Driver",
                                      imgpath: "shofer.png",
                                    ),
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
              )
            ],
          ),
        );
      },
    );
  }
}
