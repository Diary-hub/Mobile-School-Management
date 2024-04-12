// ignore_for_file: library_private_types_in_public_api, unused_import, file_names, import_of_legacy_library_into_null_safe, unnecessary_null_comparison, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Added.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

class SubjectAdder extends StatefulWidget {
  const SubjectAdder({Key? key}) : super(key: key);

  @override
  _SubjectAdderState createState() => _SubjectAdderState();
}

class _SubjectAdderState extends State<SubjectAdder> {
  @override
  Widget build(BuildContext context) {
    final controller = SubjectAdderController.instance;
    final teacherController = TeacherController.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Planner'),
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
                    validator: (v) => v == null ? "Please Select The Grade" : null,
                    hint: "Please Select The Grade",
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: const [
                      '1',
                      '2',
                      '3',
                      '4',
                    ],
                    showClearButton: false,
                    onChanged: (value) {
                      controller.gradeValue = value;
                    },
                  ),
                ),
                TextFormField(
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
                  validator: (value) => KValidator.validateField("Chapters", value),
                  controller: controller.chaptersController,
                  decoration: const InputDecoration(
                    labelText: 'Chapters',
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
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () => controller.saveSubjectDataRecord(),
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
