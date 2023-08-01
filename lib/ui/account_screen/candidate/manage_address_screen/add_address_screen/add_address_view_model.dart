import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../domain/repos/account_repos.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/enums/latLng.dart';
import '../../../../../util/extensions/validation_address.dart';
import '../../../../widgets/location_helper.dart';

class AddAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final accountRepo = locator<AccountRepo>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  LatLng latLng = const LatLng(14.508, 46.048);
  bool isVisible = false;

  List<String> addressTypeList = ["home", "office", "other"];
  String addressTypeValue = "";

  AddAddressViewModel({
    String addressType = "",
    String address = "",
    String city = "",
    String state = "",
    String pinCode = "",
  }) {
    addressTypeValue = addressType;
    addressController.text = address;
    cityController.text = city;
    stateController.text = state;
    pinCodeController.text = pinCode;
  }

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
        language: languageCode,
        country: countryType,
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

  bool validationSaveAddress() {
    if (addressTypeValue.isEmpty) {
      snackBarService.showSnackbar(
        message: "sel_address_type".tr(),
      );
      return false;
    }
    return AddressValidationHelper.validationSaveAddress(
      address: addressController.text,
      city: cityController.text,
      state: stateController.text,
      pinCode: pinCodeController.text,
    );
  }

  Future<void> loadSaveAddress() async {
    if (validationSaveAddress()) {
      setBusy(true);
      final response = await accountRepo.saveAddress(
        await _getRequestForSaveAddress(),
      );
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (resp) {
          navigationService.back(result: true);
          snackBarService.showSnackbar(message: resp.message);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForSaveAddress() async {
    Map<String, String> request = {};
    request['address_type'] = addressTypeValue.toLowerCase();
    request['address'] = addressController.text;
    request['city_id'] = cityController.text;
    request['state_id'] = stateController.text;
    request['pincode'] = pinCodeController.text;
    return request;
  }
}
