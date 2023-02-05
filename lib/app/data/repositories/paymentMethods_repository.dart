import 'dart:convert';

import 'package:dio/dio.dart' as dio;

import '../../core/utils/local_storage.dart';
import '../models/payment_method.dart';
import '../provider/api_helper.dart';

class PaymentRepository {
  final ApiClient apiClient;
  String? nextUrl;

  PaymentRepository({required this.apiClient});
  var loadCompleted = false;

  Future<dynamic> getPaymentMethodsApi({required orderId}) async {
    dio.Response? response = await apiClient.getAsync(
        "student-auth/order-payment-option?order_id=$orderId&lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      List<PaymentMethod> realdata = (response?.data['payment_options'] as List)
          .map((i) => PaymentMethod.fromMap(i))
          .toList();
      return realdata;
    } else {
      return response;
    }
  }

  Future<String> getPaymentUrlApi(
      {int? orderId, required paymentMethodName}) async {
    dio.Response? response = await apiClient.getAsync(
        "student-auth/payment-url?order_id=$orderId&type=$paymentMethodName",
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return response?.data["payment_url"];
    } else {
      return response?.data;
    }
  }

  setPaymentSuccessApi({int? orderId}) async {
    dio.Response? response = await apiClient.postAsyncNormal(
        "student-auth/tamara-success",
        {"orderId": orderId, "paymentStatus": "approved"},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      return response?.data;
    }
  }

  setPaymentFailedApi({int? orderId}) async {
    dio.Response? response = await apiClient.postAsyncNormal(
        "student-auth/tamara-failure",
        {"orderId": orderId, "paymentStatus": "fail"},
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      return response?.data;
    }
  }

  setPaymentCanceledApi({int? orderId}) async {
    dio.Response? response = await apiClient.postAsyncNormal(
        "student-auth/tamara-cancel",
        json.encode({"orderId": orderId, "paymentStatus": "fail"}),
        isTokenRequired: true);
    if (response?.statusCode == 200) {
      return response?.data;
    } else {
      return response?.data;
    }
  }
}
