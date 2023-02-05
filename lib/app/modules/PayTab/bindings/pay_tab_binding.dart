import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/paymentMethods_repository.dart';
import '../controllers/pay_tab_controller.dart';

class PayTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PayTabController>(
      () =>
          PayTabController(PaymentRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
