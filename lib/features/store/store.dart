import 'package:latlong2/latlong.dart';

class StoreLocation {
  final String name;
  final String address;
  final LatLng position;

  StoreLocation({
    required this.name,
    required this.address,
    required this.position,
  });
}
