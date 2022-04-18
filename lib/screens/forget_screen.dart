import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/controller/auth_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:theedukey/screens/login_screen.dart';
import '../elements/topbar.dart';
import '../models/user.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final AuthController controller = Get.put(AuthController());

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
                            Text("forget".tr,  style:Theme.of(context).textTheme.headline1),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.forgetProcess.value,
                              controller: _emailTextController,
                              decoration:  InputDecoration(labelText:  "email".tr,fillColor: Colors.amber),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              child:  Text('submit'.tr,style: const TextStyle(fontWeight: FontWeight.bold)),
                              controller: controller.btnForgetController,
                              duration: const Duration(seconds: 2),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {

                                if (_formKey.currentState!.validate()) {
                                  await controller.forget(User(email: _emailTextController.text ));
                                }
                                else{
                                  controller.btnForgetController.reset();
                                }
                              },
                            ),
                            const SizedBox(height: 20,),

                            Center(
                              child: TextButton(
                                onPressed: () {
                                  //    Get.updateLocale(const Locale("ar"));
                                  Get.to(() => const LoginScreen());
                                },
                                child:  Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "remember_pass".tr),
                                      TextSpan(
                                        text: 'login'.tr,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),),
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