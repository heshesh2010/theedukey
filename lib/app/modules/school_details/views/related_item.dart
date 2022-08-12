import 'package:flutter/material.dart';
import 'package:theedukey/app/data/models/facility.dart';

import '../../../core/utils/image_tools.dart';

class RelatedSchoolItem extends StatelessWidget {
  RelatedSchoolItem({Key? key, required this.relatedItem}) : super(key: key);

  Prices relatedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 10),
      child: Container(
        // width: 400,
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
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: ImageTools.image(
                  fit: BoxFit.cover,
                  url:
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png",
                  height: 200,
                  width: 350,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(relatedItem.className ?? "0"),
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
                    relatedItem.className ?? " ",
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
                  Text(relatedItem.className ?? "0"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
