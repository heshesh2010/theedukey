import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../routes/app_pages.dart';
import 'related_schools_view.dart';
import '../controllers/school_details_controller.dart';
import 'school_gallery.dart';
import 'school_info.dart';
import 'school_prices.dart';

class SchoolDetailsView extends GetWidget<SchoolDetailsController> {
  const SchoolDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getTopBar(context, title: "school_details".tr, isback: true),
        drawer: DrawerSideMenu(),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SchoolInfo(),
                      const SizedBox(
                        height: 40,
                      ),
                      const SchoolGallery(),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: Get.width / 1.5,
                        height: 60,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.pin_drop),
                          label: Text('show_results_on_map'.tr),
                          onPressed: () {
                            Get.toNamed(Routes.map);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SchoolPrices(),
                      const SizedBox(
                        height: 40,
                      ),
                      RelatedSchoolsView(),
                      const SizedBox(
                        height: 80,
                      ),
                      //RateSchool(),
                    ],
                  ),
                ),
              )));
  }
}
