import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/sons_repository.dart';
import '../controllers/sons_controller.dart';
import 'package:dio/dio.dart';

class SonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<SonsController>(
      () => SonsController(
          repository: SonsRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
