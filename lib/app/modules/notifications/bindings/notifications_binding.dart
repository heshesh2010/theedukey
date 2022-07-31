import 'package:get/get.dart';
import '../../../data/provider/api_helper.dart';
import '../../../data/repositories/notification_repository.dart';
import '../controllers/notifications_controller.dart';
import 'package:dio/dio.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.create(() => NotificationController(
        repository: NotificationRepository(apiClient: ApiClient(dio: Dio()))));
  }
}
