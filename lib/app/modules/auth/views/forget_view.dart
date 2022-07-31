import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:theedukey/app/modules/auth/views/auth_view.dart';

import '../../../../elements/topbar.dart';
import '../../../data/models/user.dart';
import '../controllers/auth_controller.dart';

class ForgetView extends GetWidget<AuthController> {
  ForgetView({Key? key}) : super(key: key);

  final _emailTextController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  const ,
            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Obx(() {
                  return Form(
                      key: _formKey,
                      child: Column(
                          //  mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            Text("forget".tr,
                                style: Theme.of(context).textTheme.headline1),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _emailTextController,
                              decoration: InputDecoration(
                                  labelText: "email".tr,
                                  fillColor: Colors.amber),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (!GetUtils.isEmail(value!)) {
                                  return "Email is not valid".tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 100),
                            RoundedLoadingButton(
                              controller: controller.submitButtonController,
                              duration: const Duration(seconds: 2),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.forget(
                                      User(email: _emailTextController.text));
                                } else {
                                  controller.submitButtonController.reset();
                                }
                              },
                              child: Text('submit'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  //    Get.updateLocale(const Locale("ar"));
                                  Get.to(() => AuthView());
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "remember_pass".tr),
                                      TextSpan(
                                        text: 'login'.tr,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ]));
                })),
          ],
        ),
      ),
    );
  }
}
