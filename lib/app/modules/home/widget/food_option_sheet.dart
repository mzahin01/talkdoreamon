import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/rect.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';
import 'package:talkdoraemon/app/styles/colors.dart';

import 'widget.dart';

class FoodOptionSheet extends StatelessWidget {
  const FoodOptionSheet({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ClipRect(
          clipper: FoodRect(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              margin: EdgeInsets.only(
                  right: controller.foodRightMargin.value,
                  bottom: Get.width / 10),
              height: Get.width / 5,
              width: Get.width * 3 / 4,
              duration: Duration(milliseconds: controller.foodDuration.value),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: SGColors.blackShade3.withAlpha(100),
                border: Border.all(color: SGColors.blackShade3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  foodIcons(
                    LottieAsset.doraCake,
                    controller.Doracake,
                  ),
                  foodIcons(
                    LottieAsset.iceCream,
                    controller.IceCream,
                  ),
                  foodIcons(
                    LottieAsset.chicken,
                    controller.Chicken,
                  ),
                  foodIcons(
                    LottieAsset.strawberry,
                    controller.Strawberry,
                  ),
                  foodIcons(
                    LottieAsset.candy,
                    controller.HellCandy,
                  ),
                  foodIcons(
                    LottieAsset.apple,
                    controller.RedApple,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
