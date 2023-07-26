import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/enums/latLng.dart';
import '../../../../widgets/location_helper.dart';

class AddAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  LatLng latLng = const LatLng(14.508, 46.048);
  bool isVisible = false;

  List<String> addressTypeList = ["Home", "Office", "Other"];
  String addressTypeValue = "";

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void onCostCriteriaSelect(String? val) {
    addressTypeValue = val!;
    notifyListeners();
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      mapBox.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "select_location".tr(),
        language: "en",
        country: "in",
        onSelect: (place) async {
          setAddressPlace(
            LocationDataUpdate(
              mapBoxPlace: place,
              latLng: LatLng(
                place.coordinates!.latitude,
                place.coordinates!.longitude,
              ),
            ),
          );
          setBusy(false);
          notifyListeners();
        },
        limit: 7,
      ),
    );
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
