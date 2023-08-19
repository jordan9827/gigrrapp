import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/get_address_response.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../domain/repos/auth_repos.dart';
import '../../../../../domain/repos/common_repos.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/enums/latLng.dart';
import '../../../../../util/extensions/state_city_extension.dart';
import '../../../../../util/extensions/validation_address.dart';
import '../../../../widgets/location_helper.dart';

class AddAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final commonRepo = locator<CommonRepo>();
  final authRepo = locator<Auth>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  LatLng latLng = const LatLng(14.508, 46.048);
  bool isVisible = false;
  bool mapBoxLoading = false;
  bool defaultAddressSwitch = false;

  List<String> addressTypeList = ["home", "office", "other"];
  String addressTypeValue = "";
  int defaultAddressType = 0;

  AddAddressViewModel({
    required GetAddressResponseData data,
    bool isEdit = false,
  }) {
    if (isEdit) {
      setEditAddressData(data);
    }
    loadState();
  }

  setEditAddressData(GetAddressResponseData data) async {
    latLng = LatLng(
      double.parse(data.latitude),
      double.parse(data.longitude),
    );
    addressTypeValue = data.addressType;
    addressController.text = data.address;
    cityController.text = data.city.name;
    stateController.text = data.state.name;
    defaultAddressType = data.defaultAddress;
    defaultAddressSwitch = (data.defaultAddress == 1) ? true : false;
    pinCodeController.text = data.postCode;
    await LocationHelper.setCity(
      data.state.name.toUpperCase(),
    );
  }

  Future<void> loadState() async {
    setBusy(true);
    await authRepo.loadState();
    setBusy(false);
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back(result: false);
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

  Future<void> defaultSwitchAction(bool? val) async {
    defaultAddressSwitch = !defaultAddressSwitch;
    defaultAddressType = defaultAddressSwitch ? 1 : 0;
    notifyListeners();
  }

  Future<void> mapBoxPlace() async {
    mapBoxLoading = true;
    await navigationService.navigateWithTransition(
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
    await Future.delayed(Duration(milliseconds: 500));
    mapBoxLoading = false;
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
    stateController.text = addressData.state;
    pinCodeController.text = addressData.postCode;
    await LocationHelper.setCity(addressData.state);
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
      final response = await commonRepo.saveAddress(
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
    var stateId = StateCityHelper.findId(
      value: stateController.text,
    );
    var cityId = StateCityHelper.findId(
      isState: false,
      value: cityController.text,
    );
    request['address_type'] = addressTypeValue.toLowerCase();
    request['address'] = addressController.text;
    request['city_id'] = cityId;
    request['state_id'] = stateId;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    request['pincode'] = pinCodeController.text;
    request['is_default'] = "$defaultAddressType";
    return request;
  }
}
