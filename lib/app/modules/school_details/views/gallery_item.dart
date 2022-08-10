import 'package:flutter/material.dart';

import '../../../core/utils/image_tools.dart';

class GalleryItem extends StatelessWidget {
  GalleryItem({Key? key, required this.image}) : super(key: key);

  String image;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: ImageTools.image(
          fit: BoxFit.cover,
          url: image,
          height: 150,
          width: 100,
        ));
  }
}
