import '../models/notification.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;

var nextUrl;
var loadCompleted = false;
Future<dynamic> getNotificationsApi({nextUrl}) async {
  Dio.Response? response = await ApiHelper()
      .getAsync(nextUrl ?? 'student-auth/notifications', isTokenRequired: true);
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
