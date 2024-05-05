import 'package:flutter/material.dart';

class DisplayNumberWithIcon extends StatelessWidget {
  const DisplayNumberWithIcon({
    super.key,
    required this.iconData,
    required this.iconColor,
    required this.number,
    required this.title,
  });

  final IconData iconData;
  final Color iconColor;
  final int number;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: 48,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          number.toString(),
          style: const TextStyle(fontSize: 21),
        ),
      ],
    );
  }
}
