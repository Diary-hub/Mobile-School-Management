// ignore_for_file: library_private_types_in_public_api, file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/Attendance/Permession.dart';
import 'package:schooll/services/controller/attend_controller.dart';

class ParentPermessionAttendance extends StatefulWidget {
  const ParentPermessionAttendance({super.key});

  @override
  _ParentPermessionAttendanceState createState() => _ParentPermessionAttendanceState();
}

class _ParentPermessionAttendanceState extends State<ParentPermessionAttendance> {
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
                  if (!controller.attendanceList[index].isPermeted ||
                      controller.attendanceList[index].parentUID !=
                          FirebaseAuth.instance.currentUser!.uid) {
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
