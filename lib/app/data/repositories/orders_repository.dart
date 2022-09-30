import '../../core/utils/local_storage.dart';
import '../models/order.dart';
import '../provider/api_helper.dart';
import 'package:dio/dio.dart' as dio;

class OrdersRepository {
  final ApiClient apiClient;
  String? nextUrl;
  OrdersRepository({required this.apiClient});

  var loadCompleted = false;
  Future<dynamic> getOrdersApi(pageKey) async {
    dio.Response? response = await apiClient.getAsync(
        pageKey == 0
            ? "student-auth/orders?lang=${LocalStorage().getlanguageSelected() ?? "ar"}"
            : nextUrl ??
                'student-auth/orders?lang=${LocalStorage().getlanguageSelected() ?? "ar"}',
        isTokenRequired: true);

    if (response?.statusCode == 200) {
      Order order = Order.fromJson(response?.data);
      if (order.data?.nextPageUrl != null) {
        nextUrl =
            "${(order.data?.nextPageUrl)!}&lang=${LocalStorage().getlanguageSelected() ?? "ar"}";
      }
      if (order.data?.data != null) {
        return order.data?.data;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }
}
