import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/orders/controllers/orders_controller.dart';

import '../../../../helper.dart';
import '../../../data/models/facility.dart';
import '../../../data/models/route_argument.dart';
import '../../../data/models/son.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/add_order_repository.dart';
import '../../auth/controllers/auth_controller.dart';

class AddOrderController extends GetxController {
  final AddOrderRepository repository;
  AddOrderController({required this.repository});

  late Rx<SonDataData> selectedSon =
      SonDataData(name: "Please_select_the_child".tr).obs;

  Prices? priceItem = (Get.arguments as RouteArgument).priceItem;
  var sonsList = [].obs;
  User? currentUser;
  @override
  void onInit() {
    currentUser = Get.find<AuthController>().currentUser.value;
    getSons();
    super.onInit();
  }

  addOrder() async {
    dynamic response = await repository.addOrderApi(
      priceId: priceItem!.id.toString(),
      facilityId: priceItem!.facilityId.toString(),
    );

    if (response == true) {
      Get.find<OrdersController>().refreshOrders();
      Get.defaultDialog(
          title: "success".tr,
          middleText: "Order_added_successfully".tr,
          confirm: Text("OK".tr),
          onConfirm: () {});
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  addOrderWithSon() async {
    dynamic response = await repository.addOrderWithSonApi(
      priceId: priceItem!.id.toString(),
      childId: selectedSon.value.id.toString(),
      facilityId: priceItem!.facilityId.toString(),
    );

    if (response == true) {
      Get.find<OrdersController>().refreshOrders();

      Get.defaultDialog(
          title: "success".tr,
          middleText: "Order_added_successfully".tr,
          confirm: Text("OK".tr),
          onConfirm: () {});
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  Future<dynamic> getSons() async {
    dynamic response = await repository.getSonsApi();
    if (response is List<SonDataData>) {
      sonsList.addAll(response);
      return sonsList;
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
  }

  void setSelectedSon(value) {
    selectedSon.value = value!;
    // getIt<SearchModel>().setSonList([value]);
  }

  SonDataData getSelectedSon() {
    return selectedSon.value;
  }
}
