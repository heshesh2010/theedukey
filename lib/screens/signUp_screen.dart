import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/controller/auth_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../elements/topbar.dart';
import '../helper.dart';
import '../models/city.dart';
import '../models/user.dart';



class SignUpPageScreen extends GetView<AuthController> {
  SignUpPageScreen({Key? key}) : super(key: key);


  final _nameArTextController = TextEditingController(text: "");
  final _nameEnTextController = TextEditingController(text: "");
  final _mobileTextController = TextEditingController(text: "");
  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _passwordConfirmTextController = TextEditingController(text: "");



  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            const SizedBox(height: 20),
                              Text("signUp".tr,  style:Theme.of(context).textTheme.headline1),
                            //ar_name
                            TextFormField(
                              enabled: !controller.signUpProcess.value,
                              controller: _nameArTextController,
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
                            //en_name
                            TextFormField(
                              enabled: !controller.signUpProcess.value,
                              controller: _nameEnTextController,
                              decoration:  InputDecoration(labelText:  "name_en".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!=null&&value.length>5) {
                                  return null;
                                } else {
                                  return "Name is not valid".tr;
                                }
                              },
                            ),
                            //mobile
                            TextFormField(
                              enabled: !controller.signUpProcess.value,
                              controller: _mobileTextController,
                              decoration:  InputDecoration(labelText:  "mobile".tr),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                              enabled: !controller.signUpProcess.value,
                              controller: _emailTextController,
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
                            const SizedBox(height: 8),
                           Obx( () => SizedBox(
                             height: 70,
                             child: DropdownButton(
                               //isDense: true,
                               isExpanded: true,
                               hint:  Text(
                                 controller.selectedCity.value.name!,
                                ),
                                onChanged: (dynamic value) {
                                  controller.setSelectedCity(value);
                                  controller.selectedCity.value = value;
                                  controller.update();
                                },
                                items: controller.citiesList.map((City selectedType) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      selectedType.name!,
                                    ),
                                    value: selectedType,
                                  );
                                }).toList(),
                              ),
                           )
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.signUpProcess.value,
                              controller: _passwordTextController,
                              decoration: InputDecoration(
                                  labelText: "password".tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                        _passwordVisible = !_passwordVisible;
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (String? value) => value!.trim().isEmpty||value.length<8
                                  ? "Password is require".tr
                                  : null,
                            ),
                            TextFormField(
                              enabled: !controller.signUpProcess.value,
                              controller: _passwordConfirmTextController,
                              decoration: InputDecoration(
                                  labelText: "password_confirm".tr,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                        _passwordVisible = !_passwordVisible;
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (String? value) => value!.allMatches(_passwordTextController.value.text).isEmpty
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
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                     focusColor: Theme.of(context).focusColor,
                                   //   activeColor: Theme.of(context).colorScheme.secondary,
                                    value: controller.agreedToTOS.value,
                                    onChanged: (value) {
                                      controller.agreedToTOS.value=value!;
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
                                            decoration: TextDecoration.underline,
                                            color: Theme.of(context).hintColor)),
                                    onTap: () {
                                      //     showTosDialog(context, _con);
                                    })
                              ],
                            ),

                            const SizedBox(height: 20),
                            RoundedLoadingButton(
                              child:  Text('signUp'.tr,style: const TextStyle(fontWeight: FontWeight.bold)),
                              controller: controller.btnSignUpController,
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                               // showLoadingDialog(context);
                               // btnSignUpController.stop();
                                if(!controller.agreedToTOS.value){
                                  Helper().showErrorToast("you_must_agree_TOS".tr);
                                  controller.btnSignUpController.reset();
                                }
                             else   if (_formKey.currentState!.validate()) {
                                  await controller.signUp(User(email: _emailTextController.text,password:_passwordTextController.text ,passwordConfirmation: _passwordConfirmTextController.text,name: _nameArTextController.text,nameEn: _nameEnTextController.text,mobile: _mobileTextController.text,city: controller.selectedCity.value));
                                }
                                else{
                                  Helper().showErrorToast("please_review_all_fields".tr);
                                  controller.btnSignUpController.reset();
                                }
                              },
                            ),
                            const SizedBox(height: 20,),

                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child:  Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(text: "have_an_account".tr),
                                       TextSpan(
                                        text: "login".tr,
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