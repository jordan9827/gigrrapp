import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/business_repos.dart';
import '../../../../others/constants.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as auto;

class EditBusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController =
      TextEditingController(text: "House no., Street name, Area");
  int businessId = 0;
  LatLng latLng = const LatLng(14.508, 46.048);
  double latitude = 0.0;
  double longitude = 0.0;
  List<String>? imageList = [];

  EditBusinessesViewModel(GetBusinessesList data) {}

  void initialDataLoad(GetBusinessesList e) {
    businessNameController.text = e.businessName;
    addressController.text = e.businessAddress;
    businessTypeController.text = e.categoryResp.id.toString();
    businessId = e.id;
    for (var i in e.businessesImage) imageList!.add(i.imageUrl);
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      auto.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        onSelect: (place) async {
          var addressData = place.context!;
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

  bool validationAddBusinessProfile() {
    if (businessNameController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_businessName".tr(),
      );
      return false;
    } else if (imageList!.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_upload_image".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> updateBusinessProfileApiCall() async {
    if (validationAddBusinessProfile()) {
      setBusy(true);
      final response = await businessRepo
          .updateBusinessProfile(await _getRequestForUpdateBusiness());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (resp) {
          snackBarService.showSnackbar(message: resp.message);
          navigationService.back();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForUpdateBusiness() async {
    Map<String, String> request = {};
    request['business_id'] = businessId.toString();
    request['business_type'] = businessTypeController.text;
    request['business_name'] = businessNameController.text;
    request['business_address'] = addressController.text;
    request['business_latitude'] = latitude.toString();
    request['business_longitude'] = longitude.toString();
    request['images'] = imageList!.join(', ');
    log("getRequestForCompleteProfile :: $request");
    return request;
  }
}
