// ignore_for_file: library_private_types_in_public_api, unused_import, file_names, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Added.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/services/controller/attend_controller.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

class AttendAdder extends StatefulWidget {
  final int index;
  const AttendAdder({Key? key, required this.index}) : super(key: key);

  @override
  _AttendAdderState createState() => _AttendAdderState();
}

class _AttendAdderState extends State<AttendAdder> {
  final controller = AttendanceController.instance;
  final studentController = StudentController.instance;

  @override
  void initState() {
    super.initState();
    //Make Controllers Defaul Value And Disable Things
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Marker'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  enabled: false,
                  validator: (value) => KValidator.validateField("Subject", value),
                  controller: controller.subjectController,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  enabled: false,
                  validator: (value) => KValidator.validateField("Grade", value),
                  controller: controller.gradeController,
                  decoration: const InputDecoration(
                    labelText: 'Grade',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("Student Name", value),
                  enabled: false,
                  controller: controller.studentController,
                  decoration: const InputDecoration(
                    labelText: 'Student Name',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("Date", value),
                  controller: controller.dateOfAttendanceController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("Start Time", value),
                  controller: controller.startTimeController,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("End Time", value),
                  controller: controller.endTimeController,
                  decoration: const InputDecoration(
                    labelText: 'End Time',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () => controller.saveattendanceDataRecord(),
                    elevation: 0.0,
                    minWidth: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void submitForm() {}
}
