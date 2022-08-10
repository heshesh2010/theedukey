import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_config.dart';
import '../controllers/school_details_controller.dart';
import 'priceItem.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

class SchoolPrices extends GetWidget<SchoolDetailsController> {
  const SchoolPrices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
        height: 550,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: controller.facility.value.prices?.length ?? 0,
                physics: const BouncingScrollPhysics(),
                //  controller: _pageController,
                onPageChanged: (page) {
                  controller.selectedPage.value = page;
                },
                itemBuilder: (BuildContext context, int index) {
                  return PriceItem(
                      price: controller
                          .facility.value.prices![index]); // you forgot this
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PageViewDotIndicator(
              currentItem: controller.selectedPage.value,
              count: controller.facility.value.prices?.length ?? 0,
              unselectedColor: Colors.black26,
              size: const Size(8, 8),
              selectedColor: AppColors().accentColor(1),
              duration: const Duration(milliseconds: 200),
            ),
          ],
        )));
  }
}
