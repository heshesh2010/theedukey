import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/controller/auth_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:theedukey/screens/forget_screen.dart';
import '../constants/route_list.dart';
import '../elements/bottom_navigation_bar.dart';
import '../elements/topbar.dart';
import '../models/user.dart';
import 'home_screen.dart';
import 'signUp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.put(AuthController());

  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");

  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  // User.fromJson(GetStorage().read(kLocalKey["userInfo"]!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const TopBar(),
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
                            Text("login".tr,
                                style: Theme.of(context).textTheme.headline1),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
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
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
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
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (String? value) =>
                                  value!.trim().isEmpty
                                      ? "Password is require".tr
                                      : null,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgetScreen());
                                },
                                child: Text(
                                  "forget".tr,
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  if (Get.previousRoute !=
                                          RouteList.splashScreen &&
                                      Get.previousRoute != RouteList.forget &&
                                      Get.previousRoute !=
                                          RouteList.splashScreen) {
                                    Get.back();
                                  } else {
                                    Get.to(
                                        () => const NavigatorPage(tabIndex: 1));
                                  }
                                },
                                child: Text("skip".tr),
                              ),
                            ),
                            const SizedBox(height: 20),
                            RoundedLoadingButton(
                              child: Text('enter'.tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              controller: controller.btnLoginController,
                              duration: const Duration(seconds: 2),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.login(User(
                                      email: _emailTextController.text,
                                      password: _passwordTextController.text));
                                } else {
                                  controller.btnLoginController.reset();
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => SignUpPageScreen());
                                },
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: "don't_have_an_account".tr),
                                      TextSpan(
                                        text: 'signUp'.tr,
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
