import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../../../data/models/son.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_order_controller.dart';

class AddOrderView extends GetWidget<AddOrderController> {
  const AddOrderView({Key? key}) : super(key: key);
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
              Text("باقة الاشتراك",
                  style: Theme.of(context).textTheme.headline1),
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
                          'stage'.tr,
                        ),
                      ),
                      const DataColumn(
                        label: Text(
                          "تمهيدي",
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('subscriptionTypr'.tr)),
                          DataCell(Text('عام دراسي'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('from'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('to'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('theClass'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('before_discount'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('after_discount'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('note'.tr)),
                          DataCell(Text('من'.tr)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text("بيانات المشترك",
                  style: Theme.of(context).textTheme.headline1),
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
                                'stage'.tr,
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                "تمهيدي",
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('subscriptionTypr'.tr)),
                                DataCell(Text('عام دراسي'.tr)),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('from'.tr)),
                                DataCell(Text('من'.tr)),
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
                    "اتمام الطلب بالحساب الاساسي".tr,
                  ),
                  onPressed: () {
                    //TODO: updatePrictTO dependency injector
                    Get.toNamed(
                      Routes.ADD_ORDER,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text("او يمكنك ايضا",
                    style: Theme.of(context).textTheme.headline1),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: Get.width,
                height: 60,
                child: ElevatedButton(
                  child: Text(
                    "اتمام الطلب بالحساب الاساسي".tr,
                  ),
                  onPressed: () {
                    //TODO: updatePrictTO dependency injector
                    Get.toNamed(
                      Routes.ADD_ORDER,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Center(
                    child: Container(
                      // width: 400,
                      height: 55,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey[400] ?? Colors.black,
                            ),
                          ),
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
                              padding:
                                  const EdgeInsets.only(right: 30.0, left: 30),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      controller.selectedSon.value.name!,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
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
                          items: controller.sonsList
                              .map((SonDataData selectedSon) {
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
                                      selectedSon.name!,
                                      style:
                                          Theme.of(context).textTheme.subtitle1,
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
            ],
          ),
        ),
      ),
    );
  }
}
