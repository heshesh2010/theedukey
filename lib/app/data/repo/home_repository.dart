import '../models/stage.dart';
import 'api_helper.dart';
import 'package:dio/dio.dart';

Future<dynamic> getStagesApi() async {
  // TODO: implement lang from storage
  Response? response =
      await ApiHelper().getAsyncNoUserType("get-all-filter-data?lang=ar");
  if (response?.statusCode == 200) {
    return (response?.data["data"]["stages"] as List)
        .map((p) => Stage.fromMap(p))
        .toList();

//    return City.fromMap(response?.data["data"]);
  } else {
    return response;
  }
}
