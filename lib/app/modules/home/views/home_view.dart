import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/widget/food_option_sheet.dart';
import 'package:talkdoraemon/app/modules/home/widget/all_front_button.dart';
import '../controllers/home_controller.dart';
import '../widget/all_button.dart';
import '../widget/backgroun_pic.dart';
import '../widget/doremon.dart';
import '../widget/gadgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Stack(
              children: [
                Doremon(controller: controller),
                AllButtons(controller: controller),
                Gadgets(controller: controller),
                FoodOptionSheet(controller: controller),
                CopterButton(controller: controller),
                AnywhereTravelButton(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
