import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooll/Screens/Employee_SignUp.dart';
import 'package:schooll/Screens/Student_Signup.dart';

class Employee extends StatefulWidget {
  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee>
    with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    SystemChrome.setEnabledSystemUIOverlays([]);
    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn)));

    LeftCurve = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut)));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  String dropdownValue = "All";
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        final GlobalKey<ScaffoldState> _scaffoldKey =
            new GlobalKey<ScaffoldState>();
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              'Employee',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: ListView(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 50,
                      ),
                      child: AnimSearchBar(
                          width: 450,
                          textController: textController,
                          rtl: false,
                          onSuffixTap: () {
                            setState(() {
                              textController.clear();
                            });
                          },
                          onSubmitted: (String searchText) {
                            print('Search submitted: $searchText');
                          }),
                    ),

                    ///////////////
                    ///Rowy new Student
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50, left: 50),
                          child: OutlinedButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('New Employee'),
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                textStyle: TextStyle(color: Colors.blueGrey)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        EmpSignUp(),
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    // icon: Icon(Icons.search),
                    style: TextStyle(color: Colors.blueGrey),
                    underline: Container(
                      height: 2,
                      width: double.infinity * 0.45,
                      color: Colors.blueGrey,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: [
                      DropdownMenuItem(value: 'All', child: Text('All')),
                      DropdownMenuItem(
                          value: 'Group One', child: Text('Group One')),
                      DropdownMenuItem(
                          value: 'Group Two', child: Text('Group Two')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
