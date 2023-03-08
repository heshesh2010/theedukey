import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/data/models/favorite.dart';

import '../../../core/utils/image_tools.dart';
import '../controllers/favorite_controller.dart';

class FavoriteItem extends GetWidget<FavoriteController> {
  const FavoriteItem({Key? key, required this.favorite}) : super(key: key);
  final FavoriteDataData favorite;
  @override
  Widget build(BuildContext context) {
    return Container(
      //  height: 120,
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
                      fit: BoxFit.contain,
                      url: favorite.logo ?? " ",
                      height: 100,
                      width: 100,
                    )),
              ),
              Expanded(
                child: Column(
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
                        Text(favorite.rate ?? "0"),
                      ],
                    ),
                    Text(
                      '${favorite.name}',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
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
                        Expanded(
                          child: Text(
                            '${favorite.address}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10),
                child: ElevatedButton(
                  onPressed: () {
                    controller.deleteFav(favorite);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: const CircleBorder(),
                    backgroundColor: const Color(0xffF4F4F5),
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Icon(Icons.delete_rounded, color: Colors.grey),
                )),
          )
        ],
      ),
    );
  }
}
