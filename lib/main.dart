import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:talkdoraemon/app/shared/services/listener_service.dart';
import 'package:talkdoraemon/app/shared/services/talking_service.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBindings(),
    ),
  );
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DecibelService());
    Get.put(SoundService());
  }
}
