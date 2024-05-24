// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Parent_Seen/ParentHome.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/models/student_model.dart';

class MarksParent extends StatelessWidget {
  const MarksParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = StudentController.instance;
    final subjects = SubjectAdderController.instance;
    StudentModel st = StudentModel.empty();
    void getDatas() async {
      st = await controller
          .fetchByChangeIDtoUID(ParentController.instance.parent.value.studentIDNumber);

      subjects.fetchAllSubjectRecordByGrade(st.grade);
    }

    getDatas();

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.to(() => const Parent_Home());
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            'My Marks',
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Obx(
          () => subjects.subjectList.isNotEmpty
              ? ListView.builder(
                  itemCount: subjects.subjectList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            tileColor: Colors.grey.shade100,
                            title: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(subjects.subjectList[index].subject),
                            ),
                            subtitle: const Text('Click To View Marks'),
                            trailing: IconButton(
                              onPressed: () async {
                                final String sub = subjects.subjectList[index].subject;
                                final StudentModel student = await controller.fetchByChangeIDtoUID(
                                    ParentController.instance.parent.value.studentIDNumber);
                                await controller.fetchStudentRecordBySubjectID(sub, student.id);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Grade Marks'),
                                      content: SingleChildScrollView(
                                        child: Table(
                                          border: TableBorder.all(),
                                          children: [
                                            const TableRow(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('Type')),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('Marks')),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('DailyOne')),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TableCell(
                                                      child:
                                                          Text(controller.dailyOneController.text)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('DailyTwo')),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TableCell(
                                                      child:
                                                          Text(controller.dailyTwoController.text)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('Midterm Exam')),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TableCell(
                                                      child: Text(
                                                          controller.midtermExamController.text)),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: TableCell(child: Text('Final Exam')),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TableCell(
                                                      child: Text(
                                                          controller.finalExamController.text)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            )));
                  },
                )
              : const Center(
                  child: Text("There No Subjets Yet"),
                ),
        ));
  }
}
