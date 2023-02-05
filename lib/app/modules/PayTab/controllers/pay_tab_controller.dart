import 'package:get/get.dart';

import '../../../../elements/bottom_navigation_bar.dart';
import '../../../../helper.dart';
import '../../../../navigator_controller.dart';
import '../../../data/repositories/paymentMethods_repository.dart';

class PayTabController extends GetxController {
  final PaymentRepository _paymentRepository;
  final url = "".obs;
  final progress = 0.0.obs;
  int? orderId;
  final isLoading = true.obs;

  PayTabController(this._paymentRepository);

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments['order_id'];

    getUrl();
  }

  void getUrl() async {
    try {
      url.value = await _paymentRepository.getPaymentUrlApi(
          orderId: orderId, paymentMethodName: "TapPayment");
    } catch (e) {
      Helper().showErrorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showConfirmationIfSuccess() {
    if (url.value.contains("<html><head></head><body>true</body></html>")) {
      Helper().showCustomAlertDialog('success'.tr, 'payment_success'.tr,
          onConfirm: () {
        Get.to(
          () => const NavigatorPage(),
        );
        Get.find<NavigatorController>().changePage(1);
      });
    } else if (url.value
        .contains("<html><head></head><body>false</body></html>")) {
      Helper().showCustomDialog('error'.tr, 'Something went wrong'.tr,
          onCancel: () {}, onConfirm: () {
        Get.back();
      });
    }
  }
}
