import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/elements/notification_item.dart';
import 'package:theedukey/elements/topbar.dart';
import 'package:theedukey/app/data/models/notification.dart' as model;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../elements/PermissionDeniedWidget.dart';
import '../../../../elements/drawer.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getTopBar(context),
        drawer: const DrawerSideMenu(),
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 10, bottom: 15),
          child: controller.userController.currentUser.value?.token == null
              ? const PermissionDeniedWidget()
              : GetBuilder<NotificationController>(
                  builder: (_c) =>
                      PagedListView<int, model.Notification>.separated(
                    scrollDirection: Axis.vertical,
                    pagingController: controller.pagingOrdersController,
                    builderDelegate:
                        PagedChildBuilderDelegate<model.Notification>(
                      itemBuilder: (context, item, index) => GestureDetector(
                        child: NotificationItem(
                          notification: item,
                        ),
                      ),
                      //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                      //     noItemsFoundIndicatorBuilder: (_)=> EmptyOrdersWidget(),
                      noMoreItemsIndicatorBuilder: (_) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text("no_other_notification".tr),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
        ));
  }
}
