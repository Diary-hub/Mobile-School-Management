// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Teacher_Seen/Marks.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/models/student_model.dart';

class MarksEditScreen extends StatelessWidget {
  const MarksEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = StudentController.instance;
    controller.fetchStudentRecordBySubject(TeacherController.instance.teacher.value.subject);

    final RxBool oneEdit = false.obs;
    final RxBool twoEdit = false.obs;
    final RxBool threeEdit = false.obs;
    final RxBool fourEdit = false.obs;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.studentEdit.value = StudentModel.empty();
                controller.dailyOneController.text = '';
                controller.dailyTwoController.text = '';
                controller.midtermExamController.text = '';
                controller.finalExamController.text = '';
                Get.to(() => const MarksScreen());
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            controller.studentEdit.value.getFulltName,
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(),
            SizedBox(
              width: 300,
              child: Obx(
                () => TextFormField(
                  controller: controller.dailyOneController,
                  enabled: oneEdit.value,
                  decoration: const InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                    labelText: 'Daily One',
                    helperText: "From 10",
                    helperStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 34, 255, 82),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Obx(
                () => TextFormField(
                  controller: controller.dailyTwoController,
                  enabled: twoEdit.value,
                  decoration: const InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                    helperText: "From 10",
                    helperStyle: TextStyle(color: Colors.black),
                    labelText: 'Daily Two',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 34, 255, 82),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Obx(
                () => TextFormField(
                  controller: controller.midtermExamController,
                  enabled: threeEdit.value,
                  decoration: const InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                    labelText: 'Midterm',
                    helperText: "From 20",
                    helperStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 34, 255, 82),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Obx(
                () => TextFormField(
                  controller: controller.finalExamController,
                  enabled: fourEdit.value,
                  decoration: const InputDecoration(
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 0, 0),
                      ),
                    ),
                    labelText: 'Final',
                    helperText: "From 60",
                    helperStyle: TextStyle(color: Colors.black),
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 34, 255, 82),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    oneEdit.value = !oneEdit.value;
                    twoEdit.value = !twoEdit.value;
                    threeEdit.value = !threeEdit.value;
                    fourEdit.value = !fourEdit.value;
                  },
                  child: const Text("Edit Marks"),
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  onPressed: () {
                    controller.saveStudentMarks(TeacherController.instance.teacher.value.subject);
                  },
                  child: const Text("Save Marks"),
                ),
              ],
            ),
          ],
        ));
  }
}
