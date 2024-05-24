// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:schooll/services/utils/device/sizes.dart';
import 'package:schooll/services/utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitile,
  });

  final String image, title, subTitile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            width: KHelperFunctions.screenHeight() * 0.4,
            height: KHelperFunctions.screenHeight() * 0.5,
            image: NetworkImage(image),
          ),
          SizedBox(height: KHelperFunctions.screenHeight() * 0.02),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: KSizes.spaceBetweenItems),
          Text(
            subTitile,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
