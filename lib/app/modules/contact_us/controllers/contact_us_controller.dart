import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../helper.dart';
import '../../../data/repositories/contact_us_repository.dart';

class ContactUsController extends GetxController {
  final ContactUsRepository repository;
  ContactUsController({required this.repository});

  var contactUsUpProcess = false.obs;
  final RoundedLoadingButtonController btnSubmitController =
      RoundedLoadingButtonController();
  final nameArTextController = TextEditingController(text: "");
  final emailTextController = TextEditingController(text: "");
  final titleTextController = TextEditingController(text: "");
  final bodyTextController = TextEditingController(text: "");

  contactUs() async {
    contactUsUpProcess = true.obs;

    dynamic response = await repository.postContactUsApi(
        nameArTextController.text,
        emailTextController.text,
        titleTextController.text,
        bodyTextController.text);
    if (response.contains("Send Success")) {
      btnSubmitController.success();
      Get.back();
      Helper().showSuccessToast("send_success".tr);
    } else {
      contactUsUpProcess = false.obs;
      btnSubmitController.reset();
      Helper().showErrorToast(response);
    }
  }
}
