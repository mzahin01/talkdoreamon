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

class FoodRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Calculate the width of one-third of the screen
    double X = size.width / 5;

    // Define the visible area: clip the left one-third of the screen
    return Rect.fromLTWH(X, 0, size.width - X, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false; // No need to reclip as the clipping area is static
  }
}
