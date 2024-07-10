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
            ClipRect(
              clipper: CustomClipperRect(),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  margin:
                      EdgeInsets.only(bottom: controller.AnimeBottMargin.value),
                  height: controller.AnimeContHeight.value,
                  width: controller.AnimeContWidth.value,
                  color: Colors.transparent,
                  duration:
                      Duration(milliseconds: controller.AnimeDuration.value),
                  curve: Curves.easeOut,
                  child: Image.asset(
                    'assets/images/bdflag.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
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

class CustomClipperRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Define the visible area
    return Rect.fromLTWH(0, 0, size.width, size.height - 175);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
