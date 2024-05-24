// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:schooll/services/controller/driver_controller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

class DriverSignUp extends StatefulWidget {
  const DriverSignUp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DriverSignUpState createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
  final controller = DriverController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Form(
            key: controller.formkey1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: controller.firstNameController,
                  validator: (value) => KValidator.validateField("First Name", value),
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
                  validator: (value) => KValidator.validateField("Second Name", value),
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
                  validator: (value) => KValidator.validateField("Last Name", value),
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
                  controller: controller.addressController,
                  validator: (value) => KValidator.validateField("Address", value),
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
                  validator: (value) => KValidator.validateField("Phone", value),
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
                  controller: controller.idNumberController,
                  validator: (value) => KValidator.validateField("ID Number", value),
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
                TextFormField(
                  controller: controller.gradeController,
                  validator: (value) => KValidator.validateField("Grade", value),
                  decoration: const InputDecoration(
                    labelText: 'Grade',
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
                  controller: controller.emailController,
                  validator: (value) => KValidator.validateEmail(value),
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
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: controller.passwordController,
                  validator: (value) => KValidator.validatePassword(value),
                  decoration: const InputDecoration(
                    labelText: 'Password',
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
                  controller: controller.carBrandController,
                  validator: (value) => KValidator.validateField("Car Brand", value),
                  decoration: const InputDecoration(
                    labelText: 'Car Brand',
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
                  controller: controller.carModelController,
                  validator: (value) => KValidator.validateField("Car Model", value),
                  decoration: const InputDecoration(
                    labelText: 'Car Model',
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
                  controller: controller.carNumberController,
                  validator: (value) => KValidator.validateField("Car Number", value),
                  decoration: const InputDecoration(
                    labelText: 'Car Number',
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
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () {
                      controller.saveDriverDataRecord();
                    },
                    elevation: 0.0,
                    minWidth: MediaQuery.of(context).size.width,
                    color: Colors.blueGrey,
                    child: const Text(
                      "Next ->",
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
}
