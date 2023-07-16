import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;
import 'package:location/location.dart';
import 'package:square_demo_architecture/data/network/dtos/user_auth_response_data.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../util/enums/latLng.dart';

class CandidateRegisterViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();
  TextEditingController gigrrTypeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController userExperiencesController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController costCriteriaController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  int experienceYear = 1;
  int experienceMonth = 0;
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  RangeValues currentRangeValues = const RangeValues(100, 400);
  LatLng latLng = const LatLng(14.508, 46.048);
  bool _loading = false;
  bool isSocialLogin = false;

  bool get loading => _loading;
  DateTime selectedDate = DateTime.now();
  bool isVisible = false;

  List<String> genderList = ["male", "female", "other"];
  String initialGender = "male";
  List<String> shiftList = ["day", "evening", "night"];
  String initialShift = "day";
  List<String> myAvailableList = ["weekdays", "weekends"];
  List<String> myAvailableSelectList = [];
  double latitude = 0.0;
  double longitude = 0.0;

  Location location = Location();
  PageController controller = PageController();

  int pageIndex = 0;

  List<String>? imageList = [];
  bool isListEmpty = true;
  bool fourImagesAdded = false;
  bool isMobileRead = false;

  CandidateRegisterViewModel({
    String mobile = "",
    bool isMobileRead = false,
    bool isSocial = false,
  }) {
    this.isSocialLogin = isSocial;
    mobileController.text = mobile;
    this.isMobileRead = isMobileRead;
    acquireCurrentLocation();
  }

  String get userExperience => "$experienceYear year $experienceMonth month";

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

  void setPayRange(RangeValues? value) {
    currentRangeValues = value!;
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

  void pickerExperienceYear(int index) {
    experienceYear = index;
    userExperiencesController.text = userExperience;
    notifyListeners();
  }

  void pickerExperienceMonth(int index) {
    experienceMonth = index;
    userExperiencesController.text = userExperience;
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
    print(
        "onAvailableItemSelect  ${myAvailableSelectList.toList().toString()}");
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

  String get payRangeText =>
      "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/${costCriteriaController.text}";

  void navigationToRoleFormView() {
    if (validationPersonalInfo()) {
      controller.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
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

  void setPickDate(DateTime picked) {
    selectedDate = picked;
    dobController.text = DateFormat("yyyy-MM-dd").format(selectedDate);
    notifyListeners();
  }

  bool validationPersonalInfo() {
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
    } else if (addressController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_address".tr(),
      );
      return false;
    } else if (cityController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_city".tr(),
      );
      return false;
    } else if (stateController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_state".tr(),
      );
      return false;
    } else if (pinCodeController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_pinCode".tr(),
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

  void candidateCompleteProfileApiCall() async {
    setBusy(true);
    final response = await authRepo.candidatesCompleteProfile(
      await _getRequestForCompleteCandidateProfile(),
    );
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (res) async {
        await navigationToCandidateComplete(res);
        setBusy(false);
      },
    );
    notifyListeners();
  }

  Future<void> navigationToCandidateComplete(
    UserAuthResponseData res,
  ) async {
    print("isSocialLogin $isSocialLogin");
    navigationService.navigateTo(
      Routes.candidateKYCScreenView,
      arguments: CandidateKYCScreenViewArguments(
        isSocial: isSocialLogin,
      ),
    );
  }

  Future<Map<String, String>> _getRequestForCompleteCandidateProfile() async {
    Map<String, String> request = Map();
    request['full_name'] = fullNameController.text;
    request['country_code'] = countryCode;
    request['mobile_no'] = mobileController.text;
    request['email'] = "";
    request['address'] = addressController.text;
    request['latitude'] = latitude.toString();
    request['longitude'] = longitude.toString();
    request['gender'] = initialGender.toLowerCase();
    request['dob'] = dobController.text;
    request['experience_year'] = "$experienceYear";
    request['experience_month'] = "$experienceMonth";
    request['price_from'] = currentRangeValues.start.toString();
    request['price_to'] = currentRangeValues.end.toString();
    request['price_criteria'] = costCriteriaController.text.toLowerCase();
    request['skills'] = gigrrTypeController.text;
    request['avaliblity'] = myAvailableSelectList.join(",");
    request['shift'] = initialShift.toLowerCase();
    request['images'] = imageList!.join(',');
    request['profile_image'] = imageList!.first;
    print(" body --------$request");
    return request;
  }
}
