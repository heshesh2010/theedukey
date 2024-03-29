import 'package:flutter/material.dart';

import '../../../core/utils/image_tools.dart';
import '../../../data/models/school.dart';

class RelatedSchoolItem extends StatelessWidget {
  const RelatedSchoolItem({Key? key, required this.relatedItem})
      : super(key: key);

  final SchoolData relatedItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                  fit: BoxFit.contain,
                  url: relatedItem.logo,
                  height: 200,
                  width: 350,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(relatedItem.name ?? "0"),
              Expanded(
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
                        relatedItem.address ?? " ",
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
                  Text(relatedItem.rate ?? "0"),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
