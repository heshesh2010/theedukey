import 'package:get/get.dart';
import '../../../../navigator_controller.dart';
import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/home_repository.dart';
import '../../../data/repositories/notification_repository.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../../data/repositories/school_repository.dart';
import '../../../data/repositories/search_repository.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../language/controllers/language_controller.dart';
import '../../notifications/controllers/notifications_controller.dart';
import '../../orders/controllers/orders_controller.dart';
import '../../school_details/controllers/school_details_controller.dart';
import '../../search/controllers/search_controller.dart';
import '../../sign_up/controllers/signup_controller.dart';
import '../controllers/home_controller.dart';
import 'package:dio/dio.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.create(() => HomeController(
        repository: HomeRepository(apiClient: ApiClient(dio: Dio()))));
    Get.create(() => NotificationController(
        repository: NotificationRepository(apiClient: ApiClient(dio: Dio()))));
    Get.create<OrdersController>(
      () => OrdersController(
          repository: OrdersRepository(apiClient: ApiClient(dio: Dio()))),
    );
    Get.create(() => LanguageController());
    Get.create(() => AuthController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
    Get.create(() => SignUpController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
    Get.create(() => AuthController(
        repository: AuthRepository(apiClient: ApiClient(dio: Dio()))));
    Get.lazyPut<SchoolDetailsController>(() => SchoolDetailsController(
        repository: SchoolRepository(apiClient: ApiClient(dio: Dio()))));
    Get.lazyPut(() => SearchControllerGetx(
        repository: SearchRepository(apiClient: ApiClient(dio: Dio()))));
    Get.lazyPut(() => NavigatorController());
  }
}
