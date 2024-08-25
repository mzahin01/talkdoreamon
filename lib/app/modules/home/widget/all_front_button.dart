import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';
import '../controllers/home_controller.dart';

class CopterButton extends StatelessWidget {
  const CopterButton({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          controller.triggerFly();
        },
        icon: SizedBox(
          height: Get.width / 3,
          width: Get.width / 3,
          child: Image.asset(
            ImageAsset.copterButton,
          ),
        ),
      ),
    );
  }
}

class AnywhereTravelButton extends StatelessWidget {
  const AnywhereTravelButton({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          controller.triggerTravel();
        },
        icon: SizedBox(
          height: Get.width / 3,
          width: Get.width / 3,
          child: Image.asset(
            ImageAsset.doorButton,
          ),
        ),
      ),
    );
  }
}
