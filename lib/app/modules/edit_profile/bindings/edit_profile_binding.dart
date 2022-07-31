import 'package:get/get.dart';
import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import '../controllers/edit_profile_controller.dart';
import 'package:dio/dio.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => EditProfileController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
