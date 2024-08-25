import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';

import '../controllers/home_controller.dart';

class Foods extends StatelessWidget {
  const Foods({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: Get.width / 30,
          left: Get.width / 30,
        ),
        child: IconButton(
          onPressed: () {
            controller.triggerFoodAnimation();
          },
          padding: EdgeInsets.zero,
          icon: SizedBox(
            height: Get.width / 3,
            width: Get.width / 3,
            child: const RiveAnimation.asset(
              LottieAsset.allFood,
            ),
          ),
        ),
      ),
    );
  }
}
