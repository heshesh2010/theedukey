import 'package:get/get.dart';

import '../../contact_us/controllers/contact_us_controller.dart';

class ContactUsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }
}
