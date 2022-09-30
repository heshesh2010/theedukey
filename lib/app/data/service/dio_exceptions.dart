import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DioExceptions implements Exception {
  String? message;

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return error["errors"].toString();
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message!;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled".tr;
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server".tr;
        break;
      case DioErrorType.other:
        message =
            "Connection to API server failed due to internet connection".tr;
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server".tr;
        break;
      case DioErrorType.response:
        message = _handleError(
            dioError.response?.statusCode ?? 0, dioError.response?.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server".tr;
        break;
      default:
        message = "Something went wrong".tr;
        break;
    }
  }
}
