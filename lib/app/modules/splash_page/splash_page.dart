import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talkdoraemon/app/shared/const/image_asset.dart';
import '../../routes/app_pages.dart';

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
      Get.offNamed(Routes.HOME);
    });
  }

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Image.asset(
        ImageAsset.splash,
        fit: BoxFit.fill,
      ),
    );
  }
}
