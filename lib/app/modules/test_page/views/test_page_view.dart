import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';

import '../controllers/test_page_controller.dart';

class TestPageView extends GetView<TestPageController> {
  const TestPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'TestPageView is ${HomeController.to.animating}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
