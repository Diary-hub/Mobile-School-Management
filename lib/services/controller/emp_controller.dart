import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schooll/Screens/Employee.dart';
import 'package:schooll/services/controller/user_controller.dart';
import 'package:schooll/services/models/employee_model.dart';
import 'package:schooll/services/models/user_model.dart';
import 'package:schooll/services/repository/emp_repoo.dart';
import '../utils/helpers/network.dart';
import '../utils/loaders/snack_loaders.dart';

class EmployeeController extends GetxController {
  static EmployeeController get instance => Get.find();

  final length = 0.obs;
  final deletedIndex = 0.obs;
  final profileLoading = false.obs;
  RxList<EmployeeModel> empList = <EmployeeModel>[].obs;
  Rx<EmployeeModel> emp = EmployeeModel.empty().obs;
  RxList<EmployeeModel> filter = <EmployeeModel>[].obs;

  final empRepository = Get.put(EmpRepository());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();

  String getUserType() {
    final auth = UserController.instance;
    UserModel user = auth.user.value;

    return user.type;
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future<void> deleteEmpDataRecord(String id) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Deleting', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Delete Record
      await empRepository.deleteEmpRecord(id);
      empList.removeAt(deletedIndex.value);
      KLoaders.successSnackBar(title: "Emp Deleted", message: "Record Deleted!", duration: 1);
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  Future<void> saveempDataRecord(String type) async {
    try {
      // Start Loader
      KLoaders.warningSnackBar(message: "Please Wait", title: 'Saving', duration: 1);

      // Check For internet Connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        KLoaders.warningSnackBar(message: "Please Wait ...", title: 'No connection ');

        return;
      }

      // Validate The Data
      if (formkey.currentState!.validate() != true) {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");

        return;
      }

      final emp = EmployeeModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          phoneNumber: phoneController.text,
          email: emailController.text,
          secondName: secondNameController.text,
          birthdate: birthdateController.text,
          address: addressController.text,
          idNumber: idNumberController.text,
          type: type);

      await empRepository.saveEmpRecord(emp);
      KLoaders.successSnackBar(title: "Emp Record", message: "Record Added");
      firstNameController.text = '';
      secondNameController.text = '';
      lastNameController.text = '';
      birthdateController.text = '';
      addressController.text = '';
      phoneController.text = '';
      emailController.text = '';
      idNumberController.text = '';
      Get.back();
      Get.off(const Employee());
    } catch (e) {
      // This is I Think The Empty Error
      if (e.toString() == "An unexpected authentication error occurred. Please try again.") {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: "Please Fill The Informations");
      } else {
        KLoaders.errorSnackBar(title: "Something Wrong !", message: e.toString());
      }
    }
  }

  // Get User Data
  Future<void> fetchempRecord(id) async {
    try {
      profileLoading.value = true;
      final emp = await empRepository.fetchEmpData(id);
      this.emp(emp);
    } catch (e) {
      emp(EmployeeModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Get User Data
  Future<void> fetchAllempRecord() async {
    try {
      profileLoading.value = true;
      final empList = await empRepository.fetchAllEmpData();
      this.empList(empList);
    } catch (e) {
      empList(EmployeeModel.emptyList());
    } finally {
      profileLoading.value = false;
    }
  }
}
