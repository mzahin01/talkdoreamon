import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
    required this.image,
  });
  final String image;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        image,
        fit: BoxFit.cover, // or BoxFit.fill
      ),
    );
  }
}
