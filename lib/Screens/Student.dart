// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names, unrelated_type_equality_checks
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Student_Signup.dart';
import 'package:schooll/Screens/home.dart';
import 'package:schooll/Screens/profileViwerStudent.dart';
import 'package:schooll/services/controller/parent_controller.dart';

import '../services/controller/student_controller.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  final controller = StudentController.instance;
  final parenntController = ParentController.instance;

  TextEditingController textController = TextEditingController();

  String grade = '0';
  String gender = '0';

  @override
  void initState() {
    super.initState();
    controller.fetchAllStudentRecord();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();

    RxString search = ''.obs;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Get.off(const Home()), icon: const Icon(Icons.arrow_back_ios)),
            title: const Text(
              'Student',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          top: 30,
                          right: 50,
                        ),
                        child: SizedBox(
                          width: 420,
                          child: TextFormField(
                            decoration: const InputDecoration(border: OutlineInputBorder()),
                            controller: textController,
                            onChanged: (value) {
                              search.value = value;
                            },
                            onSaved: (value) {},
                            onFieldSubmitted: (value) {
                              setState(() {
                                search.value = value;
                              });
                            },
                          ),
                        ),
                      ),

                      ///////////////
                      ///Rowy new Student
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 50, left: 50),
                            child: OutlinedButton.icon(
                              icon: const Icon(Icons.add),
                              label: const Text('New Student'),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  textStyle: const TextStyle(color: Colors.blueGrey)),
                              onPressed: () {
                                Get.to(const StSignUp());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                        child: DropdownButton<String>(
                          value: grade,
                          // icon: Icon(Icons.search),
                          style: const TextStyle(color: Colors.blueGrey),
                          underline: Container(
                            height: 2,
                            color: Colors.blueGrey,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              grade = newValue!;
                              if (grade != '0') {
                                controller.filter = controller.studentList
                                    .where((student) => student.grade == grade)
                                    .toList();
                                controller.length.value = controller.filter.length;
                              } else {
                                controller.filter = controller.studentList;
                                controller.length.value = controller.filter.length;
                              }
                            });
                          },
                          items: const [
                            DropdownMenuItem(value: '0', child: Text('All')),
                            DropdownMenuItem(value: '1', child: Text('Grade One-1')),
                            DropdownMenuItem(value: '2', child: Text('Grade Two-2')),
                            DropdownMenuItem(value: '3', child: Text('Grade Three-3')),
                            DropdownMenuItem(value: '4', child: Text('Grade Four-4')),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                        child: DropdownButton<String>(
                          value: gender,
                          // icon: Icon(Icons.search),
                          style: const TextStyle(color: Colors.blueGrey),
                          underline: Container(
                            height: 2,
                            color: Colors.blueGrey,
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              gender = newValue!;
                              if (gender != '0') {
                                if (grade != '0') {
                                  controller.filter = controller.studentList
                                      .where((student) => student.grade == grade)
                                      .toList();
                                  controller.length.value = controller.filter.length;
                                } else {
                                  controller.filter = controller.studentList;
                                  controller.length.value = controller.filter.length;
                                }

                                gender == '1'
                                    ? controller.filter = controller.filter
                                        .where((student) => student.gender == "Male")
                                        .toList()
                                    : controller.filter = controller.filter
                                        .where((student) => student.gender == "Female")
                                        .toList();

                                controller.length.value = controller.filter.length;
                              } else {
                                if (grade != '0') {
                                  controller.filter = controller.studentList
                                      .where((student) => student.grade == grade)
                                      .toList();
                                  controller.length.value = controller.filter.length;
                                } else {
                                  controller.filter = controller.studentList;
                                  controller.length.value = controller.filter.length;
                                }
                              }
                            });
                          },
                          items: const [
                            DropdownMenuItem(value: '0', child: Text('All')),
                            DropdownMenuItem(value: '1', child: Text('Male')),
                            DropdownMenuItem(value: '2', child: Text('Female')),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                    child: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: controller.length.value,
                        itemBuilder: (context, index) {
                          if (textController.text == '' || textController.text == ' ') {
                            return InkWell(
                              onTap: () {
                                Get.to(
                                    () => ProfileViewerStudent(studnet: controller.filter[index]));
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
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
                                            String id = controller.filter[index].idNumber;
                                            controller.deletedIndex.value = index;
                                            controller.deleteStudentDataRecord(id);
                                          },
                                          icon: const Icon(Icons.delete)),
                                      leading: const Image(
                                          image: NetworkImage(
                                              "https://cdn-icons-png.flaticon.com/512/2784/2784461.png")),
                                      title: Text(
                                          "Name: ${grade != '0' ? controller.filter[index].getFulltName : controller.studentList[index].getFulltName}"),
                                      subtitle: Text(
                                          "Grade: ${grade != '0' ? controller.filter[index].grade : controller.studentList[index].grade}"),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            if (controller.filter[index].getFulltName
                                .toLowerCase()
                                .contains(textController.text.toLowerCase())) {
                              return InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
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
                                              String id = controller.filter[index].idNumber;
                                              controller.deletedIndex.value = index;
                                              controller.deleteStudentDataRecord(id);
                                            },
                                            icon: const Icon(Icons.delete)),
                                        leading: const Image(
                                            image: NetworkImage(
                                                "https://cdn-icons-png.flaticon.com/512/2784/2784461.png")),
                                        title: Text(
                                            "Name: ${grade != '0' ? controller.filter[index].getFulltName : controller.studentList[index].getFulltName}"),
                                        subtitle: Text(
                                            "Grade: ${grade != '0' ? controller.filter[index].grade : controller.studentList[index].grade}"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const Text('');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
