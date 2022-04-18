import 'package:get_storage/get_storage.dart';

class LocalStorage {

  /// Write
  void saveLanguageToDisk (String? language)async{
    await GetStorage().write('lang', language);
  }

  /// Read
  Future<String?> get languageSelected async{
    return GetStorage().read('lang');
  }
}