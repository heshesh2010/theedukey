import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/core/utils/image_tools.dart';

getTopBar(BuildContext context,
    {String? title, bool? isback, bool? isLeadingIconDisabled}) {
  return PreferredSize(
    preferredSize: const Size(0, 200),
    child: Stack(
      children: [
        Container(
          color: Colors.transparent,
          child: Image.asset(
            'assets/img/header_bg.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Align(
          alignment: Get.locale?.languageCode == "ar"
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
              padding: const EdgeInsets.only(top: 1.0, right: 10),
              child: Builder(
                  builder: (context) =>
                      isLeadingIconDisabled != null && isLeadingIconDisabled
                          ? Container()
                          : isback != null && isback
                              ? IconButton(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                )
                              : // Ensure Scaffold is in context
                              IconButton(
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () =>
                                      Scaffold.of(context).openDrawer()))),
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
              child: title != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(title,
                          style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    )
                  : ImageTools.image(
                      url: 'assets/img/logo_white.png',
                      fit: BoxFit.cover,
                      height: 100)),
        ),
      ],
    ),
  );
}
