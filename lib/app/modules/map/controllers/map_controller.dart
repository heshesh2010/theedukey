import 'dart:async';

import 'package:fluster/fluster.dart';
import 'package:flutter/services.dart';
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
  final RxSet<Marker> markers = <Marker>{}.obs;

  /// Current map zoom. Initial zoom will be 15, street level
  static double currentZoom = 15;

  /// Map loading flag
  final Rx<bool> isMapLoading = true.obs;

  /// Markers loading flag
  final Rx<bool> areMarkersLoading = true.obs;

  /// Inits [Fluster] and all the markers with network images and updates the loading state.
  void _initMarkers() async {
    areMarkersLoading.value = true;
    Uint8List? markerIconSchool = await MapHelper()
        .getBytesFromAsset('assets/img/school_map_icon.png', 100);
    final BitmapDescriptor schoolIcon =
        BitmapDescriptor.fromBytes(markerIconSchool ?? Uint8List(0));

    Uint8List? markerIconCenter = await MapHelper()
        .getBytesFromAsset('assets/img/center_map_icon.png', 100);
    final BitmapDescriptor centerIcon =
        BitmapDescriptor.fromBytes(markerIconCenter ?? Uint8List(0));

    // markers.clear();
    // markers.refresh();
    await Future.forEach(
      getIt<SearchModel>().routeArgument!.schoolsList,
      (Facility facility) async {
        int? idx = facility.school?.mapLocation?.indexOf(",");

        bool result = await _checkIfWithinBounds(
            double.parse(
                facility.school?.mapLocation?.substring(0, idx).trim() ?? "0"),
            double.parse(
                facility.school?.mapLocation?.substring(idx! + 1).trim() ??
                    "0"));
        if (result) {
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
                  double.parse(facility.school?.mapLocation
                          ?.substring(idx! + 1)
                          .trim() ??
                      "0")),

              icon: facility.school?.facilityTypeId == 3
                  ? centerIcon
                  : schoolIcon,

              // icon: BitmapDescriptor.fromBytes(await MapHelper()
              //     .makeReceiptImage(facility.school?.logo ??
              //         "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png")),
              infoWindow: InfoWindow(
                  title: facility.school?.name ?? " ",
                  snippet: 'press_to_view_details'.tr,
                  onTap: () {
                    Get.toNamed(Routes.schoolDetails,
                        arguments:
                            RouteArgument(schoolId: facility.school?.id));
                  }),
            ).toMarker(),
          );
          markers.refresh();
        }
        areMarkersLoading.value = false;
      },
    );
    // _clusterManager = await MapHelper.initClusterManager(
    //   markers.toList(),
    //   _minClusterZoom,
    //   _maxClusterZoom,
    // );
  }

////
  ///
  ///
  ///

  void _initMarkerstest() async {
    areMarkersLoading.value = true;
    Uint8List? markerIconSchool = await MapHelper()
        .getBytesFromAsset('assets/img/school_map_icon.png', 100);
    final BitmapDescriptor schoolIcon =
        BitmapDescriptor.fromBytes(markerIconSchool ?? Uint8List(0));

    Uint8List? markerIconCenter = await MapHelper()
        .getBytesFromAsset('assets/img/center_map_icon.png', 100);
    final BitmapDescriptor centerIcon =
        BitmapDescriptor.fromBytes(markerIconCenter ?? Uint8List(0));

    await Future.forEach(
      getIt<SearchModel>().routeArgument!.schoolsList,
      (Facility facility) async {
        int? idx = facility.school?.mapLocation?.indexOf(",");

        if (await _checkIfWithinBounds(
            double.parse(
                facility.school?.mapLocation?.substring(0, idx).trim() ?? "0"),
            double.parse(
                facility.school?.mapLocation?.substring(idx! + 1).trim() ??
                    "0"))) {
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
                  double.parse(facility.school?.mapLocation
                          ?.substring(idx! + 1)
                          .trim() ??
                      "0")),

              icon: facility.school?.facilityTypeId == 3
                  ? centerIcon
                  : schoolIcon,

              // icon: BitmapDescriptor.fromBytes(await MapHelper()
              //     .makeReceiptImage(facility.school?.logo ??
              //         "https://dev17.toplinedev.com/theedukey/public/uploads/settings/1643894636.png")),
              infoWindow: InfoWindow(
                  title: facility.school?.name ?? " ",
                  snippet: 'press_to_view_details'.tr,
                  onTap: () {
                    Get.toNamed(Routes.schoolDetails,
                        arguments:
                            RouteArgument(schoolId: facility.school?.id));
                  }),
            ).toMarker(),
          );
        }
      },
    );
    // _clusterManager = await MapHelper.initClusterManager(
    //   markers.toList(),
    //   _minClusterZoom,
    //   _maxClusterZoom,
    // );
    areMarkersLoading.value = false;
  }

  /// Gets the markers and clusters to be displayed on the map for the current zoom level and
  /// updates state.
