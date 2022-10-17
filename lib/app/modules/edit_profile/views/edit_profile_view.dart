import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../sons/views/image_picker/image_picker_helper.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../../helper.dart';
import '../../../data/models/city.dart';
import '../../../data/models/user.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetWidget<EditProfileController> {
  EditProfileView({Key? key}) : super(key: key);

  final _nameArTextController = TextEditingController(text: "");
  final _nameEnTextController = TextEditingController(text: "");
  final _mobileTextController = TextEditingController(text: "");
  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _oldPasswordTextController = TextEditingController(text: "");
  final _passwordConfirmTextController = TextEditingController(text: "");
  final _phoneTextController = TextEditingController(text: "");

  final _idNumberTextController = TextEditingController(text: "");

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "edit_profile".tr),
      drawer: DrawerSideMenu(),
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
                              decoration: InputDecoration(
                                labelText: "name_ar".tr,
                                suffixText: '*',
                                suffixStyle: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              controller: _nameEnTextController
                                ..text =
                                    controller.currentUser.value?.nameEn ?? " ",
                              decoration: InputDecoration(
                                  labelText: "name_en".tr,
                                  suffixText: '*',
                                  suffixStyle: const TextStyle(
                                    color: Colors.red,
                                  )),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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

                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _idNumberTextController
                                ..text = controller.currentUser.value?.idNumber
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value != null && value.length != 10) {
                                  return "id is not valid".tr;
                                } else {
                                  return null;
                                }
                              },
                            ),

                            GetBuilder<AuthController>(
                                initState: (_) {},
                                builder: (controller) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20, top: 20),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        ImagePickerHelper(
                                          editButtonTitle:
                                              "edit_personal_image".tr,
                                          buttonTitle: "personal_image".tr,
                                          imageUrl: controller
                                                  .selectedPersonalImage ??
                                              controller
                                                  .currentUser.value?.image ??
                                              "",
                                          onGet: (value) {
                                            controller
                                                .onSelectPersonalImage(value);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ImagePickerHelper(
                                          editButtonTitle: "edit_id_image".tr,
                                          buttonTitle: "id_image".tr,
                                          imageUrl:
                                              controller.selectedIdImage ??
                                                  controller.currentUser.value
                                                      ?.idImage ??
                                                  "",
                                          onGet: (value) {
                                            controller.onSelectIdImage(value);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ImagePickerHelper(
                                          editButtonTitle:
                                              "edit_certificate_image".tr,
                                          buttonTitle: "certificate_image".tr,
                                          imageUrl: controller
                                                  .selectedCertificateImage ??
                                              controller.currentUser.value
                                                  ?.certificateImage ??
                                              "",
                                          onGet: (value) {
                                            controller.onSelectCertificateImage(
                                                value);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                            //phone
                            TextFormField(
                              enabled: !controller.isProcessEnabled.value,
                              controller: _phoneTextController
                                ..text =
                                    controller.currentUser.value?.phone ?? " ",
                              decoration:
                                  InputDecoration(labelText: "phone".tr),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (!GetUtils.isPhoneNumber(value!)) {
                                  return "Phone is not valid".tr;
                                } else {
                                  return null;
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
                                controller: _oldPasswordTextController,
                                decoration: InputDecoration(
                                    labelText: "old_password".tr,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.passwordVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        controller.passwordVisible.value =
                                            !controller.passwordVisible.value;
                                      },
                                    )),
                                obscureText: !controller.passwordVisible.value,
                                validator: (String? value) {
                                  if (_passwordTextController
                                      .value.text.isNotEmpty) {
                                    return value!.trim().isEmpty ||
                                            value.length < 8
                                        ? "Password is require".tr
                                        : null;
                                  } else {
                                    return null;
                                  }
                                }),
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
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      onPressed: () {
                                        controller.passwordVisible.value =
                                            !controller.passwordVisible.value;
                                      },
                                    )),
                                obscureText: !controller.passwordVisible.value,
                                validator: (String? value) {
                                  if (_oldPasswordTextController
                                      .value.text.isNotEmpty) {
                                    return value!.trim().isEmpty ||
                                            value.length < 8
                                        ? "Password is require".tr
                                        : null;
                                  } else {
                                    return null;
                                  }
                                }),
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
                            const SizedBox(height: 40),
                            RoundedLoadingButton(
                              controller: controller.submitButtonController,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.updateProfile(User(
                                    email: _emailTextController.text,
                                    name: _nameArTextController.text,
                                    nameEn: _nameEnTextController.text,
                                    mobile: _mobileTextController.text,
                                    phone: _phoneTextController.text,
                                    oldPassword:
                                        _oldPasswordTextController.text,
                                    password: _passwordTextController.text,
                                    passwordConfirmation:
                                        _passwordConfirmTextController.text,
                                    city: controller.selectedCity.value,
                                    idImage: controller.selectedIdImage,
                                    image: controller.selectedPersonalImage,
                                    certificateImage:
                                        controller.selectedCertificateImage,
                                    familyIdImage:
                                        controller.selectedFamilyIdImage,
                                    idNumber: _idNumberTextController.text,
                                  ));
                                } else {
                                  Helper().showErrorToast(
                                      "please_review_all_fields".tr);
                                  controller.submitButtonController.reset();
                                }
                              },
                              child: Text('submit'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(height: 40),
                          ]));
                })),
          ],
        ),
      ),
    );
  }
}
