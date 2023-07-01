import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import 'package:mapbox_search/mapbox_search.dart' as auto;
import '../../../domain/repos/auth_repos.dart';
import '../../../others/constants.dart';

class EditProfileViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final authRepo = locator<Auth>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: "House no., Street name, Area");
  LatLng latLng = const LatLng(14.508, 46.048);
  double latitude = 0.0;
  double longitude = 0.0;

  EditProfileViewModel() {
    setInitData();
  }

  void setInitData() {
    fullNameController.text = user.fullName;
    mobileController.text = user.mobile;
    addressController.text = user.address;
    latLng = LatLng(
      double.parse(user.latitude),
      double.parse(user.longitude),
    );
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
    return true;
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      auto.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        onSelect: (place) async {
          setBusy(true);
          addressController.text = place.placeName ?? "";
          latLng = LatLng(
              place.geometry!.coordinates![1], place.geometry!.coordinates![0]);
          setBusy(false);

          notifyListeners();
        },
        limit: 7,
      ),
    );
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
        (resp) {
          navigationService.back();
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
    request['address'] = addressController.text;
    request['latitude'] = latLng.latitude.toString();
    request['longitude'] = latLng.longitude.toString();
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    log("Edit Profile Request : $request");
    return request;
  }
}
