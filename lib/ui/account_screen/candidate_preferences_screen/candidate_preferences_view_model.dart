import 'package:flutter/material.dart';
import 'package:square_demo_architecture/data/network/dtos/gigrr_type_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/reactive_services/business_type_service.dart';
import '../../../domain/repos/auth_repos.dart';
import '../../../domain/repos/business_repos.dart';

class CandidatePreferenceViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final businessTypeService = locator<BusinessTypeService>();
  final businessRepo = locator<BusinessRepo>();
  final authRepo = locator<Auth>();
  int maxDiscount = 20;
  double max = 1000;

  RangeValues currentRangeValues = const RangeValues(100, 400);
  final List<String> availShitList = ["Day", "Evening", "Night"];
  String initialAvailShit = "Day";

  Future<void> init() async {
    setBusy(true);
    await businessRepo.gigrrTypeCategory();
    setBusy(false);
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
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

  void setGigrrTypeSkills(GigrrTypeCategoryList value) {
    notifyListeners();
  }

  String get payRangeText =>
      "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/day";
}
