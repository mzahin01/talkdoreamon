import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'splash_screen_view.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(2000.milliseconds, () async {
      // if (await StorageBox.to.getuserBannedStatus() == true) {
      //   Get.toNamed(Routes.LOGIN_FRONT_PAGE);
      // } else {
      Get.offNamed(Routes.HOME);
      // }
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}
