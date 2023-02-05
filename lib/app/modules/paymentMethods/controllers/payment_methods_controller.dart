import 'package:get/get.dart';

import '../../../../helper.dart';
import '../../../data/models/order.dart';
import '../../../data/models/payment_method.dart';
import '../../../data/repositories/paymentMethods_repository.dart';

class PaymentMethodsController extends GetxController {
  final PaymentRepository repository;
  PaymentMethodsController({required this.repository});
  RxBool isLoading = true.obs;
  RxList<PaymentMethod> paymentMethodList = <PaymentMethod>[].obs;
  OrderDataData order = Get.arguments;
  @override
  void onInit() {
    getPaymentMethods();
    super.onInit();
  }

  void getPaymentMethods() async {
    dynamic response =
        await repository.getPaymentMethodsApi(orderId: order.orderNum);
    if (response is List<PaymentMethod>) {
      paymentMethodList.addAll(response);
    } else {
      Helper().showErrorToast("Something went wrong".tr);
    }
    isLoading.value = false;
  }

  void payNow(PaymentMethod paymentMethod) async {
    try {
      Get.toNamed(paymentMethod.method ?? "", arguments: {
        'order_id': order.orderNum,
      });
    } catch (e) {
      Helper().showErrorToast(e.toString());
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => WebView(response, "", onGet: (value) {
    //         if (value) {
    //           Get.back();

    //           Helper().showCustomDialog('success'.tr, 'payment_success'.tr,
    //               onCancel: () {}, onConfirm: () {
    //             Get.toNamed(Routes.home);
    //           });
    //           // Get.defaultDialog(
    //           //     title: 'success'.tr,
    //           //     middleText: 'payment_success'.tr,
    //           //     confirm: TextButton(
    //           //         onPressed: () {
    //           //           Get.toNamed(Routes.home);
    //           //         },
    //           //         child: Text('OK'.tr)));
    //         } else {
    //           Get.back();

    //           Helper().showCustomDialog('error'.tr, 'Something went wrong'.tr,
    //               onCancel: () {}, onConfirm: () {
    //             Get.back();
    //           });
    //         }
    //       }),
    //     ));
  }
}
