// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe, file_names
import 'package:flutter/material.dart';

import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';

class SubjectCard extends StatelessWidget {
  final String subjectname;
  final String chapter;
  final String date;
  final String time;
  final String grade;
  final String mark;
  final String mode;
  final String id;
  final int indexed;
  final bool isSubject;
  final bool isExam;
  final bool isStudent;

  const SubjectCard(
      {Key? key,
      required this.subjectname,
      required this.chapter,
      required this.date,
      required this.time,
      required this.grade,
      required this.mode,
      required this.mark,
      required this.id,
      required this.indexed,
      required this.isSubject,
      required this.isExam,
      required this.isStudent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final controller = ExamAdderController.instance;
    final subjectController = SubjectAdderController.instance;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(0, 2),
              spreadRadius: 1,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 13,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  height: height * 0.1,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        subjectname,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "chapter $chapter",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        mode,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                isSubject
                    ? isStudent == false
                        ? IconButton(
                            onPressed: () {
                              subjectController.deletedIndex.value = indexed;
                              subjectController.deleteSubjectDataRecord(id);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                        : Container(color: Colors.white)
                    : isExam
                        ? isStudent == false
                            ? IconButton(
                                onPressed: () {
                                  controller.deletedIndex.value = indexed;
                                  controller.deleteExamDataRecord(id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                            : Container(color: Colors.white)
                        : Container(),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    time,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "Marks:$mark",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      overflow: TextOverflow.ellipsis,
                      "Grade:$grade",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
