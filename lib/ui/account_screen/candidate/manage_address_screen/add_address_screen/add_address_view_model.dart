import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;

import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../others/constants.dart';

class AddAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  double latitude = 0.0;
  double longitude = 0.0;
  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      mapBox.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        country: "in",
        onSelect: (place) async {
          var addressData = place.context!;
          setBusy(true);
          addressController.text = place.placeName ?? "";
          cityController.text = addressData[2].text ?? "";
          stateController.text = addressData[4].text ?? "";
          pinCodeController.text = addressData[0].text ?? "";
          latitude = place.geometry!.coordinates![1];
          longitude = place.geometry!.coordinates![0];
          setBusy(false);
          notifyListeners();
        },
        limit: 7,
      ),
    );
  }
}
