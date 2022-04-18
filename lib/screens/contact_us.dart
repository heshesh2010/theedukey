import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../controller/contact_us_controller.dart';
import '../elements/drawer.dart';
import '../elements/topbar.dart';
import '../helper.dart';

class ContactUs extends GetView<ContactUsController> {
   ContactUs({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:    DrawerSideMenu(),
      appBar: getTopBar(context),
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
                            //ar_name
                            TextFormField(
                              enabled: !controller.contactUsUpProcess.value,
                              controller: controller.nameArTextController,
                              decoration:  InputDecoration(labelText:  "name_ar".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!=null&&value.length>5) {
                                  return null;
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),

                            //email
                            TextFormField(
                              enabled: !controller.contactUsUpProcess.value,
                              controller: controller.emailTextController,
                              decoration:  InputDecoration(labelText:  "email".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (!GetUtils.isEmail(value!)) {
                                  return "Email is not valid".tr;
                                } else {
                                  return null;
                                }
                              },
                            ),


                            //title
                            TextFormField(
                              enabled: !controller.contactUsUpProcess.value,
                              controller: controller.titleTextController,
                              decoration:  InputDecoration(labelText:  "title".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!=null&&value.length>10) {
                                  return null;
                                } else {
                            return "text_length".tr;
                                }
                              },
                            ),

                            //body
                            TextFormField(
                              minLines: 3,
                              maxLines: 20,
                              enabled: !controller.contactUsUpProcess.value,
                              controller: controller.bodyTextController,
                              decoration:  InputDecoration(labelText:  "body".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!=null&&value.length>10) {
                                  return null;
                                } else {
                                  return "text_length".tr;
                                }
                              },
                            ),
                         const   SizedBox(height: 30,),

                            RoundedLoadingButton(
                              child:  Text('submit'.tr,style: const TextStyle(fontWeight: FontWeight.bold)),
                              controller: controller.btnSubmitController,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                   if (_formKey.currentState!.validate()) {

                                  await controller.contactUs();
                                }
                                else{
                                  Helper().showErrorToast("please_review_all_fields".tr);
                                  controller.btnSubmitController.reset();
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
