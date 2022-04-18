import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:theedukey/utils/local_storage/local_storage.dart';

class AppLanguage extends GetxController {
  String? appLocale = Get.deviceLocale!.languageCode;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    appLocale = await localStorage.languageSelected??"ar";
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
}