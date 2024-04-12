// ignore_for_file: library_private_types_in_public_api, unused_import, file_names, import_of_legacy_library_into_null_safe
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Added.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

class ExamAdderTeacher extends StatefulWidget {
  const ExamAdderTeacher({Key? key}) : super(key: key);

  @override
  _ExamAdderTeacherState createState() => _ExamAdderTeacherState();
}

class _ExamAdderTeacherState extends State<ExamAdderTeacher> {
  final controller = ExamAdderController.instance;
  final subjectsController = SubjectAdderController.instance;

  @override
  void initState() {
    super.initState();
    subjectsController.fetchAllSubjectRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Planner'),
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
                Transform(
                  transform: Matrix4.translationValues(0.5, 0, 0),
                  child: DropdownSearch<String>(
                    maxHeight: 150,
                    validator: (v) => v == null ? "Please Select The Exam" : null,
                    hint: "Please Select The Exam",
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: const [
                      "Quiz",
                      "Assignment",
                    ],
                    showClearButton: false,
                    onChanged: (value) {
                      controller.selectedMode = value;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => Transform(
                    transform: Matrix4.translationValues(0.5, 0, 0),
                    child: DropdownSearch<String>(
                      maxHeight: 150,
                      validator: (v) => v == null ? "Please Select The Grade" : null,
                      hint: "Please Select The Subject",
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items: [TeacherController.instance.teacher.value.subject],
                      showClearButton: false,
                      onChanged: (value) {
                        controller.examSubjectController = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Transform(
                  transform: Matrix4.translationValues(0.5, 0, 0),
                  child: DropdownSearch<String>(
                      maxHeight: 150,
                      validator: (v) => v == null ? "Please Select The Grade" : null,
                      hint: "Please Select The Grade",
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      onChanged: (value) {
                        controller.gradeController = value;
                      },
                      items: [TeacherController.instance.teacher.value.grade]),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("Start Chapter", value),
                  controller: controller.startChapterController,
                  decoration: const InputDecoration(
                    labelText: 'Start Chapter',
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
                  validator: (value) => KValidator.validateField("End Chapter", value),
                  controller: controller.endChapterController,
                  decoration: const InputDecoration(
                    labelText: 'End Chapter',
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
                  validator: (value) => KValidator.validateField("Date of Exam", value),
                  controller: controller.dateOfExamController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Exam',
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
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("Marks", value),
                  controller: controller.marksController,
                  decoration: const InputDecoration(
                    labelText: 'Marks',
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
                  validator: (value) => KValidator.validateField("ID Number", value),
                  controller: controller.idNumberController,
                  decoration: const InputDecoration(
                    labelText: 'ID Number',
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
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () => controller.saveexamDataRecord("Teacher"),
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
