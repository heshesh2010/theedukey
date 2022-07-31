import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';

class MapView extends GetWidget<MapController> {
  MapView({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.69596839147883, 46.686680461716264),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MapView'),
        centerTitle: true,
      ),
      body: Obx(() => GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.showMarkerInfoWindow(const MarkerId("1"));

              controller.setMapStyle(
                  '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]');
            },
            markers: Set<Marker>.of(controller.allMarkers),
          )),
    );
  }
}
