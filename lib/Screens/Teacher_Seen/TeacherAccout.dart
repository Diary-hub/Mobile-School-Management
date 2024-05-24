// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:schooll/Widgets/profile_tile_info.dart';
import 'package:schooll/Widgets/see_more_section.dart';
import 'package:schooll/services/controller/teacher_controller.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class TeacherAccount extends StatefulWidget {
  const TeacherAccount({Key? key}) : super(key: key);

  @override
  _TeacherAccountState createState() => _TeacherAccountState();
}

class _TeacherAccountState extends State<TeacherAccount> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final controller = TeacherController.instance;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
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
                                "https://cdn-icons-png.freepik.com/512/10559/10559204.png"),
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
                    value: controller.teacher.value.getFulltName,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Phone",
                    value: KFormatter.formatPhoneNumber(controller.teacher.value.phoneNumber),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  const Divider(),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  SeeMoreSection(
                    title: "Teacher Information",
                    titleStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.red, fontSize: 18),
                    subTitle: "",
                    showButton: false,
                  ),
                  ProfileTileInfo(
                    title: "ID Number",
                    value: controller.teacher.value.idNumber,
                    icon: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_all)),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Email",
                    value: controller.teacher.value.email,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Subject",
                    value: controller.teacher.value.subject,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Birth Date",
                    value: controller.teacher.value.birthdate,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Grade",
                    value: controller.teacher.value.grade,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Department",
                    value: controller.teacher.value.department,
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
