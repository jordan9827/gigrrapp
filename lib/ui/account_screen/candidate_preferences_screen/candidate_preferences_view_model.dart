import 'package:easy_localization/easy_localization.dart';
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
  List<GigrrTypeCategoryList> addSkillItemList = [];
  RangeValues currentRangeValues = const RangeValues(100, 400);
  final List<String> availShitList = ["Day", "Evening", "Night"];
  String initialAvailShit = "Day";
  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var dateNow = DateFormat('dd MMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();

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

  init() async {
    // setBusy(true);
    // await businessRepo.gigrrTypeCategory();
    // setBusy(false);
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

  void setSkillsItem(GigrrTypeCategoryList e) {
    var isItem = addSkillItemList.contains(e);
    if (!isItem) {
      addSkillItemList.add(e);
    } else {
      addSkillItemList.remove(e);
    }
    print("Add List ${addSkillItemList.toList()}");
    notifyListeners();
  }

  void pickFormDate(DateTime dateTime) {
    formDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }

  void pickToDate(DateTime dateTime) {
    toDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }

  String get payRangeText =>
      "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/day";
}
