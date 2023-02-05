import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Helper {
  DateTime? currentBackPressTime;

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

  showCustomAlertDialog(String title, String msg,
      {
      //required Null Function() onCancel,
      required Null Function() onConfirm,
      // String negativeBtnText = "cancel",
      String positiveBtnText = "confirm"}) {
    Get.dialog(Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  // Bottom rectangular box
                  margin: const EdgeInsets.only(
                      top: 40), // to push the box half way below circle
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(
                      top: 60, left: 20, right: 20), // spacing inside the box
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        msg,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ButtonBar(
                        buttonMinWidth: 100,
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: onConfirm,
                            child: Text(positiveBtnText.tr),
                          ),
                          // TextButton(
                          //   onPressed: onCancel,
                          //   child: Text(negativeBtnText.tr),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  // Top Circle with icon
                  maxRadius: 40.0,
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  showCustomDialog(String title, String msg,
      {required Null Function() onCancel,
      required Null Function() onConfirm,
      String negativeBtnText = "cancel",
      String positiveBtnText = "confirm"}) {
    Get.dialog(Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  // Bottom rectangular box
                  margin: const EdgeInsets.only(
                      top: 40), // to push the box half way below circle
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.only(
                      top: 60, left: 20, right: 20), // spacing inside the box
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        msg,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      ButtonBar(
                        buttonMinWidth: 100,
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: onConfirm,
                            child: Text(positiveBtnText.tr),
                          ),
                          TextButton(
                            onPressed: onCancel,
                            child: Text(negativeBtnText.tr),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  // Top Circle with icon
                  maxRadius: 40.0,
                  child: Icon(
                    Icons.check,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      showErrorToast("Tap again to leave!".tr);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
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
