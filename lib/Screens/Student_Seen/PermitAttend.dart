// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/Attendance/Permession.dart';
import 'package:schooll/services/controller/attend_controller.dart';

class StudentPermessionAttendance extends StatefulWidget {
  const StudentPermessionAttendance({Key? key}) : super(key: key);

  @override
  _StudentPermessionAttendanceState createState() => _StudentPermessionAttendanceState();
}

class _StudentPermessionAttendanceState extends State<StudentPermessionAttendance> {
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
                    isStudent: true,
                    isTeacher: false,
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
