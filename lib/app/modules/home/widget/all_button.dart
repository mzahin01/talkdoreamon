import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/widget.dart';
import 'package:talkdoraemon/app/routes/app_pages.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';

class AllButtons extends StatelessWidget {
  const AllButtons({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.triggerSpeak,
              child: const Text('Talk'),
            ),
            ElevatedButton(
              onPressed: controller.triggerSAndO,
              child: const Text('Gad'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: controller.next,
              child: const Text('Tht'),
            ),
            ElevatedButton(
              onPressed: controller.back,
              child: const Text('HiD'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.TEST_PAGE);
              },
              child: const Text('gotoRaf'),
            ),
          ],
        ),
      ],
    );
  }
}
