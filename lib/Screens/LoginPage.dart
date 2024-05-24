// ignore_for_file: import_of_legacy_library_into_null_safe, file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/BouncingButton.dart';
import 'package:schooll/services/controller/login_contoller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

import 'ForgetPasseord.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // ignore: non_constant_identifier_names
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
    super.initState();
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

  bool passshow = false;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    final controller = Get.put(LoginController());

    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, child) {
        return Scaffold(
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
                          'Wellcome',
                          style: TextStyle(
                              color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 35.0, 0, 0),
                          child: Text(
                            'To KD',
                            style: TextStyle(
                                color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(135.0, 0.0, 0, 30),
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
                          key: controller.formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: controller.email,
                                validator: (value) => KValidator.validateEmail(value),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'EMAIL@Gmail.com',
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
                                controller: controller.password,
                                obscuringCharacter: '*',
                                validator: (value) => KValidator.validateField("Password", value),
                                decoration: InputDecoration(
                                    suffix: passshow == false
                                        ? IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passshow = true;
                                              });
                                            },
                                            icon: const Icon(Icons.lock_open),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              setState(() {
                                                passshow = false;
                                              });
                                            },
                                            icon: const Icon(Icons.lock),
                                          ),
                                    labelText: 'PASSWORD',
                                    contentPadding: const EdgeInsets.all(5),
                                    labelStyle: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blueGrey))),
                                obscureText: passshow == false ? true : false,
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
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 10),
                child: Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value * width, 0, 0),
                  child: Container(
                    alignment: const Alignment(1.0, 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                      child: Bouncing(
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ForgetPassword(),
                              ));
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
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
                        onPress: () => controller.emailAndPasswordLogin(),
                        child: MaterialButton(
                          onPressed: () {},
                          elevation: 0.0,
                          minWidth: MediaQuery.of(context).size.width,
                          color: Colors.blueGrey,
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      // Bouncing(
                      //   onPress: () {},
                      //   child: MaterialButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 RequestLogin(),
                      //           ));
                      //     },
                      //     elevation: 0.5,
                      //     minWidth: MediaQuery.of(context).size.width,
                      //     color: Colors.grey[300],
                      //     child: ListTile(
                      //       leading: Icon(
                      //         Icons.fingerprint,
                      //         color: Colors.black,
                      //       ),
                      //       title: Text('Request Login ID'),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              )
            ],
          ),
        );
      },
    );
  }
}
