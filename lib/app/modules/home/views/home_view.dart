import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/sound.dart';
import '../controllers/home_controller.dart';
import '../widget/aw_door_button.dart';
import '../widget/bg_carousal.dart';
import '../widget/copter_button.dart';
import '../widget/doremon.dart';
import '../widget/food_speed_dial.dart';
import '../widget/gadget_button.dart';
import '../widget/gadgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(() => const SimpleRecorder());
      }),
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
