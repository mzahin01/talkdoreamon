import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/back.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: SizedBox(
                  width: 350,
                  height: 350,
                  child: RiveAnimation.asset(
                    'assets/rive/copybilai.riv',
                    fit: BoxFit.contain,
                    onInit: controller.onRiveInit,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                margin: controller.GadBool.value
                    ? const EdgeInsets.only(bottom: 145)
                    : const EdgeInsets.only(bottom: 190),
                height: 30,
                width: 85,
                color: Colors.amber,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: controller.triggerThought,
                      child: const Text('Thought'),
                    ),
                    ElevatedButton(
                      onPressed: controller.triggerHiDoremon,
                      child: const Text('HiDoremon'),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: controller.triggerSpeak,
                      child: const Text('Speak'),
                    ),
                    ElevatedButton(
                      onPressed: controller.triggerSAndO,
                      child: const Text('S&O'),
                    ),
                    ElevatedButton(
                      onPressed: controller.triggerSunnahSmile,
                      child: const Text('Smile'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
