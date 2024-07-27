import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(bottom: 45, left: 15),
        child: GestureDetector(
            onTap: () {},
            child: const SizedBox(
              height: 150,
              width: 150,
              child: RiveAnimation.asset('assets/rive/food.riv'),
            )),
      ),
    );
  }
}
