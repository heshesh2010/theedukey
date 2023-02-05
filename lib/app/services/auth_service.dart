import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/general.dart';
import '../data/models/user.dart';
import '../data/repositories/auth_repository.dart';

class AuthService extends GetxService {
  final user = User().obs;
  GetStorage? _box;

  AuthRepository? _usersRepo;

  AuthService() {
    // _usersRepo = AuthRepository(apiClient: null);
    _box = GetStorage();
  }

  Future<AuthService> init() async {
    user.listen((User user) {
      // if (Get.isRegistered<SettingsService>()) {
      //   Get.find<SettingsService>().address.value.userId = user.id;
      // }
      _box?.write(kLocalKey["userInfo"]!, user.toJson());
    });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    if (user.value.auth == false && _box!.hasData(kLocalKey["userInfo"]!)) {
      user.value = User.fromJson(await _box?.read(kLocalKey["userInfo"]!));
      user.value.auth = true;
    } else {
      user.value.auth = false;
    }
  }

  Future removeCurrentUser() async {
    user.value = User();
    //await _usersRepo.signOut();
    await _box?.remove(kLocalKey["userInfo"]!);
  }

  bool get isAuth => user.value.auth;

  String? get apiToken => (user.value.auth) ? user.value.token : '';
}
