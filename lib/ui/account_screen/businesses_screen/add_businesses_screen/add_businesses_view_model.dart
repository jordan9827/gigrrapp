import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../domain/repos/business_repos.dart';
import '../../../../others/constants.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:location/location.dart' as loc;
import '../../../../util/extensions/state_city_extension.dart';
import '../../../widgets/location_helper.dart';

class AddBusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  final authRepo = locator<Auth>();

  bool mapBoxLoading = false;
  final businessTypeService = locator<BusinessTypeService>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  int businessId = 0;
  LatLng latLng = const LatLng(14.508, 46.048);
  List<String> imageList = [];
  bool loading = true;
  loc.Location location = loc.Location();

  AddBusinessesViewModel() {
    initial();
    if (businessTypeService.businessTypeList.isNotEmpty) {
      businessTypeController.text =
          businessTypeService.businessTypeList.first.id.toString();
    }
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back(result: false);
    }
    return;
  }

  Future<void> initial() async {
    await businessTypeCategoryApiCall();
    acquireCurrentLocation();
    setBusy(false);
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    await businessRepo.businessTypeCategory();
  }

  Future<void> mapBoxPlace() async {
    mapBoxLoading = true;
    await navigationService.navigateWithTransition(
      MapBoxAutoCompleteWidget(
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

  void acquireCurrentLocation() async {
    mapBoxLoading = true;
    var location = await LocationHelper.acquireCurrentLocation();
    await setAddressPlace(location);
    mapBoxLoading = false;
  }

  Future<void> setAddressPlace(LocationDataUpdate data) async {
    var coordinates = data.latLng;
    latLng = LatLng(
      coordinates.lat,
      coordinates.lng,
    );
    var addressData = data.mapBoxPlace.placeContext;
    addressController.text = data.mapBoxPlace.placeName;
    stateController.text = addressData.state.toUpperCase();
    cityController.text = addressData.city.toUpperCase();
    pinCodeController.text = addressData.postCode;
    await LocationHelper.setCity(addressData.state);
    mapBoxLoading = false;
    notifyListeners();
  }

  bool validationAddBusinessProfile() {
    if (businessNameController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_businessName".tr(),
      );
      return false;
    } else if (imageList.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_upload_image".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> addBusinessProfileApiCall() async {
    if (validationAddBusinessProfile()) {
      setBusy(true);
      final response = await businessRepo
          .addBusinessProfile(await _getRequestForAddBusiness());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (res) {
          navigationService.back(result: true);
          snackBarService.showSnackbar(message: res.message);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForAddBusiness() async {
    var stateId = StateCityHelper.findId(
      value: stateController.text,
    );
    var cityId = StateCityHelper.findId(
      isState: false,
      value: cityController.text,
    );
    Map<String, String> request = {};
    request['business_type'] = businessTypeController.text.toString();
    request['business_name'] = businessNameController.text;
    request['business_address'] = addressController.text;
    request['state'] = stateId;
    request['city'] = cityId;
    request['pincode'] = pinCodeController.text;
    request['business_latitude'] = latLng.lat.toString();
    request['business_longitude'] = latLng.lng.toString();
    request['images'] = imageList.join(', ');
    log("Body Add Business :: $request");
    return request;
  }
}
