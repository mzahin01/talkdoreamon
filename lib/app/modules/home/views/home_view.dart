import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: RiveAnimation.asset(
          'assets/rive/copybilai.riv',
          fit: BoxFit.cover,
          onInit: controller.onRiveInit,
        ),
      ),
    );
  }
}
