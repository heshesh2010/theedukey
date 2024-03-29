import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_config.dart';
import '../controllers/school_details_controller.dart';
import 'related_item.dart';

class RelatedSchoolsView extends GetWidget<SchoolDetailsController> {
  RelatedSchoolsView({Key? key}) : super(key: key);
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: const Color(0xFFFEFBF3),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 10, left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("related_schools".tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Expanded(
                            child: CarouselSlider(
                          carouselController: _controller,
                          options: CarouselOptions(
                              height: 450.0,
                              autoPlay: false,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              //   aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                controller.current.value = index;
                              }),
                          items: controller.facility.value.related!.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return InkWell(
                                    onTap: () {
                                      // Get.back();
                                      // Get.toNamed(Routes.schoolDetails,
                                      //     arguments:
                                      //         RouteArgument(schoolId: i.id));

                                      controller.getFacility(id: i.id);
                                    },
                                    child: RelatedSchoolItem(relatedItem: i));
                              },
                            );
                          }).toList(),
                        )),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: controller.facility.value.related!
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
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : AppColors().accentColor(1))
                                        .withOpacity(controller.current.value ==
                                                entry.key
                                            ? 0.9
                                            : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
