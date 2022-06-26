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

  String getErrorString(list) {
    late String errorStr = "";

    for (List i in list) {
      errorStr += "$i\n";
    }
    return errorStr;
  }
}
