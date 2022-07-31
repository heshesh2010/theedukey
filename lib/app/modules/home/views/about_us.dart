import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../core/utils/image_tools.dart';
import '../controllers/home_controller.dart';

class AboutUs extends GetWidget<HomeController> {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFE8F7F7),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("about_us".tr, style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 20),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: AlignmentDirectional.topStart, // <-- SEE HERE
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: ImageTools.image(
                          url: "assets/img/about1.png", fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 30),
                  child: Align(
                    alignment: AlignmentDirectional.bottomEnd, // <-- SEE HERE
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(
                                  20.0) //                 <--- border radius here
                              ),
                          border: Border.all(
                            width: 8,
                            color: const Color(0xFFE8F7F7),
                          ),
                        ),
                        child: ImageTools.image(
                            url: "assets/img/about2.png", fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Obx(() => ReadMoreText(
                      controller.aboutUs.value,
                      textAlign: TextAlign.justify,
                      trimLines: 5,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Length,
                      trimCollapsedText: 'show_more'.tr,
                      trimExpandedText: 'show_less'.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                      moreStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ),
    );
  }
}
