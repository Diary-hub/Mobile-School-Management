// ignore_for_file: library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names, non_constant_identifier_names, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Student_Seen/St_Home.dart';
import 'package:schooll/Widgets/Exams/SubjectCard.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';

class StudentSubject extends StatefulWidget {
  const StudentSubject({super.key});

  @override
  _StudentSubjectState createState() => _StudentSubjectState();
}

class _StudentSubjectState extends State<StudentSubject> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  final controller = SubjectAdderController.instance;
  String grade = 'All';

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    controller.fetchAllSubjectRecordByGrade(StudentController.instance.student.value.grade);
    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, child) {
          final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () => Get.offAll(const Student_Home()),
                    icon: const Icon(Icons.arrow_back_ios)),
                title: const Text(
                  'Subjects',
                ),
                backgroundColor: Colors.blueGrey,
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      // Transform(
                      //   transform:
                      //       Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                      //   child: DropdownSearch<String>(
                      //     validator: (v) => v == null ? "Please Select The Grade" : null,
                      //     hint: "Please Select The Grade",
                      //
                      //
                      //     items: const [
                      //       "All",
                      //       "1",
                      //       "2",
                      //       "3",
                      //       "4",
                      //     ],
                      //
                      //     selectedItem: grade,
                      //     onChanged: (newValue) {
                      //       setState(() {
                      //         grade = newValue;
                      //         if (grade != 'All') {
                      //           controller.filter = controller.subjectList
                      //               .where((exam) => exam.grade == grade)
                      //               .toList();
                      //           controller.length.value = controller.filter.length;
                      //         } else {
                      //           controller.filter = controller.subjectList;
                      //           controller.length.value = controller.filter.length;
                      //         }
                      //       });
                      //     },
                      //   ),
                      // ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      SizedBox(
                          height: 400,
                          child: controller.subjectList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: controller.subjectList.length,
                                  itemBuilder: (context, index) => Transform(
                                    transform: Matrix4.translationValues(
                                        muchDelayedAnimation.value * width, 0, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: SubjectCard(
                                        isStudent: true,
                                        isSubject: true,
                                        isExam: false,
                                        id: controller.subjectList[index].idNumber,
                                        indexed: index,
                                        mode: '',
                                        subjectname: controller.subjectList[index].subject,
                                        chapter: controller.subjectList[index].chapters,
                                        date: controller.subjectList[index].teacherName,
                                        grade: controller.subjectList[index].grade,
                                        mark: controller.subjectList[index].marks,
                                        time: "",
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text("There No Subjets Yet"),
                                )),
                    ],
                  ),
                ),
              ));
        });
  }
}
