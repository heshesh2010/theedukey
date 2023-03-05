import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../elements/drawer.dart';
import '../../../../elements/topbar.dart';
import '../controllers/map_controller.dart';

class MapView extends GetWidget<MapController> {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            getTopBar(context, title: "show_results_on_map".tr, isback: true),
        drawer: DrawerSideMenu(),
        body: Obx(
          () => Stack(
            children: <Widget>[
              // Google Map widget
              Opacity(
                opacity: controller.isMapLoading.value ? 0 : 1,
                child: GoogleMap(
                  mapToolbarEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  initialCameraPosition: controller.kGooglePlex,
                  markers: controller.markers,
                  onMapCreated: (onMapCreated) =>
                      controller.onMapCreated(onMapCreated),
                  onCameraMove: (position) =>
                      controller.updateMarkers(position.zoom),
                ),
              ),

              // Map loading indicator
              Opacity(
                opacity: controller.isMapLoading.value ? 1 : 0,
                child: const Center(child: CircularProgressIndicator()),
              ),

              // Map markers loading indicator
              if (controller.areMarkersLoading.value)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ));

    //  GoogleMap(
    //       mapType: MapType.normal,
    //       myLocationEnabled: true,
    //       myLocationButtonEnabled: true,
    //       initialCameraPosition: controller.kGooglePlex,
    //       onMapCreated: controller.onMapCreated,
    //       markers: Set<Marker>.of(controller.allMarkers),
    //     )),
    // );
  }
}
