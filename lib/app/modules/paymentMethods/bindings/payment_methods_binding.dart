import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/paymentMethods_repository.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodsController>(
      () => PaymentMethodsController(
          repository: PaymentRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
