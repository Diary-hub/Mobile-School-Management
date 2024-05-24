// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:schooll/Screens/Added.dart';
import 'package:schooll/services/controller/emp_controller.dart';

class EmpSignUp extends StatefulWidget {
  const EmpSignUp({super.key});

  @override
  _EmpSignUpState createState() => _EmpSignUpState();
}

class _EmpSignUpState extends State<EmpSignUp> {
  final controller = EmployeeController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Form(
            key: controller.formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: controller.firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.secondNameController,
                  decoration: const InputDecoration(
                    labelText: 'Second Name',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.birthdateController,
                  decoration: const InputDecoration(
                    labelText: 'Birthdate',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.idNumberController,
                  decoration: const InputDecoration(
                    labelText: 'ID Number',
                    contentPadding: EdgeInsets.all(5),
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () async {
                      await controller.saveempDataRecord('Employee');
                    },
                    elevation: 0.0,
                    minWidth: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void submitForm() {}
}
