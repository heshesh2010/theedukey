import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart' as getx;

import '../../modules/home/controllers/home_controller.dart';
import '../../modules/notifications/controllers/notifications_controller.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    StreamSubscription? streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription =
        connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        return;
      }
      streamSubscription?.cancel();
      streamSubscription = null;
      responseCompleter.complete(await dio
          .request(requestOptions.baseUrl + requestOptions.path,
              data: requestOptions.data,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
                contentType: requestOptions.contentType,
                responseType: requestOptions.responseType,
              ))
          .then((response) {
        final userController = getx.Get.find<NotificationController>();
        final homeController = getx.Get.find<HomeController>();
        if (requestOptions.path.contains("get-all-filter-data")) {
          homeController.onInit();
        } else if (requestOptions.path.contains("notifications")) {
          userController.pagingController.notifyListeners();
          //userController.pagingOrdersController.notifyListeners();
        }
        return response;
      }));
    });
    return responseCompleter.future;
  }
}
