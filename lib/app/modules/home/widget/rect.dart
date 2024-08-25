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
    // Define the visible area
    return Rect.fromLTWH(0, 0, size.width, size.height - 230);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
