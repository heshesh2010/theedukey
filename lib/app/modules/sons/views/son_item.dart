import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:theedukey/app/data/models/son.dart';
import 'package:theedukey/app/modules/sons/controllers/sons_controller.dart';

import '../../../routes/app_pages.dart';

class SonItem extends StatelessWidget {
  const SonItem({Key? key, required this.son}) : super(key: key);
  final SonDataData son;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SonsController>(builder: (controller) {
      // Some code that use viewModel
      return Column(
        children: [
          Text('manage_son_description'.tr,
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color.fromRGBO(238, 238, 238, 1)),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
                              //width: Get.width,
                              height: Get.height / 3.5,
                              imageUrl: son.image ?? " ",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) =>
                                  const Center(child: Icon(Icons.error)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
                          son.name ?? " ",
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('id_number'.tr)),
                          DataCell(Text(son.idNumber.toString())),
                        ],
                      ),
                      DataRow(
                        cells: <DataCell>[
                          DataCell(Text('birth_date'.tr)),
                          DataCell(Text(son.birthDate!)),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "id_image".tr,
                                content: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    //width: Get.width,
                                    height: Get.height / 3.5,
                                    imageUrl: son.idImage ?? " ",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person),
                            label: Text("id_image".tr)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: Get.width,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              Get.defaultDialog(
                                title: "certificate_image".tr,
                                content: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: CachedNetworkImage(
                                    //width: Get.width,
                                    height: Get.height / 3.5,
                                    imageUrl: son.certificateImage ?? " ",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress)),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.document_scanner),
                            label: Text("certificate_image".tr)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.width / 3,
                  height: 60,
                  child: ElevatedButton(
                    child: Text(
                      "edit".tr,
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.editSon, arguments: son);
                    },
                  ),
                ),
                SizedBox(
                    width: Get.width / 3,
                    height: 60,
                    child: RoundedLoadingButton(
                      controller: controller.submitButtonController,
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "delete".tr,
                      ),
                      onPressed: () {
                        controller.deleteSon(son);
                      },
                    )),
              ],
            ),
          ),
        ],
      );
    });
  }
}
