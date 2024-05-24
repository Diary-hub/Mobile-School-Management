import 'package:flutter/material.dart';
import 'package:schooll/services/controller/onboarding_controller.dart';
import 'package:schooll/services/utils/device/device_utility.dart';
import 'package:schooll/services/utils/device/sizes.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: KDeviceUtils.getAppBarHeight() * 0.2,
        right: KSizes.defaultSpace,
        child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text('Skip'),
        ));
  }
}
