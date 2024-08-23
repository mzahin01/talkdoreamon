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
              foodIcons(
                'assets/rive/foods/Dora.riv',
                controller.Doracake,
              ),
              foodIcons(
                'assets/rive/foods/Ice.riv',
                controller.IceCream,
              ),
              foodIcons(
                'assets/rive/foods/Chiks.riv',
                controller.Chicken,
              ),
              foodIcons(
                'assets/rive/foods/Straw.riv',
                controller.Strawberry,
              ),
              foodIcons(
                'assets/rive/foods/Candy.riv',
                controller.HellCandy,
              ),
              foodIcons(
                'assets/rive/foods/apple.riv',
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
                onPressed: controller.triggerFly,
                child: const Text('fly'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.triggerTravel();
                },
                child: const Text('Travel'),
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
