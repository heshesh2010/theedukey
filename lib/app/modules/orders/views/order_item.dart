import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../elements/webView.dart';
import '../../../data/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final OrderDataData order;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.09),
            spreadRadius: 0.5,
            blurRadius: 20,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30, left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('orderNum'.tr,
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('serviceProvider'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('orderStatus'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('serviceName'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('stage'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('theClass'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('subscriptionTypr'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('priceAfterDiscount'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('from'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('to'.tr,
                          style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${order.orderNum}',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.serviceProvider}',
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(getOrderStatus(order.orderStatus),
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.serviceName}',
                            maxLines: 1,
                            //   softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.stage}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.theClass}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.subscriptionTypr}',
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.priceAfterDiscount}${'currency'.tr}',
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.from}',
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${order.to}',
                            style: Theme.of(context).textTheme.bodyText2),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            order.paymentUrl != null
                ? SizedBox(
                    width: Get.width / 1.5,
                    height: 60,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.pin_drop),
                      label: Text('pay'.tr),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebView(
                                  order.paymentUrl ??
                                      "https://checkout.payments.tap.company?mode=page&token=6300ce0023e1b600fd3a4213",
                                  "دفع الكتروني", onGet: (value) {
                                if (value) {
                                  Get.back();

                                  Get.defaultDialog(
                                      title: 'success'.tr,
                                      middleText: 'payment_success'.tr,
                                      confirm: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('OK'.tr)));
                                } else {
                                  Get.back();

                                  Get.defaultDialog(
                                      title: 'error'.tr,
                                      middleText: 'Something went wrong'.tr,
                                      confirm: TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('OK'.tr)));
                                }
                              }),
                            ));
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  String getOrderStatus(String? orderStatus) {
    switch (orderStatus) {
      case "is_paid":
        return "is_paid".tr;

      case "new":
        return "new".tr;

      case "accepted":
        return "accepted".tr;

      case "under_revision":
        return "under_revision".tr;

      case "rejected":
        return "rejected".tr;

      default:
        return orderStatus ?? "";
    }
  }
}
