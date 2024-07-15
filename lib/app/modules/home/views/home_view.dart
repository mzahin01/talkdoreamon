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
                  width: 600,
                  height: 550,
                  child: RiveAnimation.asset(
                    'assets/rive/copybilai.riv',
                    fit: BoxFit.contain,
                    onInit: controller.onRiveInit,
                    // stateMachines: [],
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
                    'assets/images/door.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Row(
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
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget riveIconCont(String assetPath, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(.2),
          // border: Border.all(color: Colors.black),
        ),
        child: RiveAnimation.asset(assetPath),
      ),
    );
  }
}

class CustomClipperRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    // Define the visible area
    return Rect.fromLTWH(0, 0, size.width, size.height - 230);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
