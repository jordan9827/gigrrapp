import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';
import 'package:square_demo_architecture/util/extensions/validation_address.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/local/preference_keys.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import 'package:mapbox_search/mapbox_search.dart';
import '../../../domain/repos/auth_repos.dart';
import '../../../others/constants.dart';
import '../../widgets/location_helper.dart';

class EditProfileViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final authRepo = locator<Auth>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  LatLng latLng = const LatLng(14.508, 46.048);
  double latitude = 0.0;
  double longitude = 0.0;
  bool mapBoxLoading = false;
  List<String> imageList = [];

  EditProfileViewModel() {
    setInitData();
  }

  Future<void> setInitData() async {
    mapBoxLoading = true;
    fullNameController.text = user.fullName;
    mobileController.text = user.mobile;
    addressController.text = user.address;
    stateController.text = user.stateName;
    cityController.text = user.cityName;
    imageList.add(user.imageUrl);
    latLng = LatLng(
      double.parse(user.latitude),
      double.parse(user.longitude),
    );
    log("latLng ${latLng.lat} && ${latLng.lng}");

    setBusy(true);
    await authRepo.loadState();
    setBusy(false);
    mapBoxLoading = false;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  bool validationCompleteProfile() {
    if (fullNameController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_name".tr(),
      );
      return false;
    } else if (mobileController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_mobile".tr(),
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
    await LocationHelper.setCity(stateController.text);
    pinCodeController.text = addressData.postCode;
    mapBoxLoading = false;
    notifyListeners();
  }

  Future<void> editProfileApiCall() async {
    if (validationCompleteProfile()) {
      setBusy(true);
      final response =
          await authRepo.editProfile(await _getRequestForEditProfile());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (resp) async {
          await loadSuccessRes();
          snackBarService.showSnackbar(message: resp.message);
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForEditProfile() async {
    Map<String, String> request = {};
    request['full_name'] = fullNameController.text;
    request['profile_image'] = imageList.first;
    request['address'] = addressController.text;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    log("Edit Profile Request : $request");
    return request;
  }

  Future<void> loadSuccessRes() async {
    await sharedPreferences.clear();
    await locator.reset();
    await setupLocator();
    locator<FCMService>().deleteToken();
    await sharedPreferences.setBool(PreferenceKeys.FIRST_TIME.text, false);
    navigationService.clearStackAndShow(Routes.loginView);
    setBusy(false);
  }
}
