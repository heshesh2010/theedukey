import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import '../../core/utils/local_storage.dart';
import '../models/facility.dart';
import '../models/route_argument.dart';
import '../provider/api_helper.dart';

class SchoolRepository {
  final ApiClient apiClient;
  String? nextUrl;

  SchoolRepository({required this.apiClient});
  var loadCompleted = false;

  Future<dynamic> getFacilityApi({int? id}) async {
    dio.Response? response = await apiClient.getAsync(
        "${LocalStorage().getUser() != null ? "student-auth/facility" : "facility"}/${id ?? (Get.arguments as RouteArgument).schoolId}?lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: LocalStorage().getUser() != null ? true : false);
    if (response?.statusCode == 200) {
      return Facility.fromJson(response?.data);
    } else {
      return response;
    }
  }

  addFavoriteApi(int? schoolId) async {
    dio.Response? response = await apiClient.postAsyncNormal(
        "student-auth/add-to-favorite", {"id": schoolId},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return true;
    } else {
      return response;
    }
  }

  removeFavoriteApi(int? schoolId) async {
    dio.Response? response = await apiClient.postAsyncNormal(
        "student-auth/remove-from-favorite", {"id": schoolId},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return response?.data["status"];
    } else {
      return response;
    }
  }
}
