import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import '../navigator_controller.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;

  @override
  NavigatorPageState createState() => NavigatorPageState();
}

class NavigatorPageState extends State<NavigatorPage> {
  NavigatorController controller = Get.put(NavigatorController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.changePage(widget.tabIndex);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() => IndexedStack(
            index: controller.tabIndex.value,
            children: controller.children,
          )),
      bottomNavigationBar: Obx(() => CustomNavigationBar(
            onTap: controller.changePage,
            currentIndex: controller.tabIndex.value,
            iconSize: 35,
            borderRadius: const Radius.circular(30),
            items: [
              CustomNavigationBarItem(
                icon: const Icon(Icons.description),
              ),
              CustomNavigationBarItem(
                icon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [
                          Color(0xFF076996),
                          Color(0xFF19BAB2),
                        ],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    color: Theme.of(context).focusColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.4),
                          blurRadius: 40,
                          offset: const Offset(0, 15)),
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
              CustomNavigationBarItem(
                icon: const Icon(Icons.notifications),
              ),
            ],
          )),
    );
  }
}
