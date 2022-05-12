import 'package:get_storage/get_storage.dart';

import '../../app/data/models/user.dart';
import '../values/constants/general.dart';

class LocalStorage {
  /// Write
  void saveLanguageToDisk(String? language) async {
    await GetStorage().write('lang', language);
  }

  /// Read
  getlanguageSelected() {
    return GetStorage().read('lang');
  }

  User? getUser() {
    if (GetStorage().read(kLocalKey["userInfo"]!) != null) {
      return User.fromJson(GetStorage().read(kLocalKey["userInfo"]!));
    } else {
      return null;
    }
  }

  getToken() {
    if (GetStorage().read(kLocalKey["userInfo"]!) != null) {
      return User.fromJson(GetStorage().read(kLocalKey["userInfo"]!)).token;
    } else {
      return null;
    }
  }

  saveUser(User user) {
    GetStorage().write(kLocalKey["userInfo"]!, user.toJson());
  }

  removeUser() {
    GetStorage().remove(kLocalKey["userInfo"]!);
  }
}
