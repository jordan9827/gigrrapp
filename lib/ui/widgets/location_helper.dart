import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:location/location.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';

import '../../others/constants.dart';

class LocationHelper {
  static Location location = Location();

  static Future<LocationDataUpdate> acquireCurrentLocation() async {
    LocationDataUpdate addressData = LocationDataUpdate(
      latLng: LatLng(0.0, 0.0),
      mapBoxPlace: mapBox.MapBoxPlace.fromJson({}),
    );
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      final locationData = await location.getLocation();
      print("locationData ${locationData.latitude}");
      var lat = locationData.latitude ?? 0.0;
      var lng = locationData.longitude ?? 0.0;
      var map = mapBox.MapBoxGeoCoding(
        apiKey: MAPBOX_TOKEN,
      );

      var getAddress = await map.getAddress(
        mapBox.Location(
          lat: lat,
          lng: lng,
        ),
      );
      addressData = LocationDataUpdate(
        mapBoxPlace: getAddress!.first,
        latLng: LatLng(lat, lng),
      );
      print("addressData $getAddress");
    } else {
      serviceEnabled = await location.requestService();
    }
    return addressData;
  }
}

class LocationDataUpdate {
  final mapBox.MapBoxPlace mapBoxPlace;
  final LatLng latLng;
  LocationDataUpdate({
    required this.mapBoxPlace,
    required this.latLng,
  });
}
