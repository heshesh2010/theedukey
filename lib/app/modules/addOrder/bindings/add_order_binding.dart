import 'package:get/get.dart';

import '../controllers/add_order_controller.dart';

class AddOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrderController>(
      () => AddOrderController(),
    );
  }
}
