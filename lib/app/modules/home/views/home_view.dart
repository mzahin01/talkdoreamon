import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/decible.dart';
import 'package:talkdoraemon/app/modules/sound.dart';
import '../controllers/home_controller.dart';
import '../widget/aw_door_button.dart';
import '../widget/bg_carousal.dart';
import '../widget/copter_button.dart';
import '../widget/doremon.dart';
import '../widget/food_speed_dial.dart';
import '../widget/gadget_button.dart';
import '../widget/gadgets.dart';
// import '../widget/testing_buttons.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            child: const Text('SoundRD'),
            onPressed: () {
              Get.to(() => const SimpleRecorder());
            },
          ),
          FloatingActionButton(
            child: const Text('DecibleRD'),
            onPressed: () {
              Get.to(() => const RecorderOnProgress());
            },
          ),
          FloatingActionButton(
            child: const Text('Record'),
            onPressed: () {
              controller.recordSound();
            },
          ),
          FloatingActionButton(
            child: const Text('Play'),
            onPressed: () {
              controller.playSound();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          CarouselWidget(controller: controller),
          SafeArea(
            child: Stack(
              children: [
                Doremon(controller: controller),
                Gadgets(controller: controller),
                FoodBagButton(controller: controller),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CopterButton(controller: controller),
                      GadgetsButton(controller: controller),
                      AnywhereDoorButton(controller: controller),
                    ],
                  ),
                ),
                // TestingButtons(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
