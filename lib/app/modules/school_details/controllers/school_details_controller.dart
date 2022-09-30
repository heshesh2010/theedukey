import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper.dart';
import '../../../data/models/facility.dart';
import '../../../data/repositories/school_repository.dart';
import '../../favorite/controllers/favorite_controller.dart';

class SchoolDetailsController extends GetxController {
  final SchoolRepository repository;
  SchoolDetailsController({required this.repository});
  RxBool isLoading = true.obs;
  RxInt selectedPage = 0.obs;
  RxInt current = 0.obs;
  RxBool isFavorite = false.obs;
  final scrollController = ScrollController();
  late Rx<Facility> facility = Facility().obs;
  @override
  void onInit() {
    super.onInit();

    getFacility();
  }

  void getFacility({int? id}) async {
    dynamic response = await repository.getFacilityApi(id: id);
    if (response is Facility) {
      facility.value = response;
      isLoading.value = false;
      isFavorite.value = facility.value.school?.isFavorite ?? false;
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.minScrollExtent,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      }
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  void favoriteSchool() {
    isFavorite.value ? removeFavorite() : addFavorite();

    if (Get.isRegistered<FavoriteController>()) {
      Get.find<FavoriteController>().pagingController.refresh();
    }

    //facility.value.school?.isFavorite = facility.value.school?.isFavorite!;
  }

  void addFavorite() async {
    dynamic response =
        await repository.addFavoriteApi(facility.value.school?.id);
    if (response) {
      Helper().showSuccessToast("added_to_favorite".tr);
      isFavorite.value = !isFavorite.value;
      facility.value.school?.isFavorite = true;
    } else {
      if (response is String) {
        Helper().showErrorToast(response);
      } else {
        Helper().showErrorToast(response.statusMessage.toString());
      }
    }
  }

  void removeFavorite() async {
    dynamic response =
        await repository.removeFavoriteApi(facility.value.school?.id);
    if (response) {
      isFavorite.value = !isFavorite.value;
      facility.value.school?.isFavorite = false;

      Helper().showSuccessToast("removed_from_favorite".tr);
    } else {
      if (response is String) {
        Helper().showErrorToast(response);
      } else {
        Helper().showErrorToast(response.statusMessage.toString());
      }
    }
  }
}
