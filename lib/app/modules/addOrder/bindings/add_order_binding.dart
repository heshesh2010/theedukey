import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/add_order_repository.dart';
import '../controllers/add_order_controller.dart';

class AddOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddOrderController>(
      () => AddOrderController(
          repository: AddOrderRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
