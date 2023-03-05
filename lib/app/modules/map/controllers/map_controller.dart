import 'dart:async';

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/helpers/mapMarker.dart';
import '../../../core/helpers/map_helper.dart';
import '../../../data/models/facility.dart';
import '../../../data/models/route_argument.dart';
import '../../../data/service/locator.dart';
import '../../../data/service/search_model.dart';
import '../../../routes/app_pages.dart';

class MapController extends GetxController {
  final Completer<GoogleMapController> mapController = Completer();

  /// Set of displayed markers and cluster markers on the map
  final Set<Marker> markers = {};

  /// Minimum zoom at which the markers will cluster
  final int _minClusterZoom = 0;

  /// Maximum zoom at which the markers will cluster
  final int _maxClusterZoom = 16;

  /// [Fluster] instance used to manage the clusters
  Fluster<MapMarker>? _clusterManager;

  /// Current map zoom. Initial zoom will be 15, street level
  static double currentZoom = 15;

  /// Map loading flag
  final Rx<bool> isMapLoading = true.obs;

  /// Markers loading flag
  final Rx<bool> areMarkersLoading = true.obs;

  /// Url image used on normal markers
  final String _markerImageUrl =
      'https://img.icons8.com/office/80/000000/marker.png';

  /// Color of the cluster circle
  final Color _clusterColor = Colors.blue;

  /// Color of the cluster text
  final Color _clusterTextColor = Colors.white;

  /// Inits [Fluster] and all the markers with network images and updates the loading state.
  void _initMarkers() async {
    final List<MapMarker> markers = [];

    for (Facility facility in getIt<SearchModel>().routeArgument!.schoolsList) {
      // Uint8List image = Uint8List.fromList(await MapHelper().makeReceiptImage(
      //     facility.school?.logo ??
      //         "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png"));

      // final BitmapDescriptor markerImage = BitmapDescriptor.fromBytes(
      //     await MapHelper.resizeImageBytes(image, 200));

      int? idx = facility.school?.mapLocation?.indexOf(",");
      // BitmapDescriptor markerImage = await MapHelper.getMarkerImageFromUrl(
      //     facility.school?.logo ??
      //         "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png",
      //     targetWidth: 200);
      markers.add(
        MapMarker(
          id: getIt<SearchModel>()
              .routeArgument!
              .schoolsList
              .indexOf(facility)
              .toString(),
          position: LatLng(
              double.parse(
                  facility.school?.mapLocation?.substring(0, idx).trim() ??
                      "0"),
              double.parse(
                  facility.school?.mapLocation?.substring(idx! + 1).trim() ??
                      "0")),

          // icon: await ClipRRect(
          //     borderRadius: BorderRadius.circular(10000.0),
          //     child: CachedNetworkImage(
          //       height: 50,
          //       width: 50,
          //       fit:  BoxFit.cover,
          //       imageUrl: facility.school?.logo ??
          //           "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png",
          //       errorWidget: (context, url, error) => const Icon(Icons.error),
          //     )).toBitmapDescriptor(imageSize: const Size(50, 50)),
          icon: BitmapDescriptor.fromBytes(await MapHelper().makeReceiptImage(
              facility.school?.logo ??
                  "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png")),
          infoWindow: InfoWindow(
              title: facility.school?.name ?? " ",
              snippet: 'press_to_view_details'.tr,
              onTap: () {
                Get.toNamed(Routes.schoolDetails,
                    arguments: RouteArgument(schoolId: facility.school?.id));
              }),
        ),
      );
    }
    _clusterManager = await MapHelper.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
    );

    await updateMarkers();
  }

  /// Gets the markers and clusters to be displayed on the map for the current zoom level and
  /// updates state.
  Future<void> updateMarkers([double? updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == currentZoom) return;

    if (updatedZoom != null) {
      currentZoom = updatedZoom;
    }

    areMarkersLoading.value = true;

    final updatedMarkers = await MapHelper.getClusterMarkers(
      _clusterManager,
      currentZoom,
      _clusterColor,
      _clusterTextColor,
      100,
    );

    markers
      ..clear()
      ..addAll(updatedMarkers);

    areMarkersLoading.value = false;
  }

  CameraPosition kGooglePlex = CameraPosition(
    target: const LatLng(24.69596839147883, 46.686680461716264),
    zoom: currentZoom,
  );

  void onMapCreated(GoogleMapController controller) {
    /// Called when the Google Map widget is created. Updates the map loading state
    /// and inits the markers.
    ///
    controller.setMapStyle(
        '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]');

    mapController.complete(controller);

    isMapLoading.value = false;

    _initMarkers();

    update();
  }
}
