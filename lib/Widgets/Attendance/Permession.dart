// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:schooll/services/controller/attend_controller.dart';

class PermessionCard extends StatefulWidget {
  final String time;
  final String date;
  final String subject;
  final String student;
  final int index;
  final bool isTeacher;
  final bool isStudent;

  const PermessionCard({
    Key? key,
    required this.date,
    required this.time,
    required this.subject,
    required this.student,
    required this.index,
    required this.isTeacher,
    required this.isStudent,
  }) : super(key: key);

  @override
  _PermessionCardState createState() => _PermessionCardState();
}

class _PermessionCardState extends State<PermessionCard> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation;
  late AnimationController animationController;
  final controller = AttendanceController.instance;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: const Interval(0.3, 0.7, curve: Curves.fastOutSlowIn)));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Transform(
            transform: Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 3),
                    //blurRadius: 3,
                    //spreadRadius: 1,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.time,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.date,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.subject,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.student,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  widget.isStudent || widget.isTeacher
                      ? Container(
                          color: Colors.white,
                        )
                      : IconButton(
                          onPressed: () {
                            controller.deletedIndex.value = widget.index;
                            controller.deleteAttendanceDataRecord(
                                controller.attendanceList[widget.index].id!);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
