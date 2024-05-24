// ignore_for_file: library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/DriverStudents.dart';
import 'package:schooll/Screens/Driver_Signup.dart';
import 'package:schooll/services/controller/driver_controller.dart';

class Driver extends StatefulWidget {
  const Driver({super.key});

  @override
  _DriverState createState() => _DriverState();
}

class _DriverState extends State<Driver> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  final controller = DriverController.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    controller.fetchAllDriverRecord();
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

  String dropdownValue = "All";
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text(
              'Driver',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 50,
                  //     right: 50,
                  //   ),
                  //   child: AnimSearchBar(
                  //       width: 450,
                  //       textController: textController,
                  //       rtl: false,
                  //       onSuffixTap: () {
                  //         setState(() {
                  //           textController.clear();
                  //         });
                  //       },
                  //       onSubmitted: (String searchText) {}),
                  // ),

                  ///////////////
                  ///Rowy new Student
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('New Driver'),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              textStyle: const TextStyle(color: Colors.blueGrey)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => const DriverSignUp(),
                                ));
                          },
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
                          itemCount: controller.driverList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                //SEND Driver OBJ get Databased on Driver
                                controller.fetchDriverStudents(controller.driverList[index]);
                                //GO TO LIST PAGE
                                Get.to(() => DriverStudents(
                                      driver: controller.driverList[index],
                                    ));
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
                                            String id = controller.driverList[index].id;
                                            controller.deletedIndex.value = index;
                                            controller.deleteDriverDataRecord(id);
                                          },
                                          icon: const Icon(Icons.delete)),
                                      leading: const Image(
                                          image: NetworkImage(
                                              "https://cdn-icons-png.flaticon.com/512/1581/1581908.png")),
                                      title: Text(
                                          "Name: ${controller.driverList[index].getFulltName}"),
                                      subtitle:
                                          Text("Grade: ${controller.driverList[index].grade}"),
                                    ),
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
              //   child: DropdownButton<String>(
              //     value: dropdownValue,
              //     // icon: Icon(Icons.search),
              //     style: const TextStyle(color: Colors.blueGrey),
              //     underline: Container(
              //       height: 2,
              //       width: double.infinity * 0.45,
              //       color: Colors.blueGrey,
              //     ),
              //     onChanged: (String? newValue) {
              //       setState(() {
              //         dropdownValue = newValue!;
              //       });
              //     },
              //     items: const [
              //       DropdownMenuItem(value: 'All', child: Text('All')),
              //       DropdownMenuItem(value: 'Private', child: Text('Private')),
              //       DropdownMenuItem(value: 'Public', child: Text('Public')),
              //     ],
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
