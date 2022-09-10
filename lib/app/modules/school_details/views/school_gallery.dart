import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/school_details/views/gallery_item.dart';

import '../controllers/school_details_controller.dart';

class SchoolGallery extends GetWidget<SchoolDetailsController> {
  const SchoolGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          color: const Color(0xFFFEFBF3),
          child: Padding(
            padding: const EdgeInsets.only(top: 40.0, right: 20, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("school_gallery".tr,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 40,
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.0,
                  children: controller.facility.value.gallery?.map((e) {
                        return GalleryItem(
                          image: e.image ?? "",
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          ),
        ));
  }
}
