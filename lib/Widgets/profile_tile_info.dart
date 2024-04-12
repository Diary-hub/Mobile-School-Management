import 'package:flutter/material.dart';

class ProfileTileInfo extends StatelessWidget {
  const ProfileTileInfo({
    super.key,
    required this.title,
    required this.value,
    this.icon = const Icon(Icons.arrow_forward_ios),
  });

  final String title;
  final String value;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.teal, fontSize: 18),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(flex: 1, child: icon),
      ],
    );
  }
}
