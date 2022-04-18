import 'package:flutter/material.dart';
import 'package:theedukey/models/notification.dart' as model;

class NotificationItem extends StatelessWidget {
   const NotificationItem({Key? key, required this.notification}) : super(key: key);
  final model.Notification notification;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${notification.title}',style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),),
        const SizedBox(height: 10,),
        Text('${notification.text}',style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(height: 10,),
        Row(children: [
          Icon(Icons.watch_later_outlined,color: Theme.of(context).focusColor,),
          const SizedBox(width: 10,),
          Text('${notification.createdAt}'),
        ],)
      ],
    );
  }
}
