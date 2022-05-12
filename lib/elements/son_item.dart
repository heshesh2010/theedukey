import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theedukey/app/data/models/son.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:readmore/readmore.dart';

class SonItem extends StatelessWidget {
  const SonItem({Key? key, required this.son}) : super(key: key);
  final SonData son;
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
              imageUrl: son.image ?? " ",
              fit: BoxFit.fitHeight,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              children: [
                Text(
                  '${son.name}',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
