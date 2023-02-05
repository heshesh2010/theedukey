import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../controllers/payment_methods_controller.dart';

class PaymentMethodsView extends GetWidget<PaymentMethodsController> {
  const PaymentMethodsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getTopBar(context, title: "payment_methods".tr, isback: true),
        drawer: DrawerSideMenu(),
        body: Center(
          child: Obx(
            () => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.payment),
                          title: Text("choose_payment_method".tr,
                              style: Get.textTheme.subtitle2),
                        ),
                        Column(
                          children: List.generate(
                              controller.paymentMethodList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Card(
                                child: Row(children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: Image.network(
                                        controller
                                            .paymentMethodList[index].image!,
                                        width: 50,
                                        height: 50,
                                      ),
                                      title: Text(controller
                                              .paymentMethodList[index].name ??
                                          ""),
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      child: Text("pay".tr),
                                      onPressed: () {
                                        controller.payNow(
                                          controller.paymentMethodList[index],
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                              )

                                  //   ElevatedButton.icon(
                                  //     icon: const Icon(Icons.payment),
                                  //     label: Text(
                                  //         controller.paymentMethodList[index].name ??
                                  //             ""),
                                  //     onPressed: () {
                                  //       controller.payNow(
                                  //           controller.paymentMethodList[index],
                                  //           context);
                                  //     },
                                  //   ),
                                  // )

                                  //  ElevatedButton(
                                  //   style: ElevatedButton.styleFrom(
                                  //     backgroundColor: Colors.blue,
                                  //     shape: const RoundedRectangleBorder(
                                  //       borderRadius:
                                  //           BorderRadius.all(Radius.circular(10)),
                                  //     ),
                                  //   ),
                                  //   child: Text(
                                  //       controller.paymentMethodList[index].name ?? ""),
                                  //   onPressed: () {
                                  //     controller.payNow(
                                  //         controller.paymentMethodList[index], context);
                                  //   },
                                  // ),
                                  ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),

            // ListView.builder(
            //     itemCount: controller.paymentMethodList.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(controller.paymentMethodList[index].name!),
            //         subtitle:
            //             Text(controller.paymentMethodList[index].image!),
            //       );
            //     }),
          ),
        ));
  }
}
