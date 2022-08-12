import 'package:theedukey/app/data/models/school.dart';

class RouteArgument {
  List<int>? stagesList;
  List<int>? ratingsList;

  List<int>? sonList;

  String? keyword;
  dynamic param;
  School? school;
  String? rate;
  List<int>? paymentMethodList;
  RouteArgument(
      {this.stagesList,
      this.keyword,
      this.param,
      this.school,
      this.rate,
      this.paymentMethodList,
      this.ratingsList,
      this.sonList});
}
