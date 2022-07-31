import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';
import 'package:dio/dio.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => AuthController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
