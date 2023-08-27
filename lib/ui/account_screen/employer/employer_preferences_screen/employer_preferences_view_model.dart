import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/network/dtos/gigrr_type_response.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/local/preference_keys.dart';
import '../../../../data/network/dtos/employer_request_preferences_model.dart';
import '../../../../data/network/dtos/get_businesses_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../domain/repos/business_repos.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;

import '../../../../domain/repos/candidate_repos.dart';
import '../../../../others/constants.dart';
import '../../../widgets/location_helper.dart';

class EmployerPreferenceViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final gigrrsPref = locator<EmployerRequestPreferencesResp>();

  final user = locator<UserAuthResponseData>();
  final businessTypeService = locator<BusinessTypeService>();
  final businessRepo = locator<BusinessRepo>();
  final candidateRepo = locator<CandidateRepo>();
  final authRepo = locator<Auth>();
  int maxDiscount = 20;
  double max = 1000;
  List<GigrrTypeCategoryData> addSkillItemList = [];
  RangeValues currentRangeValues = const RangeValues(100, 400);
  final List<String> availShitList = ["day", "evening", "night"];
  List<String> genderList = ["male", "female", "other"];
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  String initialGender = "male";
  TextEditingController addressController =
      TextEditingController(text: "i.e. House no., Street name, Area");
  TextEditingController formDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  List<GetBusinessesData> businessesList = <GetBusinessesData>[];
  bool isVisible = false;

  LatLng latLng = const LatLng(14.508, 46.048);
  Location location = Location();

  Future<void> refreshScreen() async {
    businessesList = [];
    await fetchAllBusinessesApi();
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> initState() async {
    formDateController.text = dateNow;
    toDateController.text = dateNow;
    await refreshScreen();
    if (gigrrsPref.businessId.isEmpty && gigrrsPref.address.isEmpty) {
      await acquireCurrentLocation();
    }
    if (gigrrsPref.businessId.isNotEmpty) setGigrrPreference();
    setBusy(false);
    log("SDFDfd ${gigrrsPref.toJson()}");
  }

  void setGigrrPreference() {
    businessController.text = getBusinessName(gigrrsPref.businessId);
    addressController.text = gigrrsPref.address;
    initialGender = gigrrsPref.gender;
    latLng = LatLng(
      double.parse(gigrrsPref.latitude),
      double.parse(gigrrsPref.longitude),
    );
    formDateController.text = gigrrsPref.startDate;
    toDateController.text = gigrrsPref.endDate;
  }

  void setDistance(double? value) {
    maxDiscount = value!.toInt();
    notifyListeners();
  }

  void setPayRange(RangeValues? value) {
    currentRangeValues = value!;
    notifyListeners();
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void onItemSelect(String? val) {
    businessController.text = val!;
    print(val);
    notifyListeners();
  }

  void setAvailShit(String value) {
    initialGender = value;
    notifyListeners();
  }

  void setGigrrTypeSkills(GigrrTypeCategoryData value) {
    notifyListeners();
  }

  void setSkillsItem(GigrrTypeCategoryData e) {
    var isItem = addSkillItemList.contains(e);
    if (!isItem) {
      addSkillItemList.add(e);
    } else {
      addSkillItemList.remove(e);
    }
    notifyListeners();
  }

  void pickFormDate(DateTime dateTime) {
    formDateController.text = DateFormat("yyyy-MM-dd").format(dateTime);
    notifyListeners();
  }

  void pickToDate(DateTime dateTime) {
    toDateController.text = DateFormat("yyyy-MM-dd").format(dateTime);
    notifyListeners();
  }

  String get payRangeText =>
      "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/$initialGender";

  Future<void> acquireCurrentLocation() async {
    setBusy(true);
    var location = await LocationHelper.acquireCurrentLocation();
    await setAddressPlace(location);
    setBusy(false);
  }

  Future<void> setAddressPlace(LocationDataUpdate data) async {
    var coordinates = data.latLng;
    latLng = LatLng(
      coordinates.lat,
      coordinates.lng,
    );
    addressController.text = data.mapBoxPlace.placeName;
    notifyListeners();
  }

  Future<void> mapBoxPlace() async {
    navigationService.navigateWithTransition(
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
          notifyListeners();
        },
        limit: 7,
      ),
    );
    setBusy(false);
    notifyListeners();
  }

  bool validationAddPreference() {
    if (businessController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "plz_sel_pref_business".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> loadAddPreference() async {
    if (validationAddPreference()) {
      setBusy(true);
      var data = await _getRequestForAddPreference();
      locator.unregister<EmployerRequestPreferencesResp>();
      locator.registerSingleton<EmployerRequestPreferencesResp>(data);
      await sharedPreferences.setString(
        PreferenceKeys.GIGRR_PREFERENCES.text,
        json.encode(data),
      );
      navigationService.back();
      setBusy(false);
    }
    notifyListeners();
  }

  Future<void> fetchAllBusinessesApi() async {
    setBusy(true);
    final response = await businessRepo.fetchAllBusinessesApi();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (response) async {
        businessesList = response.businessesList;
        notifyListeners();
        setBusy(false);
      },
    );
    setBusy(false);
    notifyListeners();
  }

  Future<EmployerRequestPreferencesResp> _getRequestForAddPreference() async {
    Map<String, String> request = {};

    request['gig_name'] = nameController.text;
    request['business_id'] = getBusinessId(businessController.text);
    request['address'] = addressController.text;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    request['distance'] = maxDiscount.toString();
    request['start_date'] = formDateController.text;
    request['end_date'] = toDateController.text;
    request['gender'] = initialGender;
    request['skills'] = addSkillItemList.map((e) => e.id).join(",");

    return EmployerRequestPreferencesResp.fromJson(request);
  }

  String getBusinessId(String txt) {
    String id = "";
    for (var i in businessesList) {
      if (i.businessName == txt) {
        id = i.id.toString();
      }
    }
    return id;
  }

  String getBusinessName(String txt) {
    String name = "";
    for (var i in businessesList) {
      if (i.id == int.parse(txt)) {
        name = i.businessName;
      }
    }
    return name;
  }
}
