import 'package:get/get.dart';

import 'facility.dart';
import 'user.dart';

class RouteArgument {
  List<int>? stagesList;
  List<int>? ratingsList;
  List<int>? sonList;
  Prices? priceItem;
  String? keyword;
  dynamic param;
  int? schoolId;
  String? rate;
  List<int>? paymentMethodList;
  RxList<Facility> schoolsList = <Facility>[].obs;
  User? user;
  RouteArgument(
      {this.stagesList,
      this.keyword,
      this.param,
      this.schoolId,
      this.rate,
      this.paymentMethodList,
      this.ratingsList,
      this.sonList,
      this.priceItem,
      schoolsList,
      this.user});
}
