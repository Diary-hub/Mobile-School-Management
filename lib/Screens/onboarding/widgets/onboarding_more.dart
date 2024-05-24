import 'package:flutter/material.dart';
import 'package:schooll/services/utils/device/device_utility.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoardingMoreButton extends StatelessWidget {
  const OnBoardingMoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const url = 'https://uhd.edu.iq/about-uhd';

    void _launchURL() async => await launch(url);
    return Positioned(
        top: KDeviceUtils.getAppBarHeight() * 0.2,
        left: KSizes.defaultSpace,
        child: TextButton(
          onPressed: () => _launchURL(),
          child: const Text('See More'),
        ));
  }
}
