import '../../modules/auth/controllers/auth_controller.dart';
import '../models/notification.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:get/get.dart';

var nextUrl;
var loadCompleted = false;
Future<dynamic> getNotificationsApi({nextUrl}) async {
  final userController = Get.find<AuthController>();

  Dio.Response? response = await ApiHelper()
      .getAsyncWithToken(nextUrl ?? 'student-auth/notifications');
  if (response?.statusCode == 200) {
    var data = response?.data["data"];
    if (data != null) {
      nextUrl = data['next_page_url'];
    }
    return (response?.data["data"]["data"] as List)
        .map((p) => Notification.fromMap(p))
        .toList();

//    return City.fromMap(response?.data["data"]);
  } else {
    return response;
  }
}
