import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../data/models/setting.dart';
import '../data/provider/api_helper.dart';
import '../data/repositories/setting_repository.dart';

class SettingsService extends GetxService {
  final settings = Settings().obs;

  final SettingRepository _settingsRepo =
      SettingRepository(apiClient: ApiClient(dio: Dio()));

  Future<SettingsService> init() async {
    _settingsRepo.getSettingsApi().then((value) {
      settings.value = value;
    });
    return this;
  }
}
