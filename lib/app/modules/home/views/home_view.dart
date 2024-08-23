import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../widget/all_button.dart';
import '../widget/backgroun_pic.dart';
import '../widget/doremon.dart';
import '../widget/foods.dart';
import '../widget/gadgets.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Doremon(controller: controller),
          const Foods(),
          AllButtons(controller: controller),
          Gadgets(controller: controller),
        ],
      ),
    );
  }
}
