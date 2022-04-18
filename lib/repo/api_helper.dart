import "dart:core";
import 'package:dio/dio.dart';
import '../constants/general.dart';

class ApiHelper {
  var dio = Dio(); // with default Options

  ApiHelper() {
// Set default configs
    dio.options.baseUrl = 'https://dev17.toplinedev.com/theedukey/public/api/';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
  }

  Future<dynamic> getAsyncNoUserType(String endPoint) async {
    try {
      Response response = await dio.get(endPoint);
      printLog(
          "[EduKey Client_api][${DateTime.now().toString().split(' ').last}] postAsync START [endPoint:$endPoint] url:${dio.options.baseUrl}");
      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      if (e.response != null) {
        printLog(e.response?.data);
        printLog(e.response?.headers);
        printLog(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        printLog(e.requestOptions);
        printLog(e.message);
      }
      return e.response;
    }
  }

  Future<dynamic> getAsyncWithToken(String endPoint, dynamic data) async {
    try {
      Response response = await dio.get(endPoint);
      printLog(
          "[EduKey Client_api][${DateTime.now().toString().split(' ').last}] postAsync START [endPoint:$endPoint] url:${dio.options.baseUrl}");
      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      if (e.response != null) {
        printLog(e.response?.data);
        printLog(e.response?.headers);
        printLog(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        printLog(e.requestOptions);
        printLog(e.message);
      }
      return e.response;
    }
  }

  Future<Response?> postAsyncNormal(String endPoint, dynamic data) async {
    try {
      printLog(
          "[EduKey Client_api][${DateTime.now().toString().split(' ').last}] postAsync START [endPoint:$endPoint] url:${dio.options.baseUrl}");
      Response response = await dio.post(endPoint, data: data);

      return response;
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.

      if (e.response != null) {
        printLog(e.response?.data);
        printLog(e.response?.headers);
        printLog(e.response?.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        printLog(e.requestOptions);
        printLog(e.message);
      }
      return e.response;
    }
  }
}
