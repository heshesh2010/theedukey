import 'package:flutter/src/widgets/editable_text.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../helper.dart';
import '../models/stage.dart';
import '../repo/contact_us_repository.dart';
import '../repo/home_repository.dart';

class ContactUsController extends GetxController {
  var contactUsUpProcess = false.obs;
  final RoundedLoadingButtonController btnSubmitController =
      RoundedLoadingButtonController();
  final nameArTextController = TextEditingController(text: "");
  final emailTextController = TextEditingController(text: "");
  final titleTextController = TextEditingController(text: "");
  final bodyTextController = TextEditingController(text: "");

  contactUs() async {
    contactUsUpProcess = true.obs;

    dynamic response = await postContactUsApi(
        nameArTextController.text,
        emailTextController.text,
        titleTextController.text,
        bodyTextController.text);
    if (response.contains("Send Success")) {
      btnSubmitController.success();
      Helper().showSuccessToast(response);
    } else {
      contactUsUpProcess = false.obs;
      btnSubmitController.error();
      Helper().showErrorToast(response);
    }
  }
}
