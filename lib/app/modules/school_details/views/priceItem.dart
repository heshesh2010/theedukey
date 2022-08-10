import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/data/models/facility.dart';

import '../../../../config/app_config.dart';

class PriceItem extends StatelessWidget {
  PriceItem({Key? key, required this.price}) : super(key: key);
  Prices price;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0, bottom: 10),
      child: Container(
        //height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(21, 35, 35, 35),
              spreadRadius: 0.9,
              blurRadius: 20,
              offset: Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widgetTextKey('stage'.tr, context),
                      widgetTextKey('subscriptionTypr'.tr, context),
                      widgetTextKey('from'.tr, context),
                      widgetTextKey('to'.tr, context),
                      widgetTextKey('theClass'.tr, context),
                      widgetTextKey('serviceProvider'.tr, context),
                      widgetTextKey('priceAfterDiscount'.tr, context),
                      widgetTextKey('note'.tr, context),
                    ],
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30, top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widgetTextValue('${price.stageName}', context),
                        widgetTextValue('${price.paymentMethod}', context),
                        widgetTextValue('${price.start}', context),
                        widgetTextValue('${price.end}', context),
                        widgetTextValue('${price.className}', context),
                        widgetTextValue(
                            '${price.priceBeforeDiscount}${'currency'.tr}',
                            context),
                        widgetTextValue(
                            '${price.priceAfterDiscount}${'currency'.tr}',
                            context),
                        widgetTextValue('${price.note}', context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: Get.width / 1.5,
              height: 60,
              child: ElevatedButton(
                child: Text(
                  "subscribe_now".tr,
                ),
                onPressed: () {
                  //     Get.toNamed(Routes.editSon, arguments: son);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetTextKey(String key, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.check,
              color: AppColors().accentColor(1.0),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(key,
                maxLines: 2, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget widgetTextValue(String value, BuildContext context) {
    return Column(
      children: [
        Text(value, maxLines: 5, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
