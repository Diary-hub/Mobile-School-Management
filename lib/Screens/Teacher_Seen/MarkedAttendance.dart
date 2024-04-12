// ignore_for_file: file_names, library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/Attendance/AttendanceCard.dart';
import 'package:schooll/services/controller/attend_controller.dart';

class TeacherMarkedAttendance extends StatefulWidget {
  final bool isTeacher;
  const TeacherMarkedAttendance({Key? key, required this.isTeacher}) : super(key: key);

  @override
  _TeacherMarkedAttendanceState createState() => _TeacherMarkedAttendanceState();
}

class _TeacherMarkedAttendanceState extends State<TeacherMarkedAttendance> {
  final controller = AttendanceController.instance;

  @override
  void initState() {
    super.initState();
    controller.fetchAllattendanceRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.attendanceList.length,
                itemBuilder: (context, index) {
                  if (controller.attendanceList[index].isPermeted) {
                    return Container();
                  }
                  return AttendanceCard(
                    isStudent: false,
                    isTeacher: widget.isTeacher,
                    index: index,
                    time: controller.attendanceList[index].getDurattion,
                    student: controller.attendanceList[index].studentName,
                    date: controller.attendanceList[index].getDate,
                    subject:
                        '${controller.attendanceList[index].subject}-${controller.attendanceList[index].grade}',
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
