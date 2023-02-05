import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/empty_results.dart';
import '../../../../elements/no_other_results.dart';
import '../../../../elements/permission_dcenied_widget.dart';
import '../../../../elements/topbar.dart';
import '../../../core/utils/first_page_error_indicator.dart';
import '../../../data/models/notification.dart' as model;
import '../../../services/auth_service.dart';
import '../controllers/notifications_controller.dart';
import 'notification_item.dart';

class NotificationsView extends GetWidget<NotificationController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "notifications".tr),
      drawer: DrawerSideMenu(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10.0, top: 10, bottom: 15),
        child: !Get.find<AuthService>().isAuth
            ? const PermissionDeniedWidget()
            : GetBuilder<NotificationController>(
                builder: (c) =>
                    PagedListView<int, model.NotificationData>.separated(
                  scrollDirection: Axis.vertical,
                  pagingController: controller.pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<model.NotificationData>(
                    itemBuilder: (context, item, index) => GestureDetector(
                      child: NotificationItem(
                        notification: item,
                      ),
                    ),
                    //  firstPageProgressIndicatorBuilder: (_)=> ShimmerHelper(type: Type.complex),
                    noItemsFoundIndicatorBuilder: (_) => const EmptyResults(),
                    firstPageErrorIndicatorBuilder: (_) =>
                        FirstPageErrorIndicator(
                      error: controller.pagingController.error,
                      onTryAgain: () => controller.pagingController.refresh(),
                    ),
                    noMoreItemsIndicatorBuilder: (_) => const NoOtherResults(),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
