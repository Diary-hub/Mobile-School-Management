// ignore_for_file: library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names, non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/DriverStudentsAdder.dart';
import 'package:schooll/services/controller/driver_controller.dart';
import 'package:schooll/services/models/driver_model.dart';

class DriverStudents extends StatefulWidget {
  final DriverModel driver;
  const DriverStudents({super.key, required this.driver});

  @override
  _DriverStudentsState createState() => _DriverStudentsState();
}

class _DriverStudentsState extends State<DriverStudents> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  final controller = DriverController.instance;

  @override
  void initState() {
    super.initState();
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
              'Driver Students',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50),
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Students'),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              textStyle: const TextStyle(color: Colors.blueGrey)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DriverStudentsAdder(driver: widget.driver),
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
                          itemCount: widget.driver.students.length,
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
                                          controller.deleteDriverStudent(
                                              widget.driver.students[index].id!,
                                              widget.driver,
                                              index);
                                        },
                                        icon: const Icon(Icons.delete)),
                                    leading: const Image(
                                        image: NetworkImage(
                                            "https://cdn-icons-png.flaticon.com/512/2784/2784461.png")),
                                    title:
                                        Text("Name: ${widget.driver.students[index].getFulltName}"),
                                    subtitle:
                                        Text("Gender: ${widget.driver.students[index].gender}"),
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
      },
    );
  }
}
