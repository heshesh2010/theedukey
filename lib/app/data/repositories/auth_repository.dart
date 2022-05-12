import '../models/city.dart';
import '../models/user.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart';

Future<dynamic> loginApi(User user) async {
  Response? response = await ApiHelper().postAsyncNormal(
      "student-auth/login", user.toJson(),
      isTokenRequired: false);
  if (response?.statusCode == 200) {
    if (response?.data["error"] != null) {
      return response?.data["error"];
    } else {
      return User.fromMap(response?.data["user"]);
    }
  } else {
    return response;
  }
}

Future<dynamic> signUpApi(User user) async {
  Response? response = await ApiHelper().postAsyncNormal(
      "student-auth/register", user.toJson(),
      isTokenRequired: false);
  if (response?.statusCode == 200) {
    return User.fromMap(response?.data["user"]);
  } else {
    return response;
  }
}

Future<dynamic> updateProfileApi(User user) async {
  Response? response = await ApiHelper().postAsyncNormal(
      "student-auth/update-profile", user.toJson(),
      isTokenRequired: true);
  if (response?.statusCode == 200) {
    return User.fromMap(response?.data["user"]);
  } else {
    return response;
  }
}

Future<dynamic> forgetApi(User user) async {
  Response? response = await ApiHelper().postAsyncNormal(
      "student-auth/forget", user.toJson(),
      isTokenRequired: false);
  if (response?.statusCode == 200) {
    return User.fromMap(response?.data["user"]);
  } else {
    return response;
  }
}

Future<dynamic> getCitiesApi() async {
  Response? response =
      await ApiHelper().getAsync("all-cities", isTokenRequired: false);
  if (response?.statusCode == 200) {
    return (response?.data["data"] as List)
        .map((p) => City.fromMap(p))
        .toList();

//    return City.fromMap(response?.data["data"]);
  } else {
    return response;
  }
}
