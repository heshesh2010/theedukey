import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';

import '../../core/utils/local_storage.dart';
import '../models/facility.dart';
import '../models/filter_data.dart';
import '../models/route_argument.dart';
import '../models/school.dart';
import '../provider/api_helper.dart';
import '../service/locator.dart';
import '../service/search_model.dart';

class SearchRepository {
  final ApiClient apiClient;
  String? nextUrl;

  SearchRepository({required this.apiClient});
  var loadCompleted = false;

  Future<dynamic> getFilterDataApi() async {
    dio.Response? response = await apiClient.getAsync(
        "get-all-filter-data?lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
        isTokenRequired: false);
    if (response?.statusCode == 200) {
      return FilterData.fromJson(response?.data).data;
    } else {
      return response;
    }
  }

  Future<dynamic> getSuggestionsApi(pattern) async {
    dio.Response? response = await apiClient.getAsync(
        "search?keyword=$pattern&lang=${LocalStorage().getlanguageSelected() ?? "ar"}");
    if (response?.statusCode == 200) {
      return School.fromJson(response?.data).data?.results ?? response;
    } else {
      return response;
    }
  }

  //getSelctedStageId();

  Future<dynamic> getSearchResultsApi() async {
    RouteArgument? routeArgument = getIt<SearchModel>().routeArgument;

    var stagesIds = (routeArgument?.stagesList ?? "")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');
    var paymentMethodsIds = (routeArgument?.paymentMethodList ?? "")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');

    var rateingsIds = (routeArgument?.ratingsList ?? "")
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');

    if (kDebugMode) {
      print("$stagesIds//$paymentMethodsIds//$rateingsIds");
    }
    dio.Response? response = await apiClient.getAsync(
        "search?keyword=${routeArgument?.keyword}&stage=$stagesIds&payment_method=$paymentMethodsIds&rate=$rateingsIds&lang=${LocalStorage().getlanguageSelected() ?? "ar"}");
    if (response?.statusCode == 200) {
      List<Facility> list = <Facility>[];

      for (var element in (response?.data["facilities"] as List)) {
        list.add(Facility(school: SchoolData.fromJson(element)));
      }

      return list;
    } else {
      return response;
    }
    // dio.Response? response = await apiClient.getAsync(
    //     nextUrl ??
    //         "search?keyword=$pattern&lang=${LocalStorage().getlanguageSelected() ?? "ar"}",
    //     isTokenRequired: false);
    // if (response?.statusCode == 200) {
    //   School school = School.fromJson(response?.data);
    //   if (school.data?.nextPageUrl != null) {
    //     nextUrl =
    //         "${(school.data?.nextPageUrl)!}&lang=${LocalStorage().getlanguageSelected() ?? "ar"}";
    //   }
    //   if (school.data?.data != null) {
    //     return school.data?.data;
    //   } else {
    //     return [];
    //   }
    // } else {
    //   return response;
    // }
  }
}
