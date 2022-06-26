import '../provider/api_helper.dart';
import 'package:dio/dio.dart';

class ContactUsRepository {
  final ApiClient apiClient;

  ContactUsRepository({required this.apiClient});

  Future<dynamic> postContactUsApi(
      String name, String email, String subject, String message) async {
    var data = {
      "name": name,
      "email": email,
      "subject": subject,
      "message": message
    };
    Response? response = await apiClient.postAsyncNormal("send-message", data,
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return response?.data["data"]["message"];

//    return City.fromMap(response?.data["data"]);
    } else {
      return response;
    }
  }
}
