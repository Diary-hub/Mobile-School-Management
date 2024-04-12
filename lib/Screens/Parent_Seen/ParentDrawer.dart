// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:schooll/Screens/Attendance/Attendance.dart';
import 'package:schooll/Screens/Parent_Seen/ParentAccout.dart';
import 'package:schooll/Screens/Parent_Seen/ParentHome.dart';
import 'package:schooll/Screens/Student_Seen/StudentExam.dart';
import 'package:schooll/Widgets/DrawerListTile.dart';
import 'package:schooll/services/repository/auth_repo.dart';

class ParentDrawer extends StatefulWidget {
  const ParentDrawer({Key? key}) : super(key: key);

  @override
  _ParentDrawerState createState() => _ParentDrawerState();
}

class _ParentDrawerState extends State<ParentDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: DrawerListTile(
              imgpath: "home.png",
              name: "Home",
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Parent_Home(),
                  ),
                );
              }),
        ),
        Card(
            child: DrawerListTile(
                imgpath: "profile.png",
                name: "Account",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ParenttAccount(),
                      ));
                })),
        Card(
          child: DrawerListTile(
            imgpath: "attendance.png",
            name: "Attendance",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Attendance(),
                ),
              );
            },
          ),
        ),

        Card(
          child: DrawerListTile(
            imgpath: "exam.png",
            name: "Exam",
            ontap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const StudentExamResult(),
                  ));
            },
          ),
        ),
        // Card(
        //     child:
        //         DrawerListTile(imgpath: "fee.png", name: "Fees", ontap: () {})),
        Card(
          child: DrawerListTile(imgpath: "calendar.png", name: "Time Table", ontap: () {}),
        ),
        Card(child: DrawerListTile(imgpath: "homework.png", name: "Marks", ontap: () {})),

        Card(
            child: DrawerListTile(
                imgpath: "exit.png",
                name: "LogOut ",
                ontap: () {
                  AuthenticationRepository.instance.logout();
                })),
        // DrawerListTile(
        //   imgpath: "downloads.png",
        //   name: "Subject",
        //   ontap: () {},
        // ),

        // DrawerListTile(
        //   imgpath: "leave_apply.png",
        //   name: "Leave apply",
        //   ontap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (BuildContext context) => LeaveApply(),
        //       ),
        //     );
        //   },
        // ),
        // DrawerListTile(imgpath: "activity.png", name: "Activity", ontap: () {}),
      ],
    );
  }
}
