import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/offers_repository.dart';
import '../controllers/offers_controller.dart';
import 'package:dio/dio.dart';

class OffersBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<OffersController>(
      () => OffersController(
          repository: OffersRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
