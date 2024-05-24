// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, file_names

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Employee_SignUp.dart';
import 'package:schooll/services/controller/emp_controller.dart';
import 'package:schooll/services/models/employee_model.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  final controller = EmployeeController.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    controller.fetchAllempRecord();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
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

  String dropdownValue = "All";
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    RxString search = ''.obs;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Employee',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: ListView(
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
                            label: const Text('New Employee'),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                textStyle: const TextStyle(color: Colors.blueGrey)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => const EmpSignUp(),
                                  ));
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
                      child: Transform(
                        transform: Matrix4.translationValues(0.5, 0, 0),
                        child: DropdownSearch<String>(
                          selectedItem: 'All',
                          validator: (v) => v == null ? "Please Select The Subject" : null,
                          items: const ['All'],
                          onChanged: (value) {
                            setState(() {
                              if (value != "All") {
                                controller.filter.value = EmployeeModel.emptyList();

                                controller.length.value = controller.filter.length;
                              } else {
                                controller.filter.value = controller.empList.value;
                                controller.length.value = controller.empList.length;
                              }
                            });
                          },
                        ),
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
                                          controller.deleteEmpDataRecord(id);
                                        },
                                        icon: const Icon(Icons.delete)),
                                    leading: const Image(
                                        image: NetworkImage(
                                            "https://cdn-icons-png.freepik.com/512/10559/10559204.png")),
                                    title: Text("Name: ${controller.filter[index].getFulltName}"),
                                    subtitle: Text(
                                        "Grade: ${controller.filter[index].address} \n${controller.filter[index].email}"),
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
                                            controller.deleteEmpDataRecord(id);
                                          },
                                          icon: const Icon(Icons.delete)),
                                      leading: const Image(
                                          image: NetworkImage(
                                              "https://cdn-icons-png.freepik.com/512/10559/10559204.png")),
                                      title: Text("Name: ${controller.filter[index].getFulltName}"),
                                      subtitle: Text(
                                          "Grade: ${controller.filter[index].address} \n${controller.filter[index].email}"),
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
        );
      },
    );
  }
}
