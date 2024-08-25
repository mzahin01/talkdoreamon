import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/rect.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';

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
          clipper: FoodRack(),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              margin: EdgeInsets.only(
                  right: controller.foodRightMargin.value,
                  bottom: Get.width / 10),
              height: Get.width / 5,
              width: Get.width * 3 / 4,
              color: Colors.transparent,
              duration: Duration(milliseconds: controller.foodDuration.value),
              curve: Curves.easeOut,
              child: Image.asset(
                ImageAsset.bangladeshFlag, // Assuming CIA alias is used here
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
