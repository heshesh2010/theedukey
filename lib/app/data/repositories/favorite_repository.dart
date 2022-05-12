import '../models/favorite.dart';
import '../models/notification.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;

var nextUrl;
var loadCompleted = false;
Future<dynamic> getFavoritesApi({nextUrl}) async {
  Dio.Response? response = await ApiHelper()
      .getAsync(nextUrl ?? 'student-auth/favorites', isTokenRequired: true);
  if (response?.statusCode == 200) {
    var data = response?.data["data"];
    if (data != null) {
      //  nextUrl = data['next_page_url'];
    }
    return (data as List).map((p) => Favorite.fromMap(p)).toList();

//    return City.fromMap(response?.data["data"]);
  } else {
    return response;
  }
}
