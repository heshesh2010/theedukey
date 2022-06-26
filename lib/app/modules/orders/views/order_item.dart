import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);
  final OrderDataData order;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
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
        child: Row(
          //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40),
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
                  Text('from'.tr, style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('to'.tr, style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 60),
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
                  Text('${order.orderStatus}',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${order.serviceName}',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${order.stage}',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('${order.theClass}',
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
          ],
        ),
      ),
    );
  }
}
