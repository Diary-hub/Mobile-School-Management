// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Teacher_Seen/MarkedAttendance.dart';
import 'package:schooll/Screens/Teacher_Seen/PermitAttendance.dart';
import 'package:schooll/Screens/Teacher_Seen/StudentsList.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherDetailCard.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherHome.dart';

class TeacherAttendance extends StatefulWidget {
  const TeacherAttendance({Key? key}) : super(key: key);

  @override
  _TeacherAttendanceState createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      // drawer: Drawer(
      //   elevation: 0,
      //   child: MainDrawer(),
      // ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.off(const Teacher_Home()), icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Attendance',
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const TeacherDetailCard(),
            DefaultTabController(
              length: 3, // length of tabs
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black26,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(text: 'Students'),
                        Tab(text: 'Marked'),
                        Tab(text: 'Permeted'),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.68, //height of TabBarView
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: const TabBarView(
                      children: <Widget>[
                        TeacherStudentList(),
                        TeacherMarkedAttendance(isTeacher: true),
                        TeacherPermessionAttendance(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
