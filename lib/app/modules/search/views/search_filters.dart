import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/payment_method.dart';
import '../../../data/models/rate.dart';
import '../../../data/models/stage.dart';
import '../controllers/search_controller.dart';

class SearchFilters extends GetWidget<SearchController> {
  const SearchFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            //    flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  width: 0.1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),

              //  child:
// MultiSelectDialogField(
//                 items: controller.filterData.value.stages!.map((e) => MultiSelectItem(e, e.name??" ")).toList(),
//                 listType: MultiSelectListType.CHIP,
//                 onConfirm: (values) {
//                   controller.selectedStagesList.value.addAll(values)  ;
//                 },
//               ),

              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                // isDense: true,
                borderRadius: BorderRadius.circular(10),
                hint: Center(
                  child: Text(
                    controller.selectedStage.value.name ?? "stage".tr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                    maxLines: 1,
                  ),
                ),
                onChanged: (dynamic value) {},
                items: controller.filterData.value.stages
                    ?.map((Stage selectedType) {
                  return DropdownMenuItem(
                    value: selectedType,
                    child: Row(
                      children: <Widget>[
                        Obx(() => Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            focusColor: Theme.of(context).focusColor,
                            onChanged: (bool? value) {
                              if (selectedType.id == -1) {
                                controller.stagesCheckBoxes[controller
                                    .filterData.value.stages!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };
                                if (!value) {
                                  controller
                                      .unCheckAllSelectedStagesCheckBoxes();
                                } else {
                                  controller.checkAllSelectedStagesCheckBoxes();
                                }

                                controller.setSelectedStageCheckBox(
                                    index: controller.filterData.value.stages!
                                        .indexOf(selectedType),
                                    value: value,
                                    stage: selectedType);
                              } else {
                                controller.stagesCheckBoxes[controller
                                    .filterData.value.stages!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };
                                controller.setSelectedStageCheckBox(
                                    index: controller.filterData.value.stages!
                                        .indexOf(selectedType),
                                    value: value,
                                    stage: selectedType);
                              }
                            },
                            value: controller.stagesCheckBoxes[controller
                                .filterData.value.stages!
                                .indexOf(selectedType)][selectedType])),
                        Text(selectedType.name ?? " "),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            //     flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  width: 0.1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                //     isDense: true,
                borderRadius: BorderRadius.circular(10),
                hint: Center(
                  child: Text(
                    controller.selectedPaymentMethod.value.name ??
                        "payment_method".tr,
                    // maxLines: 2,
                    // softWrap: false,
                    // overflow: TextOverflow.fade,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                  ),
                ),
                onChanged: (dynamic value) {},
                items: controller.filterData.value.paymentMethods
                    ?.map((PaymentMethod selectedType) {
                  return DropdownMenuItem(
                    value: selectedType,
                    child: Row(
                      children: <Widget>[
                        Obx(() => Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            focusColor: Theme.of(context).focusColor,
                            onChanged: (bool? value) {
                              if (selectedType.id == -1) {
                                controller.paymentMethodsCheckBoxes[controller
                                    .filterData.value.paymentMethods!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };
                                if (!value) {
                                  controller
                                      .unCheckAllSelectedPaymentMethodsCheckBoxes();
                                } else {
                                  controller
                                      .checkAllSelectedPaymentMethodsCheckBoxes();
                                }
                                controller.setSelectedPaymentMethod(
                                    index: controller
                                        .filterData.value.paymentMethods!
                                        .indexOf(selectedType),
                                    value: value,
                                    paymentMethod: selectedType);
                              } else {
                                controller.paymentMethodsCheckBoxes[controller
                                    .filterData.value.paymentMethods!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };
                                controller.setSelectedPaymentMethod(
                                    index: controller
                                        .filterData.value.paymentMethods!
                                        .indexOf(selectedType),
                                    value: value,
                                    paymentMethod: selectedType);
                              }
                            },
                            value: controller.paymentMethodsCheckBoxes[
                                controller.filterData.value.paymentMethods!
                                    .indexOf(selectedType)][selectedType])),
                        Text(selectedType.name ?? " "),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            // flex: 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  width: 0.1,
                  color: Colors.grey,
                  style: BorderStyle.solid,
                ),
              ),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                //     isDense: true,
                //isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                hint: Center(
                  child: Text(
                    'rateings'.tr,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 8.sp),
                  ),
                ),
                onChanged: (dynamic value) {},
                items: controller.filterData.value.ratings
                    ?.map((Rate selectedType) {
                  return DropdownMenuItem(
                    value: selectedType,
                    child: Row(
                      children: <Widget>[
                        Obx(() => Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            focusColor: Theme.of(context).focusColor,
                            onChanged: (bool? value) {
                              if (selectedType.id == -1) {
                                controller.ratingsCheckBoxes[controller
                                    .filterData.value.ratings!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };

                                if (!value) {
                                  controller
                                      .unCheckAllSelectedRatingCheckBoxes();
                                } else {
                                  controller.checkAllSelectedRatingCheckBoxes();
                                }
                                controller.setSelectedRatingCheckBox(
                                    index: controller.filterData.value.ratings!
                                        .indexOf(selectedType),
                                    value: value,
                                    rateing: selectedType);
                              } else {
                                controller.ratingsCheckBoxes[controller
                                    .filterData.value.ratings!
                                    .indexOf(selectedType)] = {
                                  selectedType: !value!
                                };

                                controller.setSelectedRatingCheckBox(
                                    index: controller.filterData.value.ratings!
                                        .indexOf(selectedType),
                                    value: value,
                                    rateing: selectedType);
                              }
                            },
                            value: controller.ratingsCheckBoxes[controller
                                .filterData.value.ratings!
                                .indexOf(selectedType)][selectedType])),
                        selectedType.id == -1
                            ? Text(selectedType.name)
                            : RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: selectedType.id == -1
                                    ? 0
                                    : selectedType.id.toDouble(),
                                minRating: 1,
                                itemSize: 15,
                                //   textDirection: TextDirection.ltr,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 1,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
