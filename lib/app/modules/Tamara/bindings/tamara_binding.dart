import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/paymentMethods_repository.dart';
import '../controllers/tamara_controller.dart';

class TamaraBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => TamaraController(
        paymentRepository:
            PaymentRepository(apiClient: ApiClient(dio: Dio()))));
    // Get.put(() => TamaraController(
    //     paymentRepository:
    //         PaymentRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
