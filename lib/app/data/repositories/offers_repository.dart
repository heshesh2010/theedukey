import '../models/offer.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart' as Dio;

var nextUrl;
var loadCompleted = false;
Future<dynamic> getOffersApi({nextUrl}) async {
  Dio.Response? response = await ApiHelper().getAsync(nextUrl ?? 'offers');
  if (response?.statusCode == 200) {
    Offer _offer = Offer.fromJson(response?.data);
    if (_offer.nextPageUrl != null) {
      nextUrl = _offer.nextPageUrl;
    }
    return _offer.data;
  } else {
    return response;
  }
}
