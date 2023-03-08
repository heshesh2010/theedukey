import 'package:get/get.dart';
import 'package:theedukey/app/modules/auth/controllers/auth_controller.dart';
import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => AuthController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
