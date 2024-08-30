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
      child: Padding(
        padding: EdgeInsets.only(
          left: Get.width / 50,
          top: Get.width / 150,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            controller.triggerFly();
          },
          icon: SizedBox(
            height: Get.width / 3.5,
            width: Get.width / 3.5,
            child: Image.asset(
              ImageAsset.copterButton,
            ),
          ),
        ),
      ),
    );
  }
}

class GadgetsButton extends StatelessWidget {
  const GadgetsButton({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(
          top: Get.width / 70,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            controller.triggerSAndO();
          },
          icon: SizedBox(
            height: Get.width / 3.5,
            width: Get.width / 3.5,
            child: Image.asset(
              ImageAsset.gadgetsButton,
            ),
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
      child: Padding(
        padding: EdgeInsets.only(
          right: Get.width / 50,
          top: Get.width / 150,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            controller.triggerTravel();
          },
          icon: SizedBox(
            height: Get.width / 3.5,
            width: Get.width / 3.5,
            child: Image.asset(
              ImageAsset.doorButton,
            ),
          ),
        ),
      ),
    );
  }
}
