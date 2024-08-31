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
