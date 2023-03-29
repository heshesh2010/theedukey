import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_config.dart';
import '../controllers/school_details_controller.dart';
import 'priceItem.dart';

class SchoolPrices extends GetWidget<SchoolDetailsController> {
  SchoolPrices({Key? key}) : super(key: key);
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
        height: 600,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: CarouselSlider(
              carouselController: _controller,
              options: CarouselOptions(
                  enableInfiniteScroll: false,
                  height: 550.0,
                  autoPlay: false,
                  viewportFraction: 1,
                  //aspectRatio: 0.5,
                  //  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    controller.current.value = index;
                  }),
              items: controller.facility.value.prices!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return PriceItem(price: i);
                  },
                );
              }).toList(),
            )),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.facility.value.prices!
                  .asMap()
                  .entries
                  .map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : AppColors().accentColor(1))
                            .withOpacity(controller.current.value == entry.key
                                ? 0.9
                                : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        )));
  }
}
