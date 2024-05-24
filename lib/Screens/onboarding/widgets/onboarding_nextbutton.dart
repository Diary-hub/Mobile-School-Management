import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:schooll/services/controller/onboarding_controller.dart';
import 'package:schooll/services/utils/device/device_utility.dart';
import 'package:schooll/services/utils/device/sizes.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: KSizes.defaultSpace,
      bottom: KDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(
          Iconsax.arrow_right_3,
          color: Colors.black,
        ),
      ),
    );
  }
}
