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
    return SizedBox(
      height: 100,
      width: Get.width,
      child: InfiniteCarousel.builder(
        itemCount: controller.bannerList.length,
        itemExtent: Get.width,
        center: true,
        anchor: 3,
        controller: controller.scrollController,
        velocityFactor: 1,
        loop: true,
        // onIndexChanged: (index) {
        //   print('Current Index: $index+2');
        // },
        itemBuilder: (context, itemIndex, realIndex) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                controller.bannerList[itemIndex],
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
