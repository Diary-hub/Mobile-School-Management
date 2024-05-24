// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/Shimmer.dart';
import 'package:schooll/services/controller/driver_controller.dart';

class DriverDetailCard extends StatefulWidget {
  const DriverDetailCard({Key? key}) : super(key: key);

  @override
  _DriverDetailCardState createState() => _DriverDetailCardState();
}

class _DriverDetailCardState extends State<DriverDetailCard> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

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

    final driverController = DriverController.instance;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 3),
          child: Container(
            alignment: const Alignment(0, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.17,
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform(
                            transform:
                                Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 28,
                                backgroundImage: AssetImage("assets/home.png"),
                              ),
                            ),
                          ),
                          Transform(
                            transform:
                                Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Obx(() {
                                      if (driverController.profileLoading.value == true) {
                                        return const ShimmerEffect(width: 80, height: 15);
                                      } else {
                                        return Text(
                                          driverController.driver.value.getFulltName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21,
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Grade: ${driverController.driver.value.grade}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 100,
                                        ),
                                        Text(
                                          "Driver ID: ${driverController.driver.value.idNumber}",
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
