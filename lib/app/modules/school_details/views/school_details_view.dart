import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../controllers/school_details_controller.dart';
import 'related_schools_view.dart';
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
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Get.find<AuthService>().isAuth
            ? Obx(() => FloatingActionButton(
                  onPressed: () {
                    controller.favoriteSchool();
                  },
                  child: controller.isFavorite.value
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                ))
            : Container(),
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 10, left: 10),
                child: ListView(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  children: [
                    const SchoolInfo(),
                    const SizedBox(
                      height: 40,
                    ),
                    controller.facility.value.gallery!.isNotEmpty
                        ? const SchoolGallery()
                        : Container(),
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
                          getIt<SearchModel>()
                              .setSchoolsList([controller.facility.value].obs);

                          Get.toNamed(Routes.map);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    controller.facility.value.prices!.isNotEmpty
                        ? SchoolPrices()
                        : Container(),

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
              )));
  }
}
