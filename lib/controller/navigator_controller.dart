import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:theedukey/screens/home_screen.dart';
import 'package:theedukey/screens/notification.dart';

class NavigatorController extends GetxController {
  var tabIndex = 0.obs;

  int currentIndex = 0;
  late RxList<Widget> children;

  @override
  void onInit() {
    currentIndex = 0;
    children = [
      const NotificationsScreen(),
      const HomeScreen(),
      const NotificationsScreen(),
    ].obs;
    super.onInit();
  }

  changePage(int index) {
    tabIndex(index);
    print('Index: $tabIndex');
  }
}
