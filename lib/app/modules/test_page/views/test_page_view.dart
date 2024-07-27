import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: const Center(
        child: Text(
          'TestPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
