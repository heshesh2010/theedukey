import 'package:get/get.dart';
import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/repositories/notification_repository.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../language/controllers/language_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../orders/controllers/orders_controller.dart';
import '../controllers/home_controller.dart';
import 'package:dio/dio.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
        repository: HomeRepository(apiClient: ApiClient(dio: Dio()))));
    Get.lazyPut(() => NotificationController(
        repository: NotificationRepository(apiClient: ApiClient(dio: Dio()))));
    Get.lazyPut<OrdersController>(
      () => OrdersController(
          repository: OrdersRepository(apiClient: ApiClient(dio: Dio()))),
    );
    Get.lazyPut(() => LanguageController());
    Get.lazyPut(() => AuthController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
