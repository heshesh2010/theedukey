import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/search_repository.dart';
import '../controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchControllerGetx(
        repository: SearchRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
