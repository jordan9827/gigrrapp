import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:square_demo_architecture/data/network/dtos/gigrr_type_response.dart';
import 'package:square_demo_architecture/util/enums/latLng.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/reactive_services/business_type_service.dart';
import '../../../../domain/repos/auth_repos.dart';
import '../../../../domain/repos/business_repos.dart';
import 'package:mapbox_search/mapbox_search.dart' as mapBox;

import '../../../../domain/repos/candidate_repos.dart';
import '../../../../others/constants.dart';
import '../../../widgets/location_helper.dart';

class CandidatePreferenceViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
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
  String initialAvailShit = "day";
  TextEditingController addressController =
      TextEditingController(text: "i.e. House no., Street name, Area");
  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  LatLng latLng = const LatLng(14.508, 46.048);
  Location location = Location();
  bool _loading = true;

  bool get loading => _loading;

  CandidatePreferenceViewModel() {
    formDateController.text = dateNow;
    toDateController.text = dateNow;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void initState() {
    acquireCurrentLocation();
  }

  void setDistance(double? value) {
    maxDiscount = value!.toInt();
    notifyListeners();
  }

  void setPayRange(RangeValues? value) {
    currentRangeValues = value!;
    notifyListeners();
  }

  void setAvailShit(String value) {
    initialAvailShit = value;
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
      "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/$initialAvailShit";

  void acquireCurrentLocation() async {
    var location = await LocationHelper.acquireCurrentLocation();
    await setAddressPlace(location);
  }

  Future<void> setAddressPlace(LocationDataUpdate data) async {
    var coordinates = data.latLng;
    latLng = LatLng(
      coordinates.lat,
      coordinates.lng,
    );
    addressController.text = data.mapBoxPlace.placeName;
    _loading = false;
    notifyListeners();
  }

  Future<void> mapBoxPlace() async {
    await navigationService.navigateWithTransition(
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
    await Future.delayed(Duration(milliseconds: 500));
    _loading = false;
    notifyListeners();
  }

  bool validationAddPreference() {
    if (addSkillItemList.isEmpty) {
      snackBarService.showSnackbar(
        message: "plz_sel_pref_skill".tr(),
      );
      return false;
    }
    return true;
  }

  Future<void> loadAddPreference() async {
    if (validationAddPreference()) {
      setBusy(true);
      final response = await candidateRepo.candidateSavePreference(
        await _getRequestForAddPreference(),
      );
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (res) async {
          navigationService.back();
          snackBarService.showSnackbar(message: res.message);
          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForAddPreference() async {
    Map<String, String> request = {};
    request['address'] = addressController.text;
    request['latitude'] = latLng.lat.toString();
    request['longitude'] = latLng.lng.toString();
    request['distance'] = maxDiscount.toString();
    request['pay-range-from'] = currentRangeValues.start.toString();
    request['pay-range-to'] = currentRangeValues.end.toString();
    request['avaliable-from'] = formDateController.text;
    request['avaliable-to'] = toDateController.text;
    request['shift'] = initialAvailShit;
    request['skills'] = addSkillItemList.map((e) => e.id).join(",");
    return request;
  }
}
