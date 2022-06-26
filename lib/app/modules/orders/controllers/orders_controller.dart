import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../constants/general.dart';
import '../../../../helper.dart';
import '../../../data/models/order.dart';
import '../../../data/repositories/orders_repository.dart';

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
      newOrdersItems = await getOrders();

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

  Future<dynamic> getOrders() async {
    dynamic response = await repository.getOrdersApi();
    if (response is List<OrderDataData>) {
      return response;
    } else {
      Helper().showErrorToast("حدث خطأ بالاتصال حاول لاحقاً");
    }
  }
}
