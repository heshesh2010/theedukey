import '../../core/utils/local_storage.dart';
import '../models/school.dart';
import '../models/stage.dart';
import '../provider/api_helper.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final ApiClient apiClient;

  HomeRepository({required this.apiClient});

  Future<dynamic> getStagesApi() async {
    Response? response = await apiClient.getAsync(
        "get-all-filter-data?lang=${LocalStorage().getlanguageSelected() ?? "ar"}");
    if (response?.statusCode == 200) {
      return (response?.data["data"]["stages"] as List)
          .map((p) => Stage.fromMap(p))
          .toList();
    } else {
      return response;
    }
  }

  Future<dynamic> getAboutUsApi() async {
    Response? response = await apiClient
        .getAsync("about?lang=${LocalStorage().getlanguageSelected() ?? "ar"}");
    if (response?.statusCode == 200) {
      return (response?.data["data"]["text"]);
    } else {
      return response;
    }
  }

  Future<dynamic> getSuggestionsApi(pattern) async {
    Response? response = await apiClient.getAsync(
        "search?keyword=$pattern&lang=${LocalStorage().getlanguageSelected() ?? "ar"}");
    if (response?.statusCode == 200) {
      return School.fromJson(response?.data).data?.results ?? response;
    } else {
      return response;
    }
  }
}
