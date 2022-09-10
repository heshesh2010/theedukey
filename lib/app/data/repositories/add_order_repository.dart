import 'package:dio/dio.dart';
import '../../core/utils/local_storage.dart';
import '../models/son.dart';
import '../provider/api_helper.dart';

class AddOrderRepository {
  final ApiClient apiClient;

  AddOrderRepository({required this.apiClient});

  String? nextUrl;
  var loadCompleted = false;
  Future<dynamic> getSonsApi() async {
    Response? response = await apiClient.getAsync(
        'student-auth/children?lang=${LocalStorage().getlanguageSelected() ?? "ar"}',
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      SonData son = SonData.fromJson(response?.data);
      return son.data;
    } else {
      return response;
    }
  }

  Future<dynamic> addOrderApi(
      {required String priceId, required String facilityId}) async {
    Response? response = await apiClient.postAsyncNormal(
        "student-auth/add-order",
        {"price_id": priceId, "facility_id": facilityId},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      //     SonData son = SonData.fromJson(response?.data);
      return true;
    } else {
      return response;
    }
  }

  Future<dynamic> addOrderWithSonApi(
      {required String priceId,
      required String childId,
      required String facilityId}) async {
    Response? response = await apiClient.postAsyncNormal(
        "student-auth/add-order",
        {"price_id": priceId, "child_id": childId, "facility_id": facilityId},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      // Facility son = Facility.fromJson(response?.data);
      return true;
    } else {
      return response;
    }
  }
}
