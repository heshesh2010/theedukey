import '../../core/utils/local_storage.dart';
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

//    return City.fromMap(response?.data["data"]);
    } else {
      return response;
    }
  }
}
