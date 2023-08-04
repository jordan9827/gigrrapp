import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../others/constants.dart';
import '../../../util/enums/latLng.dart';
import '../location_helper.dart';

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
    var location = await LocationHelper.acquireCurrentLocation();
    await setAddressPlace(location);
    setBusy(false);
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      mapBox.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "select_location".tr(),
        language: languageCode,
        country: countryType,
        onSelect: (place) async {
          latLng = LatLng(
            place.coordinates!.latitude,
            place.coordinates!.longitude,
          );
          await setAddressPlace(
            LocationDataUpdate(
              mapBoxPlace: place,
              latLng: latLng,
            ),
          );
          notifyListeners();
        },
        limit: 7,
      ),
    );
    notifyListeners();
  }

  Future<void> setAddressPlace(LocationDataUpdate data) async {
    var coordinates = data.latLng;
    latLng = LatLng(
      coordinates.lat,
      coordinates.lng,
    );
    var addressData = data.mapBoxPlace.placeContext;
    addressController.text = data.mapBoxPlace.placeName;
    cityController.text = addressData.city;
    stateController.text = "${addressData.state}, ${addressData.country}";
    pinCodeController.text = addressData.postCode;
    notifyListeners();
  }
}
