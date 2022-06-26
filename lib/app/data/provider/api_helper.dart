import "dart:core";
import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:jwt_decode/jwt_decode.dart';
import '../../core/utils/local_storage.dart';
import '../../core/values/constants/general.dart';
import '../../modules/auth/views/auth_view.dart';
import '../models/user.dart';
import '../service/dio_exceptions.dart';

enum TokenErrorType {
  tokenNotFound,
  refreshTokenHasExpired,
  failedToRegenerateAccessToken,
  invalidAccessToken
}

class ApiClient {
  //var dio = Dio(); // with default Options
  String? accessToken;
  Dio dio;
  ApiClient({required this.dio}) {
    // Set default configs
    dio.options.baseUrl = 'https://dev17.toplinedev.com/theedukey/public/api/';
    dio.options.connectTimeout = 5000; //5s
    dio.options.receiveTimeout = 3000;
    dio.options.headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    // dio.interceptors.clear();
    // dio.interceptors.add(
    //   RetryOnConnectionChangeInterceptor(
    //     requestRetrier: DioConnectivityRequestRetrier(
    //       dio: dio,
    //       connectivity: Connectivity(),
    //     ),
    //   ),
    // );
    dio.interceptors.add(
      QueuedInterceptorsWrapper(onRequest: (request, handler) async {
        if (request.headers["requiresToken"] == false) {
          // if the request doesn't need token, then just continue to the next interceptor
          request.headers.remove("requiresToken"); //remove the auxiliary header
          return handler.next(request);
        } else {
          // get tokens from local storage, you can use Hive or flutter_secure_storage
          accessToken = LocalStorage().getToken();

          if (accessToken != null && accessToken != '') {
            request.headers['Authorization'] = 'Bearer $accessToken';
          }

          if (accessToken == null) {
            _performLogout(dio);

            // create custom dio error
            request.extra["tokenErrorType"] = TokenErrorType
                .tokenNotFound; // I use enum type, you can chage it to string
            final error =
                DioError(requestOptions: request, type: DioErrorType.other);
            return handler.reject(error);
          }

          // check if tokens have already expired or not
          // I use jwt_decoder package
          // Note: ensure your tokens has "exp" claim
          final accessTokenHasExpired = Jwt.isExpired(accessToken.toString());

          var refreshed = true;

          if (accessTokenHasExpired) {
            _performLogout(dio);

            // create custom dio error
            request.extra["tokenErrorType"] =
                TokenErrorType.refreshTokenHasExpired;
            final error =
                DioError(requestOptions: request, type: DioErrorType.other);
            // regenerate access token
            refreshed = await _regenerateAccessToken();
            return handler.reject(error);
          }

          if (refreshed) {
            // add access token to the request header
            request.headers["Authorization"] = "Bearer $accessToken";
            return handler.next(request);
          } else {
            // create custom dio error
            request.extra["tokenErrorType"] =
                TokenErrorType.failedToRegenerateAccessToken;
            final error =
                DioError(requestOptions: request, type: DioErrorType.other);
            return handler.reject(error);
          }
        }
      }, onError: (e, handler) async {
        if (e.response?.statusCode == 403 || e.response?.statusCode == 401) {
          // for some reasons the token can be invalidated before it is expired by the backend.
          // then we should navigate the user back to login page

          _performLogout(dio);

          // create custom dio error
          e.type = DioErrorType.other;
          e.requestOptions.extra["tokenErrorType"] =
              TokenErrorType.invalidAccessToken;
        }

        return handler.next(e);
      }),
    );
  }

  Future<dynamic> getAsync(String endPoint,
      {bool isTokenRequired = false}) async {
    try {
      Response response = await dio.get(
        endPoint,
        options: Options(
            headers: {"requiresToken": isTokenRequired}), // add this line
      );
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

  Future<dynamic> postAsyncNormal(String endPoint, dynamic data,
      {required bool isTokenRequired}) async {
    try {
      printLog(
          "[EduKey Client_api][${DateTime.now().toString().split(' ').last}] postAsync START [endPoint:$endPoint] url:${dio.options.baseUrl}");
      Response response = await dio.post(
        "$endPoint?token=${LocalStorage().getToken()}",
        data: data,
      );
      return response;
    } on DioError catch (_) {
      final errorMessage = DioExceptions.fromDioError(_).toString();
      printLog(errorMessage);
      return errorMessage;
    }
  }

  void _performLogout(Dio dio) {
    LocalStorage().removeUser(); // remove token from local storage

    // back to login page without using context
    // check this https://stackoverflow.com/a/53397266/9101876
    getx.Get.to(() => AuthView());
  }

  /// return true if it is successfully regenerate the access token
  Future<bool> _regenerateAccessToken() async {
    try {
      var dio =
          Dio(); // should create new dio instance because the request interceptor is being locked

      // make request to server to get the new access token from server using refresh token
      final response = await dio.post(
        "https://dev17.toplinedev.com/theedukey/public/api/student-auth",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newUserWithToken = User.fromMap(response.data["user"]);
        // parse data based on your JSON structure
        LocalStorage().saveUser(newUserWithToken); // save to local storage
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // it means your refresh token no longer valid now, it may be revoked by the backend
        _performLogout(dio);
        return false;
      } else {
        return false;
      }
    } on DioError {
      return false;
    } catch (e) {
      return false;
    }
  }
}
