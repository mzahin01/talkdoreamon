import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:talkdoraemon/app/modules/home/controllers/home_controller.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: InfiniteCarousel.builder(
          itemCount: controller.bgList.length,
          itemExtent: Get.width,
          center: true,
          anchor: 1,
          controller: controller.scrollController,
          velocityFactor: .3,
          loop: true,
          itemBuilder: (context, itemIndex, realIndex) {
            return Image.asset(
              controller.bgList[itemIndex],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
