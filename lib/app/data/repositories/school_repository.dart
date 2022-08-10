import 'package:dio/dio.dart' as dio;
import '../../core/utils/local_storage.dart';
import '../models/facility.dart';
import '../provider/api_helper.dart';

class SchoolRepository {
  final ApiClient apiClient;
  String? nextUrl;

  SchoolRepository({required this.apiClient});
  var loadCompleted = false;

  Future<dynamic> getFacilityApi() async {
    dio.Response? response = await apiClient.getAsync(
        "facility/1?lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return Facility.fromJson(response?.data);
    } else {
      return response;
    }
  }
}
