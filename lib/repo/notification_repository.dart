import '../models/notification.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;
import '../controller/auth_controller.dart';
import 'package:get/get.dart';

var nextUrl;
var loadCompleted = false;
Future<dynamic> getNotificationsApi(uri) async {
  final userController = Get.find<AuthController>();

  Dio.Response? response = await ApiHelper().getAsyncNoUserType(uri ??
      'student-auth/notifications?token=' +
          userController.currentUser.value!.token!);
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
