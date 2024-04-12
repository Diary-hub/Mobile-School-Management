// ignore_for_file: library_private_types_in_public_api, unused_import, file_names, import_of_legacy_library_into_null_safe
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Added.dart';
import 'package:schooll/Screens/Parent_Signup.dart';
import 'package:schooll/services/controller/subject_controller.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/validators/validation.dart';

class TeachSignUp extends StatefulWidget {
  const TeachSignUp({Key? key}) : super(key: key);

  @override
  _TeachSignUpState createState() => _TeachSignUpState();
}

class _TeachSignUpState extends State<TeachSignUp> {
  final controller = TeacherController.instance;
  final subjectsController = SubjectAdderController.instance;
  @override
  void initState() {
    super.initState();
    subjectsController.fetchAllSubjectRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Sign Up'),
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
                  validator: (value) => KValidator.validateField("First Name", value),
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
                  validator: (value) => KValidator.validateField("Second Name", value),
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
                  validator: (value) => KValidator.validateField("Last Name", value),
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
                  validator: (value) => KValidator.validateField("Birthdate", value),
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
                  validator: (value) => KValidator.validateField("Address", value),
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
                  validator: (value) => KValidator.validateField("Phone Number", value),
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
                  validator: (value) => KValidator.validateEmail(value),
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
                  validator: (value) => KValidator.validateField("Password", value),
                  controller: controller.passwordController,
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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  validator: (value) => KValidator.validateField("ID Number", value),
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
                TextFormField(
                  validator: (value) => KValidator.validateField("Lives With", value),
                  controller: controller.whoLivesWithController,
                  decoration: const InputDecoration(
                    labelText: 'Lives With',
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
                Transform(
                  transform: Matrix4.translationValues(0.5, 0, 0),
                  child: DropdownSearch<String>(
                    maxHeight: 150,
                    validator: (v) => v == null ? "Please Select The Grade" : null,
                    hint: "Please Select The Grade",
                    mode: Mode.MENU,
                    showSelectedItem: true,
                    items: const [
                      '1',
                      '2',
                      '3',
                      '4',
                    ],
                    showClearButton: false,
                    onChanged: (value) {
                      controller.gradeController = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Transform(
                    transform: Matrix4.translationValues(0.5, 0, 0),
                    child: DropdownSearch<String>(
                      maxHeight: 150,
                      validator: (v) => v == null ? "Please Select The Grade" : null,
                      hint: "Please Select The Subject",
                      mode: Mode.MENU,
                      showSelectedItem: true,
                      items:
                          subjectsController.subjectList.map((element) => element.subject).toList(),
                      showClearButton: false,
                      onChanged: (value) {
                        controller.subjectController = value;
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  child: MaterialButton(
                    onPressed: () => controller.saveTeacherDataRecord(),
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
