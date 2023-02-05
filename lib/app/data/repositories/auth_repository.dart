import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;

import '../../core/utils/local_storage.dart';
import '../../providers.dart/firebase_provider.dart';
import '../models/city.dart';
import '../models/user.dart';
import '../provider/api_helper.dart';

class AuthRepository {
  final ApiClient apiClient;
  final FirebaseProvider _firebaseProvider = getx.Get.find<FirebaseProvider>();

  AuthRepository({required this.apiClient});

  Future<dynamic> termsApi() async {
    Response? response = await apiClient.getAsync(
        "terms?lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return (response?.data["data"]["terms"]);
    } else {
      return response?.statusMessage;
    }
  }

//  Future<User> getCurrentUser() {
//     return this.get(Get.find<AuthService>().user.value);
//   }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    return _firebaseProvider.signInWithEmailAndPassword(email, password);
  }

  Future<bool> signUpWithEmailAndPassword(String email, String password) async {
    return _firebaseProvider.signUpWithEmailAndPassword(email, password);
  }

  Future<void> verifyPhone(String smsCode) async {
    return _firebaseProvider.verifyPhone(smsCode);
  }

  Future<void> sendCodeToPhone() async {
    return _firebaseProvider.sendCodeToPhone();
  }

  Future<dynamic> loginApi(User user) async {
    dynamic response = await apiClient.postAsyncNormal(
        "student-auth/login", user.toJson(),
        isTokenRequired: false);

    if (response is Response) {
      if (response.statusCode == 200) {
        if (response.data["error"] != null) {
          return response.data["error"];
        } else {
          return User.fromMap(response.data["user"]);
        }
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> signUpApi(User user) async {
    dynamic response = await apiClient.postAsyncNormal(
        "student-auth/register", user.toJson(),
        isTokenRequired: false);
    if (response is Response) {
      if (response.statusCode == 200) {
        return User.fromMap(response.data["user"]);
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> updateProfileApi(User? user) async {
    var data = FormData.fromMap({
      "email": user?.email,
      "name": user?.name,
      "name_en": user?.nameEn,
      "phone": user?.phone,
      "old_password": user?.oldPassword,
      "password": user?.password,
      "password_confirmation": user?.passwordConfirmation,
      "city": user?.city?.id,
      "id_image": user?.idImage != null && user?.idImage != ""
          ? await MultipartFile.fromFile(user?.idImage ?? "")
          : null,
      "certificate_image":
          user?.certificateImage != null && user?.certificateImage != ""
              ? await MultipartFile.fromFile(user?.certificateImage ?? "")
              : null,
      "image": user?.image != null && user?.image != ""
          ? await MultipartFile.fromFile(user?.image ?? "")
          : null,
    });

    dynamic response = await apiClient.postAsyncNormal(
        "student-auth/update-profile", data,
        isTokenRequired: true);
    if (response is Response) {
      if (response.statusCode == 200) {
        return User.fromMap(response.data["student"]);
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> forgetApi(User user) async {
    Response? response = await apiClient.postAsyncNormal(
        "student-auth/forget", user.toJson(),
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return User.fromMap(response?.data["user"]);
    } else {
      return response;
    }
  }

  Future<dynamic> getCitiesApi() async {
    Response? response = await apiClient.getAsync(
        "all-cities?lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return (response?.data["data"] as List)
          .map((p) => City.fromMap(p))
          .toList();

//    return City.fromMap(response?.data["data"]);
    } else {
      return response;
    }
  }
}
