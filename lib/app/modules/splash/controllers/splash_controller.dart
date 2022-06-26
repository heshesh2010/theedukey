import 'dart:async';
import 'package:get/get.dart';
import '../../../core/utils/local_storage.dart';
import '../../../../elements/bottom_navigation_bar.dart';
import '../../../routes/route_list.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashController extends GetxController {
  final count = 0.obs;

  //final AuthController controller = Get.put(AuthController());

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
      Get.toNamed(RouteList.login);
    } else {
      Get.to(
        () => const NavigatorPage(tabIndex: 1),
      );
    }
    FlutterNativeSplash.remove();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
