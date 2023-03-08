import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../elements/topbar.dart';
import '../../../../helper.dart';
import '../../../data/models/son.dart';
import '../controllers/sons_controller.dart';
import 'image_picker/image_picker_helper.dart';

class AddSonView extends GetWidget<SonsController> {
  AddSonView({Key? key}) : super(key: key);

  final _nameArTextController = TextEditingController(text: "");
  final _nameEnTextController = TextEditingController(text: "");
  final _birthDateTextController = TextEditingController(text: "");
  final _idNumberTextController = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.clearAllVars();

    return Scaffold(
        appBar: getTopBar(context, isback: true),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Obx(() {
                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text("add_son".tr,
                            style: Theme.of(context).textTheme.displayLarge),
                        //ar_name
                        TextFormField(
                          enabled: !controller.isProcessEnabled.value,
                          controller: _nameArTextController,
                          decoration: InputDecoration(
                            labelText: "name_ar".tr,
                            suffixText: '*',
                            suffixStyle: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          decoration: InputDecoration(
                            labelText: "name_en".tr,
                            suffixText: '*',
                            suffixStyle: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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

                        //birth_date
                        TextFormField(
                          enabled: !controller.isProcessEnabled.value,
                          controller: _birthDateTextController,
                          onTap: () => showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1998),
                            lastDate: DateTime(2030),
                          ).then((date) => _birthDateTextController.text =
                              date.toString().split(" ")[0]),
                          //_birthDateTextController.text = DateFormat('yyyy-MM-d').format(date)),
                          decoration: InputDecoration(
                            labelText: "birth_date".tr,
                            suffixText: '*',
                            suffixStyle: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length > 5) {
                              return null;
                            } else {
                              return "birth_date is not valid".tr;
                            }
                          },
                        ),

                        TextFormField(
                          enabled: !controller.isProcessEnabled.value,
                          controller: _idNumberTextController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "son_id".tr,
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
                        RichText(
                          text: TextSpan(
                              text: "gender".tr,
                              style: Get.textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                    text: ' *',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ))
                              ]),
                        ),
                        GetBuilder<SonsController>(
                            builder: (builderContronller) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  addRadioButton(0, "male".tr, controller),
                                  addRadioButton(1, "female".tr, controller),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 20),
                                child: Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Obx(() => ImagePickerHelper(
                                          editButtonTitle:
                                              "edit_personal_image".tr,
                                          buttonTitle: "personal_image".tr,
                                          imageUrl: controller
                                              .selectedPersonalImage.value,
                                          onGet: (value) {
                                            controller
                                                .onSelectPersonalImage(value);
                                          },
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() => ImagePickerHelper(
                                          editButtonTitle: "edit_id_image".tr,
                                          buttonTitle: "id_image".tr,
                                          imageUrl:
                                              controller.selectedIdImage.value,
                                          onGet: (value) {
                                            controller.onSelectIdImage(value);
                                          },
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Obx(() => ImagePickerHelper(
                                          editButtonTitle:
                                              "edit_certificate_image".tr,
                                          buttonTitle: "certificate_image".tr,
                                          imageUrl: controller
                                              .selectedCertificateImage.value,
                                          onGet: (value) {
                                            controller.onSelectCertificateImage(
                                                value);
                                          },
                                        )),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                        const SizedBox(height: 20),
                        RoundedLoadingButton(
                          controller: controller.submitButtonController,
                          color: Theme.of(context).primaryColor,
                          onPressed: () async {
                            // showLoadingDialog(context);
                            // btnSignUpController.stop();
                            if (_formKey.currentState!.validate() &&
                                controller.selectedGenderApi != null) {
                              await controller.addSon(SonDataData(
                                name: _nameArTextController.text,
                                nameEn: _nameEnTextController.text,
                                idNumber: _idNumberTextController.text,
                                birthDate: _birthDateTextController.text,
                                gender: controller.selectedGenderApi,
                                idImage: controller.selectedIdImage.value,
                                image: controller.selectedPersonalImage.value,
                                certificateImage:
                                    controller.selectedCertificateImage.value,
                              ));
                            } else {
                              Helper().showErrorToast(
                                  "please_review_all_fields".tr);
                              controller.submitButtonController.reset();
                            }
                          },
                          child: Text('add'.tr,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                })),
          ],
        )));
  }

  Row addRadioButton(int btnIndex, String title, SonsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<SonsController>(
          builder: (_) => Radio(
              value: controller.gender[btnIndex],
              groupValue: controller.selectedGender,
              onChanged: (value) => controller.onSelectGender(value)),
        ),
        Text(title)
      ],
    );
  }
}
