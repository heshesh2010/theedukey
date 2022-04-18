import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:theedukey/screens/home_screen.dart';
import 'package:theedukey/screens/login_screen.dart';
import '../binding.dart';
import '../controller/auth_controller.dart';
import '../elements/bottom_navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  final AuthController controller = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if (controller.getUser() == null) {
      Get.to(() => const LoginScreen(), binding: HomeBinding());
    } else {
      Get.to(
        () => const NavigatorPage(tabIndex: 1),
        binding: HomeBinding(),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
