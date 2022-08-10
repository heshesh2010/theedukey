import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/school_repository.dart';
import '../controllers/school_details_controller.dart';

class SchoolDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SchoolDetailsController>(
      () => SchoolDetailsController(
          repository: SchoolRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
