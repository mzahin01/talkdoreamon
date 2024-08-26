import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Widget foodIcons(String assetPath, VoidCallback onTap) {
  return IconButton(
    onPressed: onTap,
    padding: EdgeInsets.zero,
    icon: SizedBox(
      height: 40,
      width: 40,
      // padding: const EdgeInsets.all(8.0),
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: Colors.black.withOpacity(.2),
      //   border: Border.all(color: Colors.black),
      // ),
      child: RiveAnimation.asset(assetPath),
    ),
  );
}
