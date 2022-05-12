import 'package:get/get.dart';
import '../../language/controllers/language_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => LanguageController());
  }
}
