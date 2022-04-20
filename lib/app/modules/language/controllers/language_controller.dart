import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/local_storage.dart';

class LanguageController extends GetxController {
  String? appLocale = Get.deviceLocale!.languageCode;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    appLocale = await localStorage.languageSelected ?? "ar";
    Get.updateLocale(Locale(appLocale!));
    update();
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == type) {
      return;
    }
    if (type == 'ar') {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
      Get.updateLocale(const Locale("ar"));
    } else {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
      Get.updateLocale(const Locale("en"));
    }
    update();
  }

  final count = 0.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
