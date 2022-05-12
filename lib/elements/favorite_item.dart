import 'package:flutter/material.dart';
import 'package:theedukey/app/data/models/favorite.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({Key? key, required this.favorite}) : super(key: key);
  final Favorite favorite;
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                height: 100,
                width: 100,
                imageUrl: favorite.logo ?? " ",
                fit: BoxFit.fitHeight,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.star,
                    color: Color.fromRGBO(255, 191, 14, 1),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('4.5'),
                ],
              ),
              Text(
                '${favorite.name}',
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
