import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/modules/sons/controllers/sons_controller.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../../helper.dart';
import '../controllers/add_order_controller.dart';

class AddOrderView extends GetWidget<AddOrderController> {
  AddOrderView({Key? key}) : super(key: key);

  SonsController sonController = Get.find<SonsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "school_details".tr, isback: true),
      drawer: DrawerSideMenu(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("subscription_package".tr,
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: SizedBox(
                    width: Get.width,
                    child: DataTable(
                      dataRowHeight: 70,
                      //horizontalMargin: 80.0,
                      //  colu mnSpacing: 110,
                      border: TableBorder.all(
                          color: const Color.fromRGBO(238, 238, 238, 1)),
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'stage'.tr,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            controller.priceItem?.stageName ?? " ",
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('subscriptionTypr'.tr)),
                            DataCell(Text(
                                controller.priceItem?.paymentMethod ?? " ")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('from'.tr)),
                            DataCell(Text(controller.priceItem?.start ?? " ")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('to'.tr)),
                            DataCell(Text(controller.priceItem?.end ?? " ")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('theClass'.tr)),
                            DataCell(
                                Text(controller.priceItem?.className ?? " ")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('before_discount'.tr)),
                            DataCell(Text(
                                controller.priceItem?.priceBeforeDiscount ??
                                    " ")),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('after_discount'.tr)),
                            DataCell(Text(
                                controller.priceItem?.priceAfterDiscount ??
                                    " ".tr)),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('note'.tr)),
                            DataCell(SizedBox(
                              width: 170,
                              child: Text(
                                controller.priceItem?.note ?? " ",
                                softWrap: true,
                                textAlign: TextAlign.justify,
                                maxLines: 10,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text("subscriber_info".tr,
                    style: Theme.of(context).textTheme.displayLarge),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    color: Colors.white,
                    child: SizedBox(
                        width: Get.width,
                        child: DataTable(
                            //horizontalMargin: 80.0,
                            //  colu mnSpacing: 110,
                            border: TableBorder.all(
                                color: const Color.fromRGBO(238, 238, 238, 1)),
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'name'.tr,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  controller.currentUser?.name ?? " ",
                                ),
                              ),
                            ],
                            rows: <DataRow>[
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('id_number'.tr)),
                                  DataCell(Text(
                                      controller.currentUser?.idNumber ?? " ")),
                                ],
                              ),
                              DataRow(
                                cells: <DataCell>[
                                  DataCell(Text('mobile'.tr)),
                                  DataCell(Text(
                                      controller.currentUser?.phone ?? " ")),
                                ],
                              )
                            ]))),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: Get.width,
                  height: 60,
                  child: ElevatedButton(
                    child: Text(
                      "continue_with_main_account".tr,
                    ),
                    onPressed: () {
                      Helper().showCustomDialog(
                          "confirm".tr, "confirm_continue_with_main_account".tr,
                          onConfirm: () {
                        controller.addOrder();
                      }, onCancel: () {});
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("also_you_can".tr,
                      style: Theme.of(context).textTheme.displayLarge),
                ),
                const SizedBox(
                  height: 30,
                ),
                Obx(
                  () => SizedBox(
                    width: Get.width,
                    height: 60,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.5);
                            } else if (states
                                .contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context)
                                .focusColor; // Use the component's default.
                          },
                        ),
                      ),
                      onPressed: controller.selectedSon.value.id == null
                          ? null
                          : () => Get.defaultDialog(
                              title: "confirm".tr,
                              middleText: "confirm_continue_with_son".tr,
                              textConfirm: "confirm".tr,
                              textCancel: "cancel".tr,
                              onCancel: () {},
                              onConfirm: () {
                                addOrderCallBack();
                              }),
                      child: Text(
                        "continue_and_add_sons".tr,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                Obx(() => Center(
                      child: Container(
                        // width: 400,
                        // height: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            // dropdownDecoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(14),
                            //   border: Border.all(
                            //     width: 1,
                            //     color: Colors.grey[400] ?? Colors.black,
                            //   ),
                            // ),
                            isExpanded: true,
                            iconSize: 0.0,
                            icon: const Icon(Icons.keyboard_arrow_up_sharp),
                            style: const TextStyle(color: Colors.grey),
                            iconEnabledColor: Colors.grey,
                            hint: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                    width: 1,
                                    color:
                                        const Color.fromRGBO(238, 238, 238, 1)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 30.0, left: 30),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        controller.selectedSon.value.name!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onChanged: (dynamic value) {
                              controller.setSelectedSon(value);
                              controller.selectedSon.value = value;
                            },
                            items: controller.sonsList.map((selectedSon) {
                              return DropdownMenuItem(
                                value: selectedSon,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 50.0, left: 50),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.keyboard_arrow_up_sharp,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        selectedSon.name ?? " xcxc",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )),
                // const SizedBox(
                //   height: 300,
                // ),
              ],
            )),
      ),
    );
  }

  addOrderCallBack() {
    return controller.selectedSon.value.id == null
        ? null
        : sonController.isFamilyIdExits()
            ? controller.addOrderWithSon()
            : Helper().addFamilyAddDialog();
  }
}
