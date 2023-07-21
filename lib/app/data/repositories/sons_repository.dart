import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/utils/local_storage.dart';
import '../models/son.dart';
import '../provider/api_helper.dart';

class SonsRepository {
  final ApiClient apiClient;

  SonsRepository({required this.apiClient});

  String? nextUrl;
  var loadCompleted = false;
  Future<dynamic> getSonsApi({nextUrl}) async {
    Response? response = await apiClient.getAsync(
        nextUrl ??
            'student-auth/children?lang=${LocalStorage().getlanguageSelected() ?? "ar"}&pagenate=true',
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      Son son = Son.fromJson(response?.data);
      if (son.data?.nextPageUrl != null) {
        nextUrl =
            "${(son.data?.nextPageUrl)!}&lang=${LocalStorage().getlanguageSelected() ?? "ar"}&pagenate=true";
      }
      if (son.data?.data != null) {
        return son.data?.data;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }

  Future<dynamic> addSonApi(SonDataData? sonDataData) async {
    var data = FormData.fromMap({
      "id": sonDataData?.id?.toString(),
      "name": sonDataData?.name,
      "gender": sonDataData?.gender,
      "id_number": sonDataData?.idNumber,
      "birth_date": sonDataData?.birthDate,
      "id_image": sonDataData?.idImage != null && sonDataData?.idImage != ""
          ? await MultipartFile.fromFile(sonDataData?.idImage ?? "")
          : null,
      "certificate_image": sonDataData?.certificateImage != null &&
              sonDataData?.certificateImage != ""
          ? await MultipartFile.fromFile(sonDataData?.certificateImage ?? "")
          : null,
      "image": sonDataData?.image != null && sonDataData?.image != ""
          ? await MultipartFile.fromFile(sonDataData?.image ?? "")
          : null,
    });

    dynamic response = await apiClient
        .postAsyncNormal('student-auth/add-child', data, isTokenRequired: true);
    if (response is Response) {
      if (response.statusCode == 200) {
        return SonDataData.fromJson(response.data["data"]);
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> deleteSonApi(SonDataData? sonDataData) async {
    dynamic response = await apiClient.postAsyncNormal(
        'student-auth/delete-child', sonDataData?.toJson(),
        isTokenRequired: true);
    if (response is Response) {
      if (response.statusCode == 200) {
        return response.data['status'];
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> editSonApi(SonDataData? sonDataData) async {
    var data = FormData.fromMap({
      "id": sonDataData?.id?.toString(),
      "name": sonDataData?.name,
      "gender": sonDataData?.gender,
      "id_number": sonDataData?.idNumber,
      "birth_date": sonDataData?.birthDate,
      if (File(sonDataData?.idImage ?? "").existsSync())
        "id_image": sonDataData?.idImage != null
            ? await MultipartFile.fromFile(sonDataData?.idImage ?? "")
            : null,
      if (File(sonDataData?.certificateImage ?? "").existsSync())
        "certificate_image": sonDataData?.certificateImage != null
            ? await MultipartFile.fromFile(sonDataData?.certificateImage ?? "")
            : null,
      if (File(sonDataData?.image ?? "").existsSync())
        "image": await MultipartFile.fromFile(sonDataData?.image ?? ""),
    });

    dynamic response = await apiClient.postAsyncNormal(
        'student-auth/update-child', data,
        isTokenRequired: true);
    if (response is Response) {
      if (response.statusCode == 200) {
        return SonDataData.fromJson(response.data["data"]);
      } else {
        return response;
      }
    } else {
      return response;
    }
  }

  Future<dynamic> addFamilyId(
      String selectedFamilyIdImage, guardianIdNumber) async {
    var data = FormData.fromMap({
      "guardian_id_number": guardianIdNumber,
      "family_id_image": await MultipartFile.fromFile(selectedFamilyIdImage),
    });

    dynamic response = await apiClient.postAsyncNormal(
        'student-auth/complete-account-data', data,
        isTokenRequired: true);
    if (response is Response) {
      if (response.statusCode == 200) {
        return SonDataData.fromJson(response.data["student"]);
      } else {
        return response;
      }
    } else {
      return response;
    }
  }
}
