import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';
import 'package:talkdoraemon/app/routes/app_pages.dart';
import 'package:talkdoraemon/app/styles/spacing.dart';

class TestingButtons extends StatelessWidget {
  const TestingButtons({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacing.sb100,
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
