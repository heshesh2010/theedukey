import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/orders_repository.dart';
import '../controllers/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(
          repository: OrdersRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
