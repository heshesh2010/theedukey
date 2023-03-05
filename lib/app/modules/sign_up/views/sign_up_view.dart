import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../elements/phone_field_widget.dart';
import '../../../../elements/topbar.dart';
import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../controllers/signup_controller.dart';

class SignUpView extends GetWidget<SignUpController> {
  SignUpView({Key? key}) : super(key: key);

  final _nameArTextController = TextEditingController(text: "");
  final _nameEnTextController = TextEditingController(text: "");
  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _passwordConfirmTextController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // controller.submitButtonController.reset();
    // controller.isProcessEnabled = false.obs;
    return Scaffold(
      appBar: getTopBar(context, isback: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const TopBar(),
            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Obx(() {
                  return Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text("signUp".tr,
                                style:
                                    Theme.of(context).textTheme.displayLarge),
                            //ar_name
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _nameArTextController,
                              decoration:
                                  InputDecoration(labelText: "name_ar".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSaved: (input) =>
                                  controller.currentUser.value.name = input,
                              validator: (value) {
                                if (value != null && value.length > 5) {
                                  if (GetUtils.hasMatch(
                                    value,
                                    "[a-z]",
                                  )) {
                                    return "Name is not valid".tr;
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),
                            //en_name
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _nameEnTextController,
                              decoration:
                                  InputDecoration(labelText: "name_en".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onSaved: (input) =>
                                  controller.currentUser.value.nameEn = input,
                              validator: (value) {
                                if (value != null && value.length > 5) {
                                  if (GetUtils.hasMatch(
                                    value,
                                    "[ء-ي]",
                                  )) {
                                    return "Name is not valid".tr;
                                  } else {
                                    return null;
                                  }
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),

                            PhoneFieldWidget(
                              labelText: "mobile".tr,
                              hintText: "590000000".tr,
                              initialCountryCode: controller.currentUser.value
                                  .getMobileNumber()
                                  .countryISOCode,
                              initialValue: controller.currentUser.value
                                  .getMobileNumber()
                                  .number,
                              onSaved: (phone) {
                                controller.currentUser.value.phone =
                                    phone?.completeNumber ?? "";
                              },
                            ),

                            // //mobile
                            // TextFormField(
                            //   enabled: !controller.isProcessEnabled.value,
                            //   controller: _mobileTextController,
                            //   onSaved: (input) => controller
                            //       .currentUser.value.mobile = input ?? "",
                            //   decoration:
                            //       InputDecoration(labelText: "mobile".tr),
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            //   validator: (value) {
                            //     if (!GetUtils.isPhoneNumber(value!)) {
                            //       return "Mobile is not valid".tr;
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),

                            //email
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _emailTextController,
                              onSaved: (input) =>
                                  controller.currentUser.value.email = input,
                              decoration:
                                  InputDecoration(labelText: "email".tr),
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
                            const SizedBox(height: 8),
                            Obx(() => SizedBox(
                                  height: 70,
                                  child: DropdownButton(
                                    //isDense: true,
                                    isExpanded: true,
                                    hint: Text(
                                      controller.selectedCity.value.name!,
                                    ),
                                    onChanged: (dynamic value) {
                                      controller.setSelectedCity(value);
                                      controller.selectedCity.value = value;
                                      controller.update();
                                    },
                                    items: controller.citiesList
                                        .map((City selectedType) {
                                      return DropdownMenuItem(
                                        value: selectedType,
                                        child: Text(
                                          selectedType.name!,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _passwordTextController,
                              onSaved: (input) =>
                                  controller.currentUser.value.password = input,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  labelText: "password".tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.passwordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                  )),
                              obscureText: !controller.passwordVisible.value,
                              validator: (String? value) =>
                                  value!.trim().isEmpty || value.length < 8
                                      ? "Password is require".tr
                                      : null,
                            ),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              enabled: !controller.isProcessEnabled.value,
                              controller: _passwordConfirmTextController,
                              onSaved: (input) => controller.currentUser.value
                                  .passwordConfirmation = input,
                              decoration: InputDecoration(
                                  labelText: "password_confirm".tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.passwordVisible.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                  )),
                              obscureText: !controller.passwordVisible.value,
                              validator: (String? value) => value!
                                      .allMatches(
                                          _passwordTextController.value.text)
                                      .isEmpty
                                  ? "Password is not match".tr
                                  : null,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.0,
                                  height: 24.0,
                                  child: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    focusColor: Theme.of(context).focusColor,
                                    //   activeColor: Theme.of(context).colorScheme.secondary,
                                    value: controller.agreedToTOS.value,
                                    onChanged: (value) {
                                      controller.agreedToTOS.value = value!;
                                      //    controller.itemChange(value, index); // ************
                                      //  controller.update();
                                      // controller.loginProcess.value.obs,
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                    child: Text("terms approve".tr,
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color:
                                                Theme.of(context).hintColor)),
                                    onTap: () {
                                      Get.defaultDialog(
                                          title: "terms".tr,
                                          content: Expanded(
                                            child: SingleChildScrollView(
                                                child: Obx(() => Expanded(
                                                      child: Text(controller
                                                          .terms.value),
                                                    ))),
                                          ),
                                          textConfirm: "terms approve".tr,
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            Get.back();
                                          });
                                    })
                              ],
                            ),

                            const SizedBox(height: 20),
                            RoundedLoadingButton(
                              animateOnTap: false,
                              controller: controller.submitButtonController,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                // showLoadingDialog(context);
                                // btnSignUpController.stop();
                                // controller.signUp();

                                if (!controller.agreedToTOS.value) {
                                  Helper()
                                      .showErrorToast("you_must_agree_TOS".tr);
                                  controller.submitButtonController.reset();
                                } else if (controller.selectedCity.value.id ==
                                    null) {
                                  Helper().showErrorToast(
                                      "you_must_select_city".tr);
                                  controller.submitButtonController.reset();
                                } else if (_formKey.currentState!.validate()) {
                                  _formKey.currentState?.save();

                                  // await controller.signUp(User(
                                  //     email: _emailTextController.text,
                                  //     password: _passwordTextController.text,
                                  //     passwordConfirmation:
                                  //         _passwordConfirmTextController.text,
                                  //     name: _nameArTextController.text,
                                  //     nameEn: _nameEnTextController.text,
                                  //     mobile: _mobileTextController.text,
                                  //     phone: _phoneTextController.text,
                                  //     city: controller.selectedCity.value));
                                  controller.signUp();
                                } else {
                                  Helper().showErrorToast(
                                      "please_review_all_fields".tr);
                                  controller.submitButtonController.reset();
                                }
                              },
                              child: Text('signUp'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "have_an_account".tr),
                                      TextSpan(
                                        text: "login".tr,
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
