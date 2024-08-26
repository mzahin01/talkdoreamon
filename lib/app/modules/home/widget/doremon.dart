import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/modules/home/widget/foods.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';
import '../controllers/home_controller.dart';
import 'food_option_sheet.dart';

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
      child: SizedBox(
        width: Get.width,
        height: Get.width * (1250 / 700),
        child: Stack(
          children: [
            RiveAnimation.asset(
              LottieAsset.doraemon,
              fit: BoxFit.fitWidth,
              onInit: controller.onRiveInit,
            ),
            // Here is Food Sheet
            // FoodOptionSheet(controller: controller),
            // Here is AllFood icon
            Foods(controller: controller),
          ],
        ),
      ),
    );
  }
}
