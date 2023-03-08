import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/sons/controllers/sons_controller.dart';
import 'package:theedukey/app/modules/sons/views/image_picker/image_picker_helper.dart';

class Helper {
  DateTime? currentBackPressTime;
  final TextEditingController _guardianIdNumberController =
      TextEditingController();

  showSuccessToast(String msg) {
    Get.snackbar("success".tr, msg,
        backgroundColor: Colors.greenAccent,
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

  addFamilyAddDialog() {
    SonsController controller = Get.find<SonsController>();
    Get.defaultDialog(
      title: "add_family_id_image".tr,
      content: Column(
        children: [
          Obx(() => ImagePickerHelper(
                editButtonTitle: "edit_family_id_image".tr,
                buttonTitle: "family_id_image".tr,
                imageUrl: controller.selectedFamilyIdImage.value,
                onGet: (value) {
                  controller.onSelectFamilyIdImage(value);
                },
              )),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !controller.isProcessEnabled.value,
            controller: _guardianIdNumberController
              ..text = controller.currentUser.value.guardianIdNumber
                      ?.replaceAll(' ', '') ??
                  "",
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "id_number".tr,
              suffixText: '*',
              suffixStyle: const TextStyle(
                color: Colors.red,
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value != null && value.length != 10) {
                return "id is not valid".tr;
              } else {
                return null;
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (_guardianIdNumberController.text.isNotEmpty &&
                  controller.selectedFamilyIdImage.value.isNotEmpty) {
                controller.updateFamilyId();
              }
            },
            child: Text("add".tr),
          ),
        ],
      ),
    );
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
