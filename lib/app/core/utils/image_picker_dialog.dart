import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../../config/app_config.dart';

class ImagePickerDialog {
  Widget _roundedButton(
      {required String label,
      required Color bgColor,
      required Color txtColor}) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        padding: const EdgeInsets.all(15.0),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF696969),
                  offset: Offset(1.0, 6.0),
                  blurRadius: 0.001)
            ]),
        child: Text(label,
            style: TextStyle(
                color: txtColor, fontSize: 20.0, fontWeight: FontWeight.bold)));
  }

  _openCamera(ValueChanged<String?> onGet) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(CroppedFile(image!.path), onGet);
  }

  _openGallery(ValueChanged<String?> onGet) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(CroppedFile(image!.path), onGet);
  }

  _cropImage(CroppedFile image, ValueChanged<String?> onGet) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      maxWidth: 512,
      maxHeight: 512,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors().mainColor(1),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
      ],
    );
    CroppedFile? compressed = await _compress(croppedFile!);
    onGet(compressed?.path);
    // showLoadingDialog();

    Get.back();
  }

  Future<CroppedFile?> _compress(CroppedFile file) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath =
        "${dir.absolute.path}/temp${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
        file.path, targetPath,
        quality: 70);

    return result != null ? CroppedFile(result.path) : null;
  }

  show({
    required ValueChanged<String?> onGet,
  }) {
    Get.bottomSheet(Material(
        type: MaterialType.transparency,
        child: Opacity(
            opacity: 1.0,
            child: Container(
                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () => _openCamera(onGet),
                          child: _roundedButton(
                              label: "camera".tr,
                              bgColor: AppColors().mainColor(1),
                              txtColor: Colors.white)),
                      GestureDetector(
                        onTap: () => _openGallery(onGet),
                        child: _roundedButton(
                            label: "gallery".tr,
                            bgColor: const Color(0xFFFFFFFF),
                            txtColor: const Color.fromRGBO(31, 32, 34, 1.0)),
                      ),
                      const SizedBox(height: 15.0),
                      GestureDetector(
                          onTap: () => Get.back(),
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  30.0, 0.0, 30.0, 0.0),
                              child: _roundedButton(
                                  label: "cancel".tr,
                                  bgColor: Colors.black,
                                  txtColor: Colors.white)))
                    ])))));
  }
}
