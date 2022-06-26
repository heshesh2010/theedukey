import 'package:get/get.dart';

import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/favorite_repository.dart';
import '../controllers/favorite_controller.dart';
import 'package:dio/dio.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(
          repository: FavoriteRepository(apiClient: ApiClient(dio: Dio()))),
    );
  }
}
