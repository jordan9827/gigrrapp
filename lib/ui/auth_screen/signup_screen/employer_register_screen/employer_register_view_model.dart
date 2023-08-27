import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:flutter/cupertino.dart';
import '../../../../util/extensions/state_city_extension.dart';
import 'package:location/location.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/reactive_services/state_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../util/enums/latLng.dart';
import '../../../../util/extensions/validation_address.dart';
import '../../../widgets/location_helper.dart';

class EmployerRegisterViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();
  final stateCityService = locator<StateCityService>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  bool mapBoxLoading = false;

  LatLng latLng = const LatLng(14.508, 46.048);
  String address = "";
  Location location = Location();
  PageController controller = PageController();
  int pageIndex = 0;
  List<String> imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;
  bool isMobileRead = false;
  bool _loading = true;
  bool isSocialLogin = false;
  String socialType = "";
  String socialId = "";

  bool get loading => _loading;

  EmployerRegisterViewModel({
    String mobile = "",
    bool isMobileRead = false,
    String socialType = "",
    String socialId = "",
    bool isSocial = false,
  }) {
    mobileController.text = mobile;
    this.isMobileRead = isMobileRead;
    this.isSocialLogin = isSocial;
    this.socialType = socialType;
    this.socialId = socialId;
    initial();
    if (businessTypeService.businessTypeList.isNotEmpty) {
      businessTypeController.text =
          businessTypeService.businessTypeList.first.id.toString();
    }
  }

  Future<void> initial() async {
    await businessTypeCategoryApiCall();
    acquireCurrentLocation();
    await authRepo.loadState();
    setBusy(false);
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    await businessRepo.businessTypeCategory();
  }

  bool onWillPop() {
    if (pageIndex == 0) {
      navigationService.back();
    } else {
      controller.previousPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
    return false;
  }

  void setBool(bool val) {
    setBusy(val);
    notifyListeners();
  }

  void setPageIndex(int? val) {
    pageIndex = val!;
    notifyListeners();
  }

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void updateEmptyItem(val) {
    isListEmpty = val;
    notifyListeners();
  }

  void navigationToBusinessFormView() {
    if (validationCompleteProfile()) {
      controller.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
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
    _loading = false;
    notifyListeners();
  }

  Future<void> setCity() async {
    for (var i in stateCityService.stateList) {
      if (i.name == stateController.text) {
        await authRepo.loadCity(i.id);
      }
    }
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
          _loading = true;
          setAddressPlace(
            LocationDataUpdate(
              mapBoxPlace: place,
              latLng: LatLng(
                place.coordinates!.latitude,
                place.coordinates!.longitude,
              ),
            ),
          );
          _loading = false;
          notifyListeners();
        },
        limit: 7,
      ),
    );
    await Future.delayed(Duration(milliseconds: 500));
    mapBoxLoading = false;
    _loading = false;
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
        (businessTypeResponse) async {
          employerCompleteProfileApiCall();
          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  void employerCompleteProfileApiCall() async {
    setBusy(true);
    final response = await authRepo.employerCompleteProfile(
      await _getRequestForEmployerCompleteProfile(),
    );
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (res) async {
        await navigationToEmployerComplete(res);
        setBusy(false);
      },
    );
    notifyListeners();
    setBusy(false);
  }

  Future<void> navigationToEmployerComplete(
    UserAuthResponseData res,
  ) async {
    if (isSocialLogin) {
      print("navigationToEmployerComplete");
      var result = await navigationService.navigateTo(
        Routes.oTPVerifyScreen,
        arguments: OTPVerifyScreenArguments(
          mobile: res.mobile,
          roleId: res.roleId,
          socialId: socialId,
          socialType: socialType,
          loginType: "social",
        ),
      );
      if (result["isCheck"]) {
        navigationToHomeScreen();
      }
    } else {
      navigationToHomeScreen();
    }
  }

  void navigationToHomeScreen() {
    navigationService.navigateTo(
      Routes.homeView,
    );
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

  Future<Map<String, String>> _getRequestForEmployerCompleteProfile() async {
    var stateId = StateCityHelper.findId(
      value: stateController.text,
    );
    var cityId = StateCityHelper.findId(
      isState: false,
      value: cityController.text,
    );
    Map<String, String> request = {};
    request['full_name'] = fullNameController.text;
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    request['address'] = addressController.text;
    request['state'] = stateId;
    request['city'] = cityId;
    request['pincode'] = pinCodeController.text;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    log("Body Complete Profile >>> $request");
    return request;
  }
}
