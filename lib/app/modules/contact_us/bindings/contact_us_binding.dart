import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/contact_us_repository.dart';
import '../../contact_us/controllers/contact_us_controller.dart';
import 'package:dio/dio.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController(
        repository: ContactUsRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
