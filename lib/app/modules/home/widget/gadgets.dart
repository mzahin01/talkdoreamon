import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/rect.dart';

class Gadgets extends StatelessWidget {
  const Gadgets({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ClipRect(
        clipper: CustomClipperRect(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            margin: EdgeInsets.only(bottom: controller.AnimeBottMargin.value),
            height: controller.AnimeContHeight.value,
            width: controller.AnimeContWidth.value,
            color: Colors.transparent,
            duration: Duration(milliseconds: controller.AnimeDuration.value),
            curve: Curves.easeOut,
            child: Image.asset(
              'assets/images/gadgets/bdflag.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    });
  }
}
