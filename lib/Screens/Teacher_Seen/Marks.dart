// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Teacher_Seen/MarkdEdit.dart';
import 'package:schooll/Screens/Teacher_Seen/TeacherHome.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = StudentController.instance;

    controller.filter = controller.studentList
        .where((student) => student.grade == TeacherController.instance.teacher.value.grade)
        .toList();
    controller.length.value = controller.filter.length;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => const Teacher_Home());
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'Marks',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
          child: SizedBox(
            height: 400,
            child: ListView.builder(
              itemCount: controller.length.value,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber[100],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        trailing: IconButton(
                            onPressed: () {
                              controller.studentEdit.value = controller.filter[index];
                              Get.to(() => const MarksEditScreen());
                            },
                            icon: const Icon(Icons.edit)),
                        leading: const Image(
                            image: NetworkImage(
                                "https://cdn-icons-png.freepik.com/512/10559/10559204.png")),
                        title: Text("Name: ${controller.filter[index].getFulltName}"),
                        subtitle: Text("Grade: ${controller.filter[index].grade}"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
