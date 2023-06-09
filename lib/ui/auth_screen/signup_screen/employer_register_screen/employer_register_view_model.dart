import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../util/enums/latLng.dart';

class EmployerRegisterViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();

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
  String country = "+91";
  double longitude = 0.0;
  String address = "";
  Location location = Location();
  PageController controller = PageController();
  int pageIndex = 0;
  List<String>? imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;
  bool isMobileRead = false;
  bool _loading = false;
  bool isSocialLogin = false;

  bool get loading => _loading;

  EmployerRegisterViewModel(
      {String mobile = "", bool isMobileRead = false, bool isSocial = false}) {
    mobileController.text = mobile;
    this.isMobileRead = isMobileRead;
    this.isSocialLogin = isSocial;
    businessTypeController.text =
        businessTypeService.businessTypeList.first.id.toString();
    acquireCurrentLocation();
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
      // navigationService.navigateTo(
      //   Routes.employerBusinessInfoFormView,
      //   arguments: EmployerBusinessInfoFormViewArguments(
      //     fullName: fullNameController.text,
      //     mobileNumber: mobileController.text,
      //   ),
      // );
    }
  }

  void acquireCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      _loading = true;
      final locationData = await location.getLocation();
      print("locationData ${locationData.latitude}");

      var map = mapBox.MapBoxGeoCoding(
        apiKey: MAPBOX_TOKEN,
      );

      var getAddress = await map.getAddress(
        mapBox.Location(
          lat: locationData.latitude ?? 0.0,
          lng: locationData.longitude ?? 0.0,
        ),
      );
      var addressData = getAddress!.first;
      print("addressData $addressData");
      await setAddressPlace(addressData);

      latLng =
          LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      _loading = false;
      notifyListeners();
    } else {
      serviceEnabled = await location.requestService();
      return;
    }
    notifyListeners();
  }

  Future<void> setAddressPlace(mapBox.MapBoxPlace mapBoxPlace) async {
    print("$mapBoxPlace");
    _loading = true;
    var addressData = mapBoxPlace.context ?? [];

    addressController.text = mapBoxPlace.placeName ?? "";
    cityController.text = addressData[2].text ?? "";
    stateController.text = addressData[4].text ?? "";
    pinCodeController.text = addressData[0].text ?? "";
    _loading = false;
    notifyListeners();
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
          _loading = true;
          addressController.text = place.placeName ?? "";
          cityController.text = addressData[2].text ?? "";
          stateController.text = addressData[4].text ?? "";
          pinCodeController.text = addressData[0].text ?? "";
          latLng = LatLng(
              place.geometry!.coordinates![1], place.geometry!.coordinates![0]);
          _loading = false;
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
          // snackBarService.showSnackbar(message: "");
          employerCompleteProfileApiCall();
          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  void employerCompleteProfileApiCall() async {
    // print("employerCompleteProfileApiCall  ${imageList!.first}");
    setBusy(true);
    final response = await authRepo
        .employerCompleteProfile(await _getRequestForEmployerCompleteProfile());
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

  Future<void> navigationToEmployerComplete(UserAuthResponseData res) async {
    if (isSocialLogin) {
      var result = await navigationService.navigateTo(
        Routes.oTPVerifyScreen,
        arguments: OTPVerifyScreenArguments(
          mobile: res.mobile,
          otpType: "sms",
          roleId: res.roleId,
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
    Map<String, String> request = {};
    request['business_type'] = businessTypeController.text.toString();
    request['business_name'] = businessNameController.text;
    request['business_address'] = addressController.text;
    request['business_latitude'] = latLng.lat.toString();
    request['business_longitude'] = latLng.lng.toString();
    request['images'] = imageList!.join(', ');
    log("Body Add Business :: $request");
    return request;
  }

  Future<Map<String, String>> _getRequestForEmployerCompleteProfile() async {
    Map<String, String> request = {};
    request['full_name'] = fullNameController.text;
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    request['address'] = addressController.text;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    log("Body Complete Profile >>> $request");
    return request;
  }
}
