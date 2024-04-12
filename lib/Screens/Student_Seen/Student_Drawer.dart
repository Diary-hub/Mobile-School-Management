// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:schooll/Screens/Attendance/Attendance.dart';
import 'package:schooll/Screens/Student_Seen/Account.dart';
import 'package:schooll/Screens/Student_Seen/St_Home.dart';
import 'package:schooll/Screens/Student_Seen/StudentExam.dart';
import 'package:schooll/Screens/Subject.dart';
import 'package:schooll/Widgets/DrawerListTile.dart';
import 'package:schooll/services/repository/auth_repo.dart';

class Student_Drawer extends StatefulWidget {
  const Student_Drawer({Key? key}) : super(key: key);

  @override
  _Student_DrawerState createState() => _Student_DrawerState();
}

class _Student_DrawerState extends State<Student_Drawer> {
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
                    builder: (BuildContext context) => const Student_Home(),
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
                        builder: (BuildContext context) => const StudentAccount(),
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
        Card(
            child: DrawerListTile(
                imgpath: "library.png",
                name: "Subjects",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Subject(),
                      ));
                })),
        // Card(
        //   child: DrawerListTile(
        //       imgpath: "notification.png", name: "Notification", ontap: () {}),
        // ),
        Card(child: DrawerListTile(imgpath: "bus.png", name: "Transport ", ontap: () {})),

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
