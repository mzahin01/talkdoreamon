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
