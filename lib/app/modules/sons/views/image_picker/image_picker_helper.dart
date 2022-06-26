import 'package:flutter/material.dart';
import 'package:theedukey/app/core/utils/image_tools.dart';
import '../../../../core/utils/image_picker_dialog.dart';
import 'package:get/get.dart';

class ImagePickerHelper extends StatelessWidget {
  const ImagePickerHelper(
      {Key? key, this.imageUrl, required this.onGet, required this.buttonTitle})
      : super(key: key);
  final String? imageUrl;
  final ValueChanged<String?> onGet;
  final String? buttonTitle;

  @override
  Widget build(BuildContext context) {
    return imageUrl != null && imageUrl != ""
        ? Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Center(
                child: Text("edit_picture".tr),
              ),
              const SizedBox(height: 10),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: <Widget>[
                    ImageTools.image(
                      url: imageUrl,
                      fit: BoxFit.cover,
                      width: Get.width,
                      height: Get.height / 3.5,
                    ),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: InkWell(
                        onTap: (() => ImagePickerDialog().show(onGet: (value) {
                              onGet(value);
                            })),
                        child: const Icon(
                          Icons.edit,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : SizedBox(
            width: Get.width,
            child: OutlinedButton.icon(
                onPressed: (() => ImagePickerDialog().show(onGet: (value) {
                      onGet(value);
                    })),
                icon: const Icon(Icons.image),
                label: Text(
                  //"personal_image".tr,
                  buttonTitle ?? " ",
                  style: Get.textTheme.subtitle1,
                )),
          );
  }
}
