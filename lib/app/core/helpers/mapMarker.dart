import 'package:fluster/fluster.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Clusterable {
  final String? id;
  final LatLng? position;
  BitmapDescriptor? icon;
  final InfoWindow? infoWindow;

  MapMarker({
    this.id,
    this.position,
    this.icon,
    this.infoWindow,
    isCluster = false,
    clusterId,
    pointsSize,
    childMarkerId,
  }) : super(
          markerId: id,
          latitude: position?.latitude ?? 0.0,
          longitude: position?.longitude ?? 0.0,
          isCluster: isCluster,
          clusterId: clusterId,
          pointsSize: pointsSize,
          childMarkerId: childMarkerId,
        );
  Marker toMarker() => Marker(
        markerId: MarkerId(id ?? '0'),
        position: LatLng(
          position?.latitude ?? 0.0,
          position?.longitude ?? 0.0,
        ),
        icon: icon ?? BitmapDescriptor.defaultMarker,
        infoWindow: infoWindow ?? InfoWindow(title: 'School'.tr),
      );
}
