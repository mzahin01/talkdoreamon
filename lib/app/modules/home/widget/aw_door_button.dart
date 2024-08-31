import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';
import '../controllers/home_controller.dart';

class AnywhereDoorButton extends StatelessWidget {
  const AnywhereDoorButton({
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
