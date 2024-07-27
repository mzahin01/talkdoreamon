import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

Widget riveIconCont(String assetPath, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black.withOpacity(.2),
        // border: Border.all(color: Colors.black),
      ),
      child: RiveAnimation.asset(assetPath),
    ),
  );
}
