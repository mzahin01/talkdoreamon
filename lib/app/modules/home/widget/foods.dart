import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class Foods extends StatelessWidget {
  const Foods({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: Get.width / 30,
          left: Get.width / 30,
        ),
        child: IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const SizedBox(
              height: 130,
              width: 130,
              child: RiveAnimation.asset('assets/rive/foods/AllFood.riv'),
            )),
      ),
    );
  }
}
