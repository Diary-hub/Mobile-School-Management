// ignore_for_file: file_names, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Teacher_Seen/StudentCard.dart';
import 'package:schooll/services/controller/attend_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';

class TeacherStudentList extends StatefulWidget {
  const TeacherStudentList({Key? key}) : super(key: key);

  @override
  _TeacherStudentListState createState() => _TeacherStudentListState();
}

class _TeacherStudentListState extends State<TeacherStudentList> {
  final controller = AttendanceController.instance;
  final studentController = StudentController.instance;

  @override
  void initState() {
    super.initState();
    controller.fetchAllattendanceRecord();
    studentController.fetchAllStudentRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: studentController.studentList.length,
                itemBuilder: (context, index) {
                  return StudentListAttendanceCard(
                    index: index,
                    time: "",
                    student: studentController.studentList[index].idNumber,
                    date: "",
                    subject: studentController.studentList[index].getFulltName,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
