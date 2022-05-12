import '../models/son.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;

var nextUrl;
var loadCompleted = false;
Future<dynamic> getSonsApi({nextUrl}) async {
  Dio.Response? response = await ApiHelper()
      .getAsync(nextUrl ?? 'student-auth/children', isTokenRequired: true);
  if (response?.statusCode == 200) {
    Son _son = Son.fromJson(response?.data);
    if (_son.nextPageUrl != null) {
      nextUrl = _son.nextPageUrl;
    }
    return _son.data;
  } else {
    return response;
  }
}
