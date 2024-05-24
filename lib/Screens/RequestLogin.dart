// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:fzregex/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:schooll/Widgets/BouncingButton.dart';

import 'RequestProcessing.dart';

class RequestLogin extends StatefulWidget {
  const RequestLogin({super.key});

  @override
  _RequestLoginState createState() => _RequestLoginState();
}

class _RequestLoginState extends State<RequestLogin> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
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

  late String email, phno, name, rollno;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        return Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Transform(
                  transform: Matrix4.translationValues(animation.value * width, 0.0, 0.0),
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        const Text(
                          'Request',
                          style: TextStyle(
                              color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(70.0, 35.0, 0, 0),
                          child: Text(
                            'ID',
                            style: TextStyle(
                                color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(105.0, 0.0, 0, 30),
                          child: Text(
                            '.',
                            style: TextStyle(
                                color: Colors.green[400],
                                fontSize: 80.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform: Matrix4.translationValues(LeftCurve.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[a-zA-Z]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter your Name!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild name';
                                  }
                                },
                                onSaved: (val) {
                                  name = val!;
                                },
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  labelText: 'Name',
                                  contentPadding: EdgeInsets.all(5),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                onSaved: (val) {
                                  rollno = val!;
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Enter your Roll Number';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Roll Number',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey))),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                onSaved: (val) {},
                                validator: (value) {
                                  RegExp nameRegExp = RegExp('[0-9]');
                                  if (value!.isEmpty) {
                                    return 'You Must enter your class!';
                                  } else if (nameRegExp.hasMatch(value)) {
                                    return null;
                                  } else {
                                    return 'Enter Vaild class';
                                  }
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Class',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey))),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                validator: (value) {
                                  if ((Fzregex.hasMatch(value!, FzPattern.email) == false)) {
                                    return "Enter Vaild Email address";
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  email = value!;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    labelText: 'E-Mail',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey))),
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                validator: (value) {
                                  String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = RegExp(pattern);
                                  if (value!.isEmpty) {
                                    return 'Please enter mobile number';
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  phno = val!;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Phone Number',
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey))),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Transform(
                  transform: Matrix4.translationValues(muchDelayedAnimation.value * width, 0, 0),
                  child: Column(
                    children: <Widget>[
                      Bouncing(
                        onPress: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => ProcessingRequest(),
                                ));
                          }
                        },
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.blueGrey,
                          child: const Text(
                            "Request",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      },
    );
  }
}
