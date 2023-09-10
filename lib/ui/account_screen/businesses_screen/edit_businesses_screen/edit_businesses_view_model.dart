import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/business_repos.dart';
import '../../../../others/constants.dart';
import 'package:mapbox_search/mapbox_search.dart' as auto;

import '../../../../util/enums/latLng.dart';
import '../../../../util/extensions/state_city_extension.dart';
import '../../../widgets/location_helper.dart';

class EditBusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  bool mapBoxLoading = false;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  int businessId = 0;
  LatLng latLng = const LatLng(14.508, 46.048);

  List<String> imageList = [];

  EditBusinessesViewModel(GetBusinessesData data) {
    latLng = LatLng(
      double.parse(data.latitude),
      double.parse(data.longitude),
    );
  }

  Future<void> initialDataLoad(GetBusinessesData e) async {
    imageList = e.businessesImage.map((e) => e.imageUrl).toList();
    businessNameController.text = e.businessName;
    addressController.text = e.businessAddress;
    stateController.text = e.state.name.toUpperCase();
    cityController.text = e.cityList.first.name;
    pinCodeController.text = e.postCode.toString();
    businessTypeController.text = e.categoryResp.id.toString();
    await LocationHelper.setCity(
      e.state.name.toUpperCase(),
    );
    businessId = e.id;
    print("imageList ${imageList.length}");
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back(result: false);
    }
    return;
  }

  Future<void> mapBoxPlace() async {
    mapBoxLoading = true;
    await navigationService.navigateWithTransition(
      auto.MapBoxAutoCompleteWidget(
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
    pinCodeController.text = addressData.postCode;
    await LocationHelper.setCity(addressData.state);
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

  Future<void> updateBusinessProfileApiCall() async {
    if (validationAddBusinessProfile()) {
      setBusy(true);
      final response = await businessRepo.updateBusinessProfile(
        await _getRequestForUpdateBusiness(),
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
    }
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForUpdateBusiness() async {
    Map<String, String> request = {};
    var stateId = StateCityHelper.findId(
      value: stateController.text,
    );
    var cityId = StateCityHelper.findId(
      isState: false,
      value: cityController.text,
    );
    request['business_id'] = businessId.toString();
    request['business_type'] = businessTypeController.text;
    request['business_name'] = businessNameController.text;
    request['business_address'] = addressController.text;
    request['state'] = stateId;
    request['city'] = cityId;
    request['pincode'] = pinCodeController.text;
    request['business_latitude'] = latLng.lat.toString();
    request['business_longitude'] = latLng.lng.toString();
    request['images'] = imageList.join(', ');
    // log("getRequestForCompleteProfile :: $request");
    return request;
  }
}
