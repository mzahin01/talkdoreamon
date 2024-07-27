import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import '../controllers/home_controller.dart';

// below is Doraemon

class Doremon extends StatelessWidget {
  const Doremon({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 120),
        width: 700,
        height: 1250,
        child: RiveAnimation.asset(
          'assets/rive/copybilai.riv',
          fit: BoxFit.fitWidth,
          onInit: controller.onRiveInit,
          // stateMachines: [],
        ),
      ),
    );
  }
}

// below is the background image

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/back.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
