import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Stack(
        children: [
          CarouselWidget(controller: controller),
          SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: Get.height * 0.5,
                    width: Get.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withAlpha(50),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
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
                ),
                Doremon(controller: controller),
                Gadgets(controller: controller),
                FoodBagButton(controller: controller),
                // TestingButtons(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
