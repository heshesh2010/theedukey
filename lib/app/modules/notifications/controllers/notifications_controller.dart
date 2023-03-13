import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:theedukey/app/services/auth_service.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/notification.dart';
import '../../../data/repositories/notification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository repository;
  NotificationController({required this.repository});

  final PagingController<int, NotificationData> pagingController =
      PagingController(firstPageKey: 0);
  List<NotificationData> newNotificationItems = [NotificationData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchNotificationPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchNotificationPage(pageKey) async {
    if (Get.find<AuthService>().isAuth) {
      newNotificationItems = await getNotifications();
    }

    try {
      final isLastPage = newNotificationItems.length < apiPageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newNotificationItems);
      } else {
        final nextPageKey = pageKey + newNotificationItems.length;
        pagingController.appendPage(newNotificationItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<dynamic> getNotifications({nextUrl}) async {
    dynamic response = await repository.getNotificationsApi();
    if (response is List<NotificationData>) {
      return (response);
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }
}
