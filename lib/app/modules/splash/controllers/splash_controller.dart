import 'dart:async';
import 'package:get/get.dart';
import '../../../core/utils/local_storage.dart';
import '../../../../elements/bottom_navigation_bar.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  //final AuthController controller = Get.put(Authcontroller);

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(const Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    if (LocalStorage().getUser() == null) {
      Get.toNamed(Routes.login);
    } else {
      Get.to(
        () => const NavigatorPage(tabIndex: 1),
      );
    }
    FlutterNativeSplash.remove();
  }
}
