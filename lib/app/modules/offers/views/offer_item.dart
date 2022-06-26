import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/data/models/offer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readmore/readmore.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({Key? key, required this.offer}) : super(key: key);
  final OfferData offer;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 320,
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
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CachedNetworkImage(
              height: 200,
              // width: 300,
              imageUrl: offer.image ?? " ",
              fit: BoxFit.fitHeight,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress)),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  '${offer.title}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).focusColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${"from".tr}: ${offer.startDate}"),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).focusColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text("${"to".tr}: ${offer.endDate}"),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${"before_discount".tr}: ${offer.price}",
                      style: const TextStyle(
                        color: Colors.grey,
                        decorationColor: Colors.grey,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${"after_discount".tr}: ${offer.priceAfterDiscount}",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
                ReadMoreText(
                  "${offer.text}",
                  trimLines: 5,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'show_more'.tr,
                  trimExpandedText: 'show_less'.tr,
                  style: Theme.of(context).textTheme.bodyText1,
                  moreStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
