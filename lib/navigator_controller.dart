import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/home/views/home_view.dart';

import 'app/modules/notifications/views/notifications_view.dart';

class NavigatorController extends GetxController {
  var tabIndex = 0.obs;

  int currentIndex = 0;
  late RxList<Widget> children;

  @override
  void onInit() {
    currentIndex = 0;
    children = [
      const NotificationsView(),
      HomeView(),
      HomeView(),
    ].obs;
    super.onInit();
  }

  changePage(int index) {
    tabIndex(index);
    print('Index: $tabIndex');
  }
}
