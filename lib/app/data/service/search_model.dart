import '../models/route_argument.dart';

class SearchModel {
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

  void setPaymentMethod(value) {
    routeArgument?.paymentMethod = value;
  }

  void clear() {
    routeArgument = null;
  }
}
