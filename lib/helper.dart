import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Helper {
  showSuccessToast(String msg) {
    Get.snackbar("success".tr, msg,
        backgroundColor: Colors.blueAccent,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        isDismissible: true);
  }

  showErrorToast(String msg) {
    Get.snackbar("error".tr, msg,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        isDismissible: true);
  }

  String getErrorStringFromMap(response) {
    late String errorStr = "";
    Iterable<RegExpMatch> matches = RegExp('\\[.*?\\]').allMatches(response);

    for (final m in matches) {
      errorStr += "${m[0]}\n";
    }
    return errorStr;
  }
}
