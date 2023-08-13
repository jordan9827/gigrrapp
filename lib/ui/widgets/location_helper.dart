import 'package:location/location.dart' as loc;
import 'package:mapbox_search/mapbox_search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';
import '../../app/app.locator.dart';
import '../../domain/reactive_services/state_service.dart';
import '../../domain/repos/auth_repos.dart';
import '../../others/constants.dart';

class LocationHelper {
  static loc.Location location = loc.Location();
  static final stateCityService = locator<StateCityService>();
  static final authRepo = locator<Auth>();

  static Future<void> setCity(String stateController) async {
    for (var i in stateCityService.stateList) {
      if (i.name.toUpperCase() == stateController.toUpperCase()) {
        await authRepo.loadCity(i.id);
      }
    }
  }

  static Future<LocationDataUpdate> acquireCurrentLocation() async {
    LocationDataUpdate addressData = LocationDataUpdate(
      latLng: LatLng(0.0, 0.0),
      mapBoxPlace: MapBoxPlace.fromJson({}),
    );
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      final locationData = await location.getLocation();
      print("locationData ${locationData.latitude}");
      var lat = locationData.latitude ?? 0.0;
      var lng = locationData.longitude ?? 0.0;
      var map = MapBoxGeoCoding(
        language: languageCode,
        apiKey: MAPBOX_TOKEN,
      );

      var getAddress = await map.getAddress(
        Location(
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
  final MapBoxPlace mapBoxPlace;
  final LatLng latLng;

  LocationDataUpdate({
    required this.mapBoxPlace,
    required this.latLng,
  });
}
