import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

import '../controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => SignUpController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
