import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theedukey/elements/loading_dialog.dart';

class ImagePickerDialog {
  Widget _roundedButton({required String label,required Color bgColor, required Color txtColor}) {
    return Container(
        margin:const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        padding:const EdgeInsets.all(15.0),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius:const  BorderRadius.all(Radius.circular(100.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF696969),
                  offset: Offset(1.0, 6.0),
                  blurRadius: 0.001)
            ]),
        child: Text(label,
            style:  TextStyle(
                color: txtColor, fontSize: 20.0, fontWeight: FontWeight.bold)));
  }

  _openCamera(ValueChanged<File> onGet, BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(File(image!.path), onGet, context);
  }

  _openGallery(ValueChanged<File> onGet, BuildContext context) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(File(image!.path), onGet, context);
  }

  _cropImage(File image, ValueChanged<File> onGet, BuildContext context) async {
    File? _croppedFile = await ImageCropper().cropImage(
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
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    File? _compressed = await _compress(_croppedFile!);
    onGet(_compressed!);
    Navigator.pop(context);
    showLoadingDialog();
  }

  Future<File?> _compress(File file) async {
    final _dir = await path_provider.getTemporaryDirectory();
    final _targetPath = _dir.absolute.path + "/temp${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, _targetPath,
        quality: 70);

    return result;
  }

  show({required ValueChanged<File> onGet, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Material(
              type: MaterialType.transparency,
              child: Opacity(
                  opacity: 1.0,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 20.0),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                decoration: BoxDecoration(
                                    color:const  Color(0xffd34600) ,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("add_photo".tr , style: const TextStyle(color: Colors.white),),
                                )) ,
                            GestureDetector(
                                onTap: () => _openCamera(onGet, context),
                                child: _roundedButton(
                                    label: "camera".tr,
                                    bgColor: Theme.of(context).primaryColor,
                                    txtColor: Colors.white)),
                            GestureDetector(
                              onTap: () => _openGallery(onGet, context),
                              child: _roundedButton(
                                  label: "gallery".tr,
                                  bgColor:  const Color(0xFFFFFFFF),
                                  txtColor:  const Color.fromRGBO(31, 32, 34, 1.0)),
                            ),
                            const SizedBox(height: 15.0),
                            GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child:  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        30.0, 0.0, 30.0, 0.0),
                                    child: _roundedButton(
                                        label: "cancel".tr,
                                        bgColor: Colors.black,
                                        txtColor: Colors.white)))
                          ]))));
        });
  }
}