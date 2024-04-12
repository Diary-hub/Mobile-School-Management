// ignore_for_file: import_of_legacy_library_into_null_safe, file_names, non_constant_identifier_names, unnecessary_null_comparison
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Parent_Seen/ParentHome.dart';
import 'package:schooll/Widgets/Exams/SubjectCard.dart';
import 'package:randomizer/randomizer.dart';
import 'package:schooll/services/controller/exam_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/controller/subject_controller.dart';

class ParentExamResult extends StatefulWidget {
  const ParentExamResult({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ParentExamResultState createState() => _ParentExamResultState();
}

class _ParentExamResultState extends State<ParentExamResult> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  Randomizer randomcolor = Randomizer();
  final controller = ExamAdderController.instance;
  final subjectsController = SubjectAdderController.instance;
  final studentController = StudentController.instance;
  String grade = 'Your Subjects';
  @override
  void initState() {
    super.initState();
    controller.fetchAllexamRecord();
    subjectsController.fetchAllSubjectRecord();

    //SystemChrome.setEnabledSystemUIOverlays([]);

    animationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
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
                    onPressed: () => Get.offAll(const Parent_Home()),
                    icon: const Icon(Icons.arrow_back)),
                title: const Text(
                  'Exam',
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
                      Transform(
                        transform:
                            Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                        child: DropdownSearch<String>(
                          validator: (v) => v == null ? "Please Select The Subject" : null,
                          hint: "Please Select The Subject",
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: subjectsController.subjectList
                              .map((element) => element.subject)
                              .toList()
                            ..add('All'),
                          showClearButton: false,
                          selectedItem: grade,
                          onChanged: (newValue) {
                            setState(() {
                              grade = newValue;
                              if (grade != 'All') {
                                controller.filter = controller.examList
                                    .where((exam) => exam.examSubject == grade)
                                    .toList();
                                controller.length.value = controller.filter.length;
                              } else {
                                controller.filter = controller.examList;
                                controller.length.value = controller.filter.length;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Obx(
                        () => SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: controller.length.value,
                            itemBuilder: (context, index) => Transform(
                              transform: Matrix4.translationValues(
                                  muchDelayedAnimation.value * width, 0, 0),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SubjectCard(
                                  isStudent: true,
                                  isExam: true,
                                  isSubject: false,
                                  indexed: index,
                                  id: controller.filter[index].idNumber,
                                  mode: controller.filter[index].mode,
                                  subjectname: controller.filter[index].examSubject,
                                  chapter: controller.filter[index].getChapters,
                                  date: controller.filter[index].getDate,
                                  grade: controller.filter[index].grade,
                                  mark: controller.filter[index].marks,
                                  time: controller.filter[index].getDurattion,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Transform(
                                transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * width, 0, 0),
                                child: const Text(
                                  "Total Quizes In The Week:",
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: height * 0.03,
                              ),
                              Transform(
                                transform:
                                    Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                                child: Text(
                                  "${controller.examList.length}",
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
