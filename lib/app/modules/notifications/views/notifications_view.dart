import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/notifications/views/notification_item.dart';
import 'package:theedukey/elements/topbar.dart';
import 'package:theedukey/app/data/models/notification.dart' as model;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../elements/empty_results.dart';
import '../../../../elements/no_other_results.dart';
import '../../../core/utils/first_page_error_indicator.dart';
import '../../../core/utils/local_storage.dart';
import '../../../../elements/permission_dcenied_widget.dart';
import '../../../../elements/drawer.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationController> {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "notifications".tr),
      drawer: const DrawerSideMenu(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10.0, top: 10, bottom: 15),
        child: LocalStorage().getUser()?.token == null
            ? const PermissionDeniedWidget()
            : GetBuilder<NotificationController>(
                builder: (c) =>
                    PagedListView<int, model.NotificationData>.separated(
                  scrollDirection: Axis.vertical,
                  pagingController: controller().pagingController,
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
                      error: controller().pagingController.error,
                      onTryAgain: () => controller().pagingController.refresh(),
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
