import '../../core/utils/local_storage.dart';
import '../models/offer.dart';
import '../provider/api_helper.dart';
import 'package:dio/dio.dart' as dio;

class OffersRepository {
  final ApiClient apiClient;

  OffersRepository({required this.apiClient});
  String? nextUrl;
  var loadCompleted = false;
  Future<dynamic> getOffersApi({nextUrl}) async {
    dio.Response? response = await apiClient.getAsync(nextUrl ??
        'offers?lang=${LocalStorage().getlanguageSelected() ?? "ar"}');
    if (response?.statusCode == 200) {
      Offer offer = Offer.fromJson(response?.data);
      if (offer.data?.nextPageUrl != null) {
        nextUrl = offer.data?.nextPageUrl +
            "&lang=${LocalStorage().getlanguageSelected() ?? "ar"}";
      }
      if (offer.data?.data != null) {
        return offer.data?.data;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }
}
