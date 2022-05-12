import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../controllers/auth_controller.dart';
import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProfileView extends GetView<AuthController> {
  EditProfileView({Key? key}) : super(key: key);

  final _nameArTextController = TextEditingController(text: "");
  final _nameEnTextController = TextEditingController(text: "");
  final _mobileTextController = TextEditingController(text: "");
  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _passwordConfirmTextController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "edit_profile".tr),
      drawer: const DrawerSideMenu(),
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
                            Text("edit_profile".tr,
                                style: Theme.of(context).textTheme.headline1),
                            //ar_name
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _nameArTextController
                                ..text =
                                    controller.currentUser.value?.name ?? " ",
                              decoration:
                                  InputDecoration(labelText: "name_ar".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value != null && value.length > 5) {
                                  return null;
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),
                            //en_name
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _nameEnTextController
                                ..text =
                                    controller.currentUser.value?.nameEn ?? " ",
                              decoration:
                                  InputDecoration(labelText: "name_en".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value != null && value.length > 5) {
                                  return null;
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),
                            //mobile
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _mobileTextController
                                ..text =
                                    controller.currentUser.value?.mobile ?? " ",
                              decoration:
                                  InputDecoration(labelText: "mobile".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (!GetUtils.isPhoneNumber(value!)) {
                                  return "Mobile is not valid".tr;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            //email
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _emailTextController
                                ..text =
                                    controller.currentUser.value?.email ?? " ",
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
                                        child: Text(
                                          selectedType.name!,
                                        ),
                                        value: selectedType,
                                      );
                                    }).toList(),
                                  ),
                                )),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _passwordTextController,
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
                              enabled: !controller.isProcessEnabled.value,
                              controller: _passwordConfirmTextController,
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
                            const SizedBox(height: 20),
                            RoundedLoadingButton(
                              child: Text('EditProfile'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              controller: controller.submitButtonController,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.updateProfile(User(
                                      email: _emailTextController.text,
                                      name: _nameArTextController.text,
                                      nameEn: _nameEnTextController.text,
                                      mobile: _mobileTextController.text,
                                      password: _passwordTextController.text,
                                      passwordConfirmation:
                                          _passwordConfirmTextController.text,
                                      city: controller.selectedCity.value));
                                } else {
                                  Helper().showErrorToast(
                                      "please_review_all_fields".tr);
                                  controller.submitButtonController.reset();
                                }
                              },
                            ),
                          ]));
                })),
          ],
        ),
      ),
    );
  }
}
