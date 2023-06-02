import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInfo {
  final String id;
  final LatLng position;
  final String title;
  final String description;
  final String type;
  final String icon;

  MarkerInfo({
    required this.id,
    required this.position,
    required this.title,
    required this.description,
    required this.type,
    required this.icon,
  });
}
