import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/image_tools.dart';
import '../../../data/models/school.dart';

class SchoolItem extends StatelessWidget {
  const SchoolItem({Key? key, required this.school}) : super(key: key);
  final SchoolData school;
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
      child: Stack(
        //  crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: ImageTools.image(
                      fit: BoxFit.fitHeight,
                      url: school.logo ?? "",
                      height: 100,
                      width: 100,
                    )),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color.fromRGBO(255, 191, 14, 1),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(school.rate ?? " "),
                    ],
                  ),
                  Text(
                    '${school.name}',
                    maxLines: 2,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                      SizedBox(
                        width: 40.w,
                        child: Text(
                          '${school.address}',
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 10.sp),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
