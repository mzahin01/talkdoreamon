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
        child: SingleChildScrollView(
          child: Column(
            children: [
              RiveAnimation.asset(
                'assets/rive/copybilai.riv',
                fit: BoxFit.contain,
                onInit: controller.onRiveInit,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: controller.triggerSpeak,
                    child: const Text('Trigger Speak'),
                  ),
                  ElevatedButton(
                    onPressed: controller.triggerSAndO,
                    child: const Text('Trigger S&O'),
                  ),
                  ElevatedButton(
                    onPressed: controller.triggerThought,
                    child: const Text('Trigger Thought'),
                  ),
                  ElevatedButton(
                    onPressed: controller.triggerHiDoremon,
                    child: const Text('Trigger HiDoremon'),
                  ),
                  ElevatedButton(
                    onPressed: controller.triggerSunnahSmile,
                    child: const Text('Trigger SunnahSmile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