//   Future<void> updateMarkers([double? updatedZoom]) async {
//     if (_clusterManager == null || updatedZoom == currentZoom) return;

//     if (updatedZoom != null) {
//       currentZoom = updatedZoom;
//     }

//     // final updatedMarkers = await MapHelper.getClusterMarkers(
//     //   _clusterManager,
//     //   currentZoom,
//     //   _clusterColor,
//     //   _clusterTextColor,
//     //   100,
//     // );

//     // FinalMarkers
//     //   ..clear()
//     //   ..addAll(updatedMarkers);

// //FinalMarkers.clear().addAll(updatedMarkers);

//     areMarkersLoading.value = false;
//   }

  Future<void> moveCamera(lang, lon) async {
    final GoogleMapController controller = await mapController.future;
    controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lang, lon), zoom: currentZoom)));

    Future.delayed(const Duration(seconds: 2), () {
      _initMarkers();
    });

    //   update();
  }

  getInitialCameraPosition() {
    if (getIt<SearchModel>().routeArgument!.schoolsList.length == 1) {
      var facility = getIt<SearchModel>().routeArgument!.schoolsList[0];
      int? idx = facility.school?.mapLocation?.indexOf(",");

      return CameraPosition(
        target: LatLng(
            double.parse(
                facility.school?.mapLocation?.substring(0, idx).trim() ?? "0"),
            double.parse(
                facility.school?.mapLocation?.substring(idx! + 1).trim() ??
                    "0")),
        zoom: currentZoom,
      );
    }

    return CameraPosition(
      target: const LatLng(24.69596839147883, 46.686680461716264),
      zoom: currentZoom,
    );
  }

// show only markers in area of map
  // Future<void> showMarkersInArea() async {
  //   final GoogleMapController controller = await mapController.future;
  //   final LatLngBounds bounds = await controller.getVisibleRegion();
  //   final LatLng northeast = bounds.northeast;
  //   final LatLng southwest = bounds.southwest;
  //   final LatLng center = bounds.center;

  //   print('northeast: $northeast');
  //   print('southwest: $southwest');
  //   print('center: $center');
  // }

  void onMapCreated(GoogleMapController controller) {
    /// Called when the Google Map widget is created. Updates the map loading state
    /// and inits the markers.
    ///
    controller.setMapStyle(
        '[{"featureType": "poi","stylers": [{"visibility": "off"}]}]');

    mapController.complete(controller);
    isMapLoading.value = false;

    Future.delayed(const Duration(seconds: 2), () {
      _initMarkers();
    });
    //_initMarkers();

    // update();
  }

  Future<bool> _checkIfWithinBounds(double lat, double long) async {
    GoogleMapController? mapControllerTest = await mapController.future;

    var mapBounds = await mapControllerTest.getVisibleRegion();
    return mapBounds.contains(
      LatLng(lat, long),
    );
  }

  onCameraMoveStarted() {
    print("onCameraMoveStarted");
    _initMarkerstest();
  }
}
