import '../../core/utils/local_storage.dart';
import '../models/notification.dart';
import '../provider/api_helper.dart';
import 'package:dio/dio.dart' as dio;

class NotificationRepository {
  final ApiClient apiClient;
  String? nextUrl;

  NotificationRepository({required this.apiClient});
  var loadCompleted = false;
  Future<dynamic> getNotificationsApi() async {
    dio.Response? response = await apiClient.getAsync(
        nextUrl ??
            'student-auth/notifications?lang=${LocalStorage().getlanguageSelected() ?? "ar"}',
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      Notification notification = Notification.fromJson(response?.data);
      if (notification.data?.nextPageUrl != null) {
        nextUrl =
            "${(notification.data?.nextPageUrl)!}&lang=${LocalStorage().getlanguageSelected() ?? "ar"}";
      }
      if (notification.data?.data != null) {
        return notification.data?.data;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }
}
