import '../models/route_argument.dart';

class SearchModel {
  SearchModel({this.routeArgument});
  RouteArgument? routeArgument;

  void search(routeArgument) {
    this.routeArgument = routeArgument;
  }

  void setKeyword(value) {
    routeArgument?.keyword = value;
  }

  void setStageList(value) {
    routeArgument?.stagesList = value;
  }

  void setPaymentMethodList(value) {
    routeArgument?.paymentMethodList = value;
  }

  void setRatingList(value) {
    routeArgument?.ratingsList = value;
  }

  void setSonList(value) {
    routeArgument?.sonList = value;
  }

  void setSchoolsList(value) {
    routeArgument?.schoolsList = value;
  }

  void clear() {
    routeArgument = null;
  }
}
