import 'package:flutter/material.dart';
import 'package:theedukey/app/data/models/notification.dart' as model;

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.notification})
      : super(key: key);
  final model.Notification notification;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
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
        padding: const EdgeInsets.only(right: 20.0, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${notification.title}',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('${notification.text}',
                style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  color: Theme.of(context).focusColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text('${notification.createdAt}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
