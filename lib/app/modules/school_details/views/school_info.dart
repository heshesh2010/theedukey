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
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.0),
                        child: ImageTools.image(
                          fit: BoxFit.contain,
                          url: controller.facility.value.school?.logo ?? "",
                          height: 60,
                          width: 60,
                        )),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 5,
                              ),
                              Text(controller.facility.value.school?.name ??
                                  "0"),
                            ],
                          ),
                          Flexible(
                            //   fit: FlexFit.loose,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).focusColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    controller.facility.value.school?.address ??
                                        " ",
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
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
                              Text(controller.facility.value.school?.rate ??
                                  "0"),
                            ],
                          ),
                        ]),
                  ),
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
