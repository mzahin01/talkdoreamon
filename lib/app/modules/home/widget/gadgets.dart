import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/gadget_rect.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';

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
        clipper: GadgetRect(),
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
              ImageAsset.anywhereDoor,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    });
  }
}
