import 'package:theedukey/app/data/models/school.dart';

import 'payment_method.dart';

class RouteArgument {
  List<int>? stagesList;
  String? keyword;
  dynamic param;
  School? school;
  String? rate;
  PaymentMethod? paymentMethod;
  RouteArgument(
      {this.stagesList,
      this.keyword,
      this.param,
      this.school,
      this.rate,
      this.paymentMethod});
}
