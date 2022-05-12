import 'package:get/get.dart';

import '../controllers/sons_controller.dart';

class SonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SonsController>(
      () => SonsController(),
    );
  }
}
