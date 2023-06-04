import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../others/constants.dart';
import '../../../util/enums/latLng.dart';

class MapBoxAddressFormViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  LatLng latLng = LatLng(0.0, 0.0);

  Location location = Location();

  MapBoxAddressFormViewModel(TextEditingController controller, LatLng _latLng) {
    this.latLng = _latLng;
    controller = addressController;
  }

  void init() async {
    await acquireCurrentLocation();
  }

  Future<void> acquireCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      setBusy(true);
      final locationData = await location.getLocation();
      print("locationData ${locationData.latitude}");

      var map = mapBox.MapBoxGeoCoding(
        apiKey: MAPBOX_TOKEN,
      );

      var getAddress = await map.getAddress(
        mapBox.Location(
          lat: locationData.latitude ?? 0.0,
          lng: locationData.longitude ?? 0.0,
        ),
      );
      var addressData = getAddress!.first;
      print("addressData $addressData");
      await setAddressPlace(addressData);
      latLng =
          LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      setBusy(false);
      notifyListeners();
    } else {
      serviceEnabled = await location.requestService();
      return;
    }
    notifyListeners();
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      mapBox.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        country: "in",
        onSelect: (place) async {
          await setAddressPlace(place);
          latLng = LatLng(
              place.geometry!.coordinates![1], place.geometry!.coordinates![0]);
          notifyListeners();
        },
        limit: 7,
      ),
    );
  }

  Future<void> setAddressPlace(mapBox.MapBoxPlace mapBoxPlace) async {
    print("$mapBoxPlace");
    var addressData = mapBoxPlace.context ?? [];

    addressController.text = mapBoxPlace.placeName ?? "";
    cityController.text = addressData[2].text ?? "";
    stateController.text = addressData[4].text ?? "";
    pinCodeController.text = addressData[0].text ?? "";
    notifyListeners();
  }
}
