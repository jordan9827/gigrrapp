import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_mapbox_autocomplete/flutter_mapbox_autocomplete.dart'
    as auto;
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';

class CandidateRegisterViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  List<String> genderList = ["male", "female", "other"];
  String initialGender = "male";
  List<String> shiftList = ["day", "evening", "night"];
  String initialShift = "day";
  List<String> myAvailableList = ["weekdays", "weekends"];
  List<String> myAvailableSelectList = [];
  double latitude = 0.0;
  double longitude = 0.0;

  String address = "";
  Location location = Location();
  PageController controller = PageController();

  final Set<Marker> markers = {};
  int pageIndex = 0;

  List<String>? imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;

  CandidateRegisterViewModel({String mobile = "", String fullName = ""}) {
    fullNameController.text = fullName;
    mobileController.text = mobile;
    // acquireCurrentLocation();
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

  void setGender(String? val) {
    initialGender = val!;
    print("initialGender $initialGender");
    notifyListeners();
  }

  void setShift(String? val) {
    initialShift = val!;
    print("initialShift $initialShift");
    notifyListeners();
  }

  void onAvailableItemSelect(bool selected, int index) {
    if (selected == true) {
      myAvailableSelectList.add(myAvailableList[index]);
    } else {
      myAvailableSelectList.remove(myAvailableList[index]);
    }
    notifyListeners();
  }

  Future<void> markersLoadData() async {
    markers.add(
      Marker(
        markerId: MarkerId(""),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(latitude, longitude),
      ),
    );

    notifyListeners();
  }

  void navigatorToBack() {
    if (!isBusy) {
      controller.previousPage(
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
    return;
  }

  void updateEmptyItem(val) {
    isListEmpty = val;
    notifyListeners();
  }

  void navigationToRoleFormView() {
    // if (validationCompleteProfile()) {
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
    // }
  }

  void acquireCurrentLocation() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (serviceEnabled) {
      setBusy(true);
      final locationData = await location.getLocation();
      print("locationData ${locationData.latitude}");

      var map = mapBox.ReverseGeoCoding(
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
      await setAddressPlace(addressData as auto.MapBoxPlace);
      notifyListeners();
    } else {
      serviceEnabled = await location.requestService();
      return;
    }
    notifyListeners();
  }

  Future<void> setAddressPlace(auto.MapBoxPlace mapBoxPlace) async {
    print("$mapBoxPlace");
    setBusy(true);
    var addressData = mapBoxPlace.context ?? [];

    addressController.text = mapBoxPlace.placeName ?? "";
    cityController.text = addressData[2].text ?? "";
    stateController.text = addressData[4].text ?? "";
    pinCodeController.text = addressData[0].text ?? "";
    latitude = mapBoxPlace.geometry!.coordinates![1];
    longitude = mapBoxPlace.geometry!.coordinates![0];
    setBusy(false);
    notifyListeners();
  }

  void mapBoxPlace() {
    navigationService.navigateWithTransition(
      auto.MapBoxAutoCompleteWidget(
        apiKey: MAPBOX_TOKEN,
        hint: "Select Location",
        language: "en",
        country: "in",
        onSelect: (place) async {
          var addressData = place.context!;
          setBusy(true);
          await setAddressPlace(place);
          setBusy(false);
          notifyListeners();
        },
        limit: 7,
      ),
    );
  }

  void setPickDate(DateTime picked) {
    selectedDate = picked;
    // textController.text = DateFormat("dd MMM yyyy").format(selectedDate);
    dobController.text = DateFormat("yyyy-MM-dd").format(selectedDate);
    notifyListeners();
  }

  bool validationAddBusinessProfile() {
    if (myAvailableSelectList.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_businessName".tr(),
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
    } else if (dobController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_dob".tr(),
      );
      return false;
    } else if (imageList!.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_enter_image".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> addProfileApiCall() async {
    // if (validationAddBusinessProfile()) {}
    navigationService.navigateTo(
      Routes.candidateKYCScreenView,
    );
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
      (businessTypeResponse) => successBody(businessTypeResponse),
    );
    notifyListeners();
    setBusy(false);
  }

  Future<void> successBody(UserAuthResponseData res) async {
    await navigationService.navigateTo(
      Routes.oTPVerifyScreen,
      arguments: OTPVerifyScreenArguments(
        mobile: mobileController.text,
      ),
    );
    navigationToSignup(res);
    setBusy(false);
  }

  void navigationToSignup(UserAuthResponseData res) {
    if (res.status.toLowerCase() == "incompleted") {
      if (res.roleId == "3") {
        navigationService.clearStackAndShow(Routes.employerRegisterScreenView);
      } else {}
    } else
      navigationService.clearStackAndShow(Routes.homeView);
    setBusy(false);
  }

  Future<Map<String, String>> _getRequestForEmployerCompleteProfile() async {
    Map<String, String> request = {};
    request['full_name'] = fullNameController.text;
    request['country_code'] = "+91";
    request['mobile_no'] = mobileController.text;
    request['address'] = addressController.text;
    request['latitude'] = latitude.toString();
    request['longitude'] = longitude.toString();
    log("Body Complete Profile >>> $request");
    return request;
  }
}
