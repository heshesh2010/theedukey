import '../../core/utils/local_storage.dart';
import '../models/favorite.dart';
import '../provider/api_helper.dart';
import 'package:dio/dio.dart' as dio;

class FavoriteRepository {
  final ApiClient apiClient;
  String? nextUrl;
  FavoriteRepository({required this.apiClient});

  var loadCompleted = false;
  Future<dynamic> getFavoritesApi() async {
    dio.Response? response = await apiClient.getAsync(
        nextUrl ??
            'student-auth/favorites?lang=${LocalStorage().getlanguageSelected() ?? "ar"}',
        isTokenRequired: true);

    if (response?.statusCode == 200) {
      Favorite favorite = Favorite.fromJson(response?.data);
      if (favorite.data?.nextPageUrl != null) {
        nextUrl =
            "${(favorite.data?.nextPageUrl)!}&lang=${LocalStorage().getlanguageSelected() ?? "ar"}";
      }
      if (favorite.data?.data != null) {
        return favorite.data?.data;
      } else {
        return [];
      }
    } else {
      return response;
    }
  }
}
