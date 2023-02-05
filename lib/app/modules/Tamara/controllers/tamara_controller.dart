import 'package:get/get.dart';

import '../../../../elements/bottom_navigation_bar.dart';
import '../../../../helper.dart';
import '../../../../navigator_controller.dart';
import '../../../data/repositories/paymentMethods_repository.dart';

class TamaraController extends GetxController {
  final PaymentRepository paymentRepository;
  final isLoading = true.obs;

  TamaraController({required this.paymentRepository});
  final url = "".obs;
  final progress = 0.0.obs;
  int? orderId;
  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments['order_id'];

    getUrl();
  }

  void getUrl() async {
    try {
      url.value = await paymentRepository.getPaymentUrlApi(
          orderId: orderId, paymentMethodName: "Tamara");
    } catch (e) {
      Helper().showErrorToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  onPaymentSuccess() async {
    try {
      isLoading.value = true;

      await paymentRepository.setPaymentSuccessApi(orderId: orderId);
    } catch (e) {
      Helper().showErrorToast(e.toString());
    } finally {
      Helper().showCustomAlertDialog('success'.tr, 'payment_success'.tr,
          onConfirm: () {
        Get.to(
          () => const NavigatorPage(),
        );
        Get.find<NavigatorController>().changePage(1);
      });
      isLoading.value = false;
    }
  }

  onPaymentFailed() async {
    try {
      isLoading.value = true;

      await paymentRepository.setPaymentFailedApi(orderId: orderId);
    } catch (e) {
      Helper().showErrorToast(e.toString());
    } finally {
      Helper().showCustomAlertDialog('error'.tr, 'payment_failed'.tr,
          onConfirm: () {
        Get.to(
          () => const NavigatorPage(),
        );
        Get.find<NavigatorController>().changePage(1);
      });
      isLoading.value = false;
    }
  }

  onPaymentCanceled() async {
    try {
      isLoading.value = true;

      await paymentRepository.setPaymentCanceledApi(orderId: orderId);
    } catch (e) {
      Helper().showErrorToast(e.toString());
    } finally {
      Helper().showCustomAlertDialog('error'.tr, 'payment_canceled'.tr,
          onConfirm: () {
        Get.to(
          () => const NavigatorPage(),
        );
        Get.find<NavigatorController>().changePage(1);
      });
      isLoading.value = false;
    }
  }
}
