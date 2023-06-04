class LatLng {
  final double lat;
  final double lng;

  const LatLng(
     this.lat,
     this.lng,
  );

  String get asString => '$lng,$lat';
}
