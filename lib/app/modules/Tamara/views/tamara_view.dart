import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tamara_sdk/tamara_sdk.dart';

import '../../../../elements/topbar.dart';
import '../controllers/tamara_controller.dart';

class TamaraView extends GetWidget<TamaraController> {
  const TamaraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "pay_with_tmara".tr, isback: true),
      body: Obx(() {
        if (controller.isLoading.isTrue) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return TamaraCheckout(
          controller.url.value,
          "https://dev17.toplinedev.com/theedukey/public/tamara-success",
          "https://dev17.toplinedev.com/theedukey/public/tamara-failure",
          "https://dev17.toplinedev.com/theedukey/public/tamara-cancel",
          onPaymentSuccess: () {
            Get.log(" payment Success");

            controller.onPaymentSuccess();
          },
          onPaymentFailed: () {
            Get.log(" payment Failed");

            controller.onPaymentFailed();
          },
          onPaymentCanceled: () {
            Get.log(" payment Canceled");

            controller.onPaymentCanceled();
          },
        );
      }),
    );
  }
}
