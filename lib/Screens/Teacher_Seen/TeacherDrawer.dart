// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:schooll/Screens/Attendance/Attendance.dart';
import 'package:schooll/Screens/Student_Seen/StudentExam.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherAccout.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherHome.dart';
import 'package:schooll/Widgets/DrawerListTile.dart';
import 'package:schooll/services/repository/auth_repo.dart';

class TeacherDrawer extends StatefulWidget {
  const TeacherDrawer({Key? key}) : super(key: key);

  @override
  _TeacherDrawerState createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
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
                    builder: (BuildContext context) => const Teacher_Home(),
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
                        builder: (BuildContext context) => TeacherAccount(),
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
                    builder: (BuildContext context) => StudentExamResult(),
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
                imgpath: "homework.png",
                name: "Marks",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const Teacher_Home(),
                      ));
                })),

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
