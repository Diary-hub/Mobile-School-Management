// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, import_of_legacy_library_into_null_safe, file_names
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:schooll/Widgets/profile_tile_info.dart';
import 'package:schooll/Widgets/see_more_section.dart';
import 'package:schooll/services/controller/parent_controller.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:schooll/services/utils/formatters/formatter.dart';

class ParenttAccount extends StatefulWidget {
  const ParenttAccount({Key? key}) : super(key: key);

  @override
  _ParenttAccountState createState() => _ParenttAccountState();
}

class _ParenttAccountState extends State<ParenttAccount> with SingleTickerProviderStateMixin {
  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;
  final controller = ParentController.instance;

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
                                "https://cdn-icons-png.freepik.com/512/437/437501.png"),
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
                    value: controller.parent.value.getFulltName,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Phone",
                    value: KFormatter.formatPhoneNumber(controller.parent.value.phoneNumber),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  const Divider(),
                  const SizedBox(height: KSizes.spaceBetweenItems / 2),
                  SeeMoreSection(
                    title: "Parent Information",
                    titleStyle: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.red, fontSize: 18),
                    subTitle: "",
                    showButton: false,
                  ),
                  ProfileTileInfo(
                    title: "ID Number",
                    value: controller.parent.value.idNumber,
                    icon: IconButton(onPressed: () {}, icon: const Icon(Icons.copy_all)),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Email",
                    value: controller.parent.value.email,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  Obx(
                    () => ProfileTileInfo(
                      title: "Student ID",
                      value: controller.parent.value.studentIDNumber,
                    ),
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
                  ProfileTileInfo(
                    title: "Birth Date",
                    value: controller.parent.value.birthdate,
                  ),
                  const SizedBox(height: KSizes.spaceBetweenItems),
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
