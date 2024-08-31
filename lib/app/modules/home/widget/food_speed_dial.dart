import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';
import '../controllers/home_controller.dart';

class FoodBagButton extends StatelessWidget {
  const FoodBagButton({
    super.key,
    required this.controller,
  });
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: Get.width / 30,
          right: Get.width / 30,
        ),
        child: SizedBox(
          height: 120,
          child: SpeedDial(
            useRotationAnimation: false,
            activeBackgroundColor: Colors.transparent,
            activeForegroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            renderOverlay: false,
            direction: SpeedDialDirection.up,
            activeIcon: Icons.select_all,
            childPadding: EdgeInsets.only(right: Get.width / 20),
            childrenButtonSize: Size.fromRadius(Get.width / 11),
            children: [
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.doraCake),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.Doracake();
                },
              ),
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.iceCream),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.IceCream();
                },
              ),
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.chicken),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.Chicken();
                },
              ),
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.strawberry),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.Strawberry();
                },
              ),
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.candy),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.HellCandy();
                },
              ),
              SpeedDialChild(
                child: const RiveAnimation.asset(LottieAsset.apple),
                backgroundColor: Colors.transparent,
                onTap: () async {
                  controller.triggerNoEat();
                  await Future.delayed(const Duration(milliseconds: 500));
                  controller.RedApple();
                },
              ),
            ],
            activeChild: const RiveAnimation.asset(LottieAsset.foodWithBag),
            child: const RiveAnimation.asset(LottieAsset.allFood),
          ),
        ),
      ),
    );
  }
}
