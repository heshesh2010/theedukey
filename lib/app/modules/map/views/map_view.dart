import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../controllers/map_controller.dart';

class MapView extends GetWidget<MapController> {
  MapView({Key? key}) : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getTopBar(context, title: "show_results_on_map".tr, isback: true),
      drawer: DrawerSideMenu(),
      body: Obx(() => GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: controller.kGooglePlex,
            onMapCreated: controller.onMapCreated,
            markers: Set<Marker>.of(controller.allMarkers),
          )),
    );
  }
}
