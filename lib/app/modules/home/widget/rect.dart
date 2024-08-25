import 'package:flutter/material.dart';

class GadgetRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Define the visible area
    return Rect.fromLTWH(0, 0, size.width, size.height - 230);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class FoodRack extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Calculate the middle point of the screen
    double middleX = size.width / 2;

    // Define the visible area: only the right half is visible
    return Rect.fromLTWH(middleX, 0, middleX, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false; // No need to reclip as the clipping area is static
  }
}
