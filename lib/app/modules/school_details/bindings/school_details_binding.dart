import 'package:get/get.dart';

import '../controllers/school_details_controller.dart';

class SchoolDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolDetailsController>(
      () => SchoolDetailsController(),
    );
  }
}
