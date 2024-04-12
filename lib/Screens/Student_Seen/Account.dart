// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/profile_tile_info.dart';
import 'package:schooll/Widgets/see_more_section.dart';
import 'package:schooll/services/controller/student_controller.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class StudentAccount extends StatefulWidget {
  const StudentAccount({Key? key}) : super(key: key);

  @override
  _StudentAccountState createState() => _StudentAccountState();
}

class _StudentAccountState extends State<StudentAccount> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final controller = StudentController.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    controller.student.value.getParentName();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    animationController = AnimationController(duration: const Duration(seconds: 0), vsync: this);
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

  String dropdownValue = "All";
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
              'Account',
            ),
            centerTitle: true,
            backgroundColor: Colors.blueGrey,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            width: 100,
                            height: 100,
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/2784/2784461.png"),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  const Divider(),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  SeeMoreSection(
                    title: "Personal information",
                    titleStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.red, fontSize: 18),
                    subTitle: "",
                    showButton: false,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  ProfileTileInfo(
                    title: "Name",
                    value: controller.student.value.getFulltName,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Phone",
                    value: KFormatter.formatPhoneNumber(controller.student.value.phoneNumber),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  const Divider(),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  SeeMoreSection(
                    title: "Student Information",
                    titleStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.red, fontSize: 18),
                    subTitle: "",
                    showButton: false,
                  ),
                  ProfileTileInfo(
                    title: "ID Number",
                    value: controller.student.value.idNumber,
                    icon: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_all)),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Email",
                    value: controller.student.value.email,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  Obx(
                    () => ProfileTileInfo(
                      title: "Parent Name",
                      value: controller.student.value.parentName.value,
                    ),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Birth Date",
                    value: controller.student.value.birthdate,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Grade",
                    value: controller.student.value.grade,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  const Divider(),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
