// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schooll/Screens/Attendance/Attendance.dart';
import 'package:schooll/Screens/Exam/Exam_Rseult.dart';
import 'package:schooll/Screens/Student.dart';
import 'package:schooll/Screens/Subject.dart';
import 'package:schooll/Screens/all_staff.dart';
import 'package:schooll/Screens/home.dart';
import 'package:schooll/Widgets/DrawerListTile.dart';
import 'package:schooll/services/repository/auth_repo.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Card(
        //   child: DrawerListTile(
        //       imgpath: "stafff.jpg",
        //       name: "Staff",
        //       ontap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (BuildContext context) => Allstaff(),
        //           ),
        //         );
        //       }),
        // ),
        // Card(
        //   child: DrawerListTile(
        //       imgpath: "home.png",
        //       name: "Home",
        //       ontap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (BuildContext context) => const Home(),
        //           ),
        //         );
        //       }),
        // ),
        // Card(
        //   child: DrawerListTile(
        //     imgpath: "attendance.png",
        //     name: "Attendance",
        //     ontap: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (BuildContext context) => const Attendance(),
        //         ),
        //       );
        //     },
        //   ),
        // ),

        // Card(
        //     child: DrawerListTile(
        //         imgpath: "profile.png",
        //         name: "Student",
        //         ontap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (BuildContext context) => const Student(),
        //               ));
        //         })),
        // Card(
        //   child: DrawerListTile(
        //     imgpath: "exam.png",
        //     name: "Exam",
        //     ontap: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (BuildContext context) => const ExamResult(),
        //           ));
        //     },
        //   ),
        // ),
        // Card(child: DrawerListTile(imgpath: "fee.png", name: "Fees", ontap: () {})),
        // Card(
        //   child: DrawerListTile(imgpath: "calendar.png", name: "Time Table", ontap: () {}),
        // ),
        // Card(
        //     child: DrawerListTile(
        //         imgpath: "library.png",
        //         name: "Subjects",
        //         ontap: () {
        //           Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (BuildContext context) => const Subject(),
        //               ));
        //         })),
        // Card(
        //   child: DrawerListTile(imgpath: "notification.png", name: "Notification", ontap: () {}),
        // ),
        // Card(child: DrawerListTile(imgpath: "bus.png", name: "Transport ", ontap: () {})),

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
