import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart';

import '../../../data/models/facility.dart';
import '../../../data/models/route_argument.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';
import '../../../routes/app_pages.dart';

class MapController extends GetxController {
  List<Marker> allMarkers = <Marker>[].obs; // Inside Map View Controller
  late BitmapDescriptor customIcon;
  GoogleMapController? mapController;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(24.69596839147883, 46.686680461716264),
    zoom: 14.4746,
  );

  void onMapCreated(GoogleMapController controller) {
    //   _controller.complete(controller);

    controller.setMapStyle(
        '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]');

    mapController = controller;

    getIt<SearchModel>()
        .routeArgument!
        .schoolsList
        .asMap()
        .forEach((key, Facility value) async {
      int? idx = value.school?.mapLocation?.indexOf(",");

      if (key == 0) {
        updateMapCamera(
            double.parse(
                value.school?.mapLocation?.substring(0, idx).trim() ?? "0"),
            double.parse(
                value.school?.mapLocation?.substring(idx! + 1).trim() ?? "0"));
      }

      await getMarkers(idx, key, value);

      update();
      // controller.showMarkerInfoWindow(MarkerId(key.toString()));
    });
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

    var avatarImage =
        decodeImage(Uint8List.view(await loadNetworkImage(value)));

    //load marker image
    ByteData imageData = await rootBundle.load('assets/img/ma.png');

    var markerImage = decodeImage(Uint8List.view(imageData.buffer));

    //resize the avatar image to fit inside the marker image
    avatarImage = copyResize(avatarImage!,
        width: markerImage!.width ~/ 1.1, height: markerImage.height ~/ 1.4);

    var radius = 90;
    int originX = avatarImage.width ~/ 2, originY = avatarImage.height ~/ 2;

    //draw the avatar image cropped as a circle inside the marker image
    for (int y = -radius; y <= radius; y++) {
      for (int x = -radius; x <= radius; x++) {
        if (x * x + y * y <= radius * radius) {
          markerImage.setPixel(originX + x + 8, originY + y + 10,
              avatarImage.getPixelSafe(originX + x, originY + y));
        }
      }
    }
    return encodePng(markerImage);
  }

  void updateMapCamera(latitude, longitude) {
    CameraUpdate update = CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 12));
    mapController?.animateCamera(update);
    mapController!.moveCamera(update);
  }

  getMarkers(idx, key, Facility value) async {
// make sure to initialize before map loading
    Uint8List image = Uint8List.fromList(await makeReceiptImage(value
            .school?.logo ??
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
          double.parse(
              value.school?.mapLocation?.substring(0, idx).trim() ?? "0"),
          double.parse(
              value.school?.mapLocation?.substring(idx! + 1).trim() ?? "0")),
      infoWindow: InfoWindow(
          title: value.school?.name ?? " ",
          snippet: 'press_to_view_details'.tr,
          onTap: () {
            Get.toNamed(Routes.schoolDetails,
                arguments: RouteArgument(schoolId: value.school?.id));
          }),
    ));

    //   });
  }
}
