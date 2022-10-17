import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../constants/general.dart';
import '../../../../elements/bottom_navigation_bar.dart';
import '../../../../helper.dart';
import '../../../../navigator_controller.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/orders_repository.dart';
import '../../home/bindings/home_binding.dart';

class OrdersController extends GetxController {
  final OrdersRepository repository;
  OrdersController({required this.repository});

  var OrdersList = <OrderDataData>[].obs;
  final PagingController<int, OrderDataData> pagingController =
      PagingController(firstPageKey: 0);
  List<OrderDataData> newOrdersItems = [OrderDataData()];

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchOrdersPage(pageKey);
    });
    super.onInit();
  }

  Future<void> _fetchOrdersPage(pageKey) async {
    try {
      newOrdersItems = await getOrders(pageKey);

      final isLastPage = newOrdersItems.length < apiPageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newOrdersItems);
      } else {
        final nextPageKey = pageKey + newOrdersItems.length;
        pagingController.appendPage(newOrdersItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<dynamic> getOrders(pageKey) async {
    dynamic response = await repository.getOrdersApi(pageKey);
    if (response is List<OrderDataData>) {
      return response;
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  void refreshOrders() {
    getOrders(0);
    pagingController.refresh();
    Get.to(() => const NavigatorPage(), binding: HomeBinding());
    Get.find<NavigatorController>().changePage(0);
  }
}
