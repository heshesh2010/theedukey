import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart';

import '../../search/controllers/search_controller.dart';

class MapController extends GetxController {
  List<Marker> allMarkers = <Marker>[].obs; // Inside Map View Controller
  SearchController? searchController;
  late BitmapDescriptor customIcon;

  @override
  void onInit() {
    searchController = Get.find<SearchController>();

    getMarkers();
    super.onInit();
  }

  Future<ByteBuffer> loadNetworkImage(path) async {
    final completed = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completed.complete(info)));
    final imageInfo = await completed.future;
    final byteData =
        await imageInfo.image.toByteData(format: ImageByteFormat.png);
    return byteData!.buffer;
  }

  late List<int> myImage;

  Future<List<int>> makeReceiptImage(value) async {
    // load avatar image
    List<int> bytes = Uint8List.view(await loadNetworkImage(value));
    var avatarImage = decodeImage(bytes);

    //load marker image
    ByteData imageData = await rootBundle.load('assets/img/ma.png');
    bytes = Uint8List.view(imageData.buffer);
    var markerImage = decodeImage(bytes);

    //resize the avatar image to fit inside the marker image
    avatarImage = copyResize(avatarImage!,
        width: markerImage!.width ~/ 1.1, height: markerImage.height ~/ 1.4);

    var radius = 90;
    int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;

    //draw the avatar image cropped as a circle inside the marker image
    for (int y = -radius; y <= radius; y++) {
      for (int x = -radius; x <= radius; x++) {
        if (x * x + y * y <= radius * radius) {
          markerImage.setPixelSafe(originX + x + 8, originY + y + 10,
              avatarImage.getPixelSafe(originX + x, originY + y));
        }
      }
    }
    return encodePng(markerImage);
  }

  getMarkers() async {
    searchController?.schoolList.asMap().forEach((key, value) async {
      int? idx = value.mapLocation?.indexOf(",");

// make sure to initialize before map loading
      Uint8List image = Uint8List.fromList(await makeReceiptImage(value.logo ??
          "https://dev17.toplinedev.com/theedukey/public/uploads/facilities/16570474004006.png"));
      final Codec markerImageCodec = await instantiateImageCodec(
          image.buffer.asUint8List(),
          targetHeight: 300,
          targetWidth: 250);
      final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ImageByteFormat.png);
      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

      allMarkers.add(Marker(
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          markerId: MarkerId(key.toString()),
          position: LatLng(
              double.parse(value.mapLocation?.substring(0, idx).trim() ?? "0"),
              double.parse(
                  value.mapLocation?.substring(idx! + 1).trim() ?? "0")),
          infoWindow: InfoWindow(title: value.name ?? " "),
          onTap: () {
            //do something here
          }));
    });

    update(); // <=== Add, because you are using GetBuilder
    //   });
  }
}
