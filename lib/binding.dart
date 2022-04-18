import 'package:get/get.dart';
import 'package:theedukey/controller/auth_controller.dart';

import 'controller/contact_us_controller.dart';
import 'controller/home_controller.dart';
import 'controller/navigator_controller.dart';
import 'controller/notifications_controller.dart';
import 'elements/bottom_navigation_bar.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ContactUsController());
    Get.lazyPut(() => NavigatorController());
  }
}
