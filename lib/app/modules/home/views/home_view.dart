import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widget/aw_door_button.dart';
import '../widget/bg_carousal.dart';
import '../widget/copter_button.dart';
import '../widget/doremon.dart';
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
                Doremon(controller: controller),
                Gadgets(controller: controller),
                CopterButton(controller: controller),
                AnywhereDoorButton(controller: controller),
                GadgetsButton(controller: controller),
                // TestingButtons(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
