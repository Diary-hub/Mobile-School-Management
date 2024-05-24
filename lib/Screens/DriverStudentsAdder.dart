// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/services/controller/driver_controller.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/models/driver_model.dart';

class DriverStudentsAdder extends StatelessWidget {
  final DriverModel driver;

  const DriverStudentsAdder({Key? key, required this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = StudentController.instance;
    final driverController = DriverController.instance;
    studentController.fetchAllStudentRecordByGrade(driver);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Students',
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Column(
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                  child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: studentController.studentList.length,
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
                                      driverController.addStudentToDriver(
                                          driver, studentController.studentList[index], index);
                                      studentController.fetchAllStudentRecordByGrade(driver);
                                    },
                                    icon: const Icon(Icons.add)),
                                leading: const Image(
                                    image: NetworkImage(
                                        "https://cdn-icons-png.freepik.com/512/10559/10559204.png")),
                                title: Text(
                                    "Name: ${studentController.studentList[index].getFulltName}"),
                                subtitle:
                                    Text("Gender: ${studentController.studentList[index].gender}"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
