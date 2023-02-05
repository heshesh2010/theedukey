import 'package:dio/dio.dart';

import '../models/setting.dart';
import '../provider/api_helper.dart';

class SettingRepository {
  final ApiClient apiClient;

  SettingRepository({required this.apiClient});

  Future<dynamic> getSettingsApi({int? id}) async {
    Response? response =
        await apiClient.getAsync("settings", isTokenRequired: false);
    if (response?.statusCode == 200) {
      return Settings.fromJson(response?.data["settings"]);
    } else {
      return response;
    }
  }
}
