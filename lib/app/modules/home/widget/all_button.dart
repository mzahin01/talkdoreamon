import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/modules/home/widget/widget.dart';
import 'package:talkdoraemon/app/routes/app_pages.dart';

class AllButtons extends StatelessWidget {
  const AllButtons({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              riveIconCont(
                'assets/rive/Dora.riv',
                controller.Doracake,
              ),
              riveIconCont(
                'assets/rive/Ice.riv',
                controller.IceCream,
              ),
              riveIconCont(
                'assets/rive/Chiks.riv',
                controller.Chicken,
              ),
              riveIconCont(
                'assets/rive/Straw.riv',
                controller.Strawberry,
              ),
              riveIconCont(
                'assets/rive/Candy.riv',
                controller.HellCandy,
              ),
              riveIconCont(
                'assets/rive/apple.riv',
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
              ElevatedButton(
                onPressed: controller.triggerSunnahSmile,
                child: const Text('Haha'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.record();
                },
                child: const Text('rec'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: controller.triggerThought,
                child: const Text('Tht'),
              ),
              ElevatedButton(
                onPressed: controller.triggerHiDoremon,
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
      ),
    );
  }
}
