import 'package:flutter/material.dart';
import 'package:schooll/services/utils/device/device_utility.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../services/controller/onboarding_controller.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: KDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: KSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(activeDotColor: Colors.blue, dotHeight: 6),
      ),
    );
  }
}
