import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';
import '../controllers/home_controller.dart';

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
        child: RiveAnimation.asset(
          LottieAsset.doraemon,
          fit: BoxFit.fitWidth,
          onInit: controller.onRiveInit,
        ),
      ),
    );
  }
}
