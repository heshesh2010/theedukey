import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../helper.dart';
import '../../../data/models/notification.dart';
import '../../../data/repo/notification_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class NotificationController extends GetxController {
  final userController = Get.find<AuthController>();

  var notificationsList = <Notification>[].obs;
  final PagingController<int, Notification> pagingOrdersController =
      PagingController(firstPageKey: 0);
  static const _pageNotificationSize = 15;
  List<Notification> newNotificationItems = [Notification()];

  @override
  void onInit() {
    pagingOrdersController.addPageRequestListener((pageKey) {
      //    _con.listenForOrders(pageKey);
      //  orderRepo.fetchPosts(orderRepo.nextUrl);
      _fetchNotificationPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchNotificationPage(pageKey) async {
    if (pageKey == 0) {
      newNotificationItems = await getNotifications();
    } else {
      newNotificationItems = await getNotifications(nextUrl: nextUrl);
    }

    // try {
      final isLastPage = newNotificationItems.length < _pageNotificationSize ||
          nextUrl == null;
      if (isLastPage) {
        pagingOrdersController.appendLastPage(newNotificationItems);
      } else {
        final nextPageKey = pageKey + newNotificationItems.length;
        pagingOrdersController.appendPage(newNotificationItems, nextPageKey);
      }
    } catch (error) {
      pagingOrdersController.error = error;
    }
  }

  Future<dynamic> getNotifications({nextUrl}) async {
    dynamic response = await getNotificationsApi(nextUrl: nextUrl);
    if (response is List<Notification>) {
      notificationsList.addAll(response);
      return notificationsList;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}
