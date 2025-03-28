import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:talkdoraemon/app/shared/const/lottie_asset.dart';
import '../controllers/test_page_controller.dart';

class TestPageView extends GetView<TestPageController> {
  const TestPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: controller.seekToFrame32,
            child: const Icon(Icons.skip_previous_sharp),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              controller.seekToPosition(52.0);
            },
            child: const Icon(Icons.skip_next),
          ),
        ],
      ),
      body: Center(
        child: RiveAnimation.asset(
          LottieAsset.testrg,
          artboard: 'Artboard',
          fit: BoxFit.cover,
          onInit: controller.onTestRiveInit,
        ),
      ),
    );
  }
}
