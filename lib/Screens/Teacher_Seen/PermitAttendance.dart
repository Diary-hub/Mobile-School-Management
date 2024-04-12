// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/Attendance/Permession.dart';
import 'package:schooll/services/controller/attend_controller.dart';

class TeacherPermessionAttendance extends StatefulWidget {
  const TeacherPermessionAttendance({Key? key}) : super(key: key);

  @override
  _TeacherPermessionAttendanceState createState() => _TeacherPermessionAttendanceState();
}

class _TeacherPermessionAttendanceState extends State<TeacherPermessionAttendance> {
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
                  if (!controller.attendanceList[index].isPermeted) {
                    return Container();
                  }
                  return PermessionCard(
                    isStudent: false,
                    isTeacher: true,
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
