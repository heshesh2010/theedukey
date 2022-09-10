import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/image_tools.dart';
import '../controllers/school_details_controller.dart';

class SchoolInfo extends GetWidget<SchoolDetailsController> {
  const SchoolInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(80.0),
                      child: ImageTools.image(
                        fit: BoxFit.fitHeight,
                        url: controller.facility.value.school?.logo ?? "",
                        height: 60,
                        width: 60,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Text(controller.facility.value.school?.name ?? "0"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).focusColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              controller.facility.value.school?.address ?? " ",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color.fromRGBO(255, 191, 14, 1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(controller.facility.value.school?.rate ?? "0"),
                          ],
                        ),
                      ]),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              controller.facility.value.school?.about ?? " ",
              textAlign: TextAlign.start,
              //    style: const TextStyle(),
            ),
          ],
        ));
  }
}
