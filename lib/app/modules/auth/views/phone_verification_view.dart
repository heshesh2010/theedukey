import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../elements/topbar.dart';
import '../../../../helper.dart';
import '../../sign_up/controllers/signup_controller.dart';

class PhoneVerificationView extends GetWidget<SignUpController> {
  const PhoneVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: Helper().onWillPop,
        child: Scaffold(
            appBar: getTopBar(context, isback: true),
            body: Obx(() {
              if (controller.loading.isTrue) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "We sent the OTP code to your phone, please check it and enter below"
                          .tr,
                      style: Get.textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ).paddingSymmetric(horizontal: 20, vertical: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "OTP Code".tr,
                          hintText: "- - - - - -".tr,
                          // iconData: Icons.add_to_home_screen_outlined,
                        ),
                        maxLength: 6,
                        style: Get.textTheme.headline4,

                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        onChanged: (input) => controller.smsSent.value = input,
                        // iconData: Icons.add_to_home_screen_outlined,
                      ),
                    ),
                    RoundedLoadingButton(
                      controller: controller.submitVerifyButtonController,
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        await controller.verifyPhone();
                      },
                      child: Text(
                        "Verify".tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ).paddingSymmetric(horizontal: 20, vertical: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.resendOTPCode();
                          },
                          child: Text("Resend the OTP Code Again".tr),
                        ),
                      ],
                    )
                  ],
                );
              }
            })));
  }
}
