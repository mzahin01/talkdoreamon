import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
        child: SizedBox(
          height: 120,
          child: SpeedDial(
            useRotationAnimation: false,
            activeBackgroundColor: Colors.transparent,
            activeForegroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            renderOverlay: false,
            // activeIcon: Icons.,
            direction: SpeedDialDirection.right,
            activeIcon: Icons.food_bank_outlined,
            // Removes the white overlay
            // shape:
            //     const CircleBorder(), // Ensures round shape with no extra focus
            // childMargin: EdgeInsets.zero, // Removes extra margin
            // childPadding: EdgeInsets.zero, // Removes extra padding
            children: [
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.doraCake),
                backgroundColor: Colors.red,
                onTap: () {},
              ),
              SpeedDialChild(
                child: const Icon(Icons.call),
                backgroundColor: Colors.green,
                onTap: () {},
              ),
              SpeedDialChild(
                child: const Icon(Icons.mail),
                backgroundColor: Colors.blue,
                onTap: () {},
              ),
            ],
            activeChild: const RiveAnimation.asset(LottieAsset.allFood),
            child: const RiveAnimation.asset(LottieAsset.allFood),
          ),
        ),
      ),
    );

    // IconButton(
    //   onPressed: () {
    //     controller.triggerFoodAnimation();
    //   },
    //   padding: EdgeInsets.zero,
    //   icon: SizedBox(
    //     height: Get.width / 3,
    //     width: Get.width / 3,
    //     child: const RiveAnimation.asset(
    //       LottieAsset.allFood,
    //     ),
    //   ),
    // ),
  }
}
