import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../domain/reactive_services/business_type_service.dart';
import '../../domain/repos/auth_repos.dart';
import '../../domain/repos/business_repos.dart';
import '../../others/constants.dart';

class AddGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessTypeService = locator<BusinessTypeService>();
  final businessRepo = locator<BusinessRepo>();

  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController formTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  TextEditingController gigrrTypeController = TextEditingController();
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController gigrrNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var timeNow = DateFormat('hh:mm a').format(DateTime.now());
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  final authRepo = locator<Auth>();
  PageController controller = PageController();
  List<String> priceList = ["daily_price", "total_price"];
  int pageIndex = 0;
  String initialPrice = "daily_price";

  AddGigsViewModel() {
    setInitialDataTime();
    print("businessTypeController.text ${businessTypeController.text}");
  }

  void setInitialDataTime() {
    formTimeController.text = timeNow;
    toTimeController.text = timeNow;
    formDateController.text = dateNow;
    toDateController.text = dateNow;
    priceTypeController.text = "price";
    businessTypeController.text =
        businessTypeService.businessTypeList.first.id.toString();
    notifyListeners();
  }

  bool onWillPop() {
    controller.previousPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    return false;
  }

  void setPrice(String? val) {
    initialPrice = val!;
    priceTypeController.text = (val == "daily_price" ? "price" : "total");
    print(priceTypeController.text);
    notifyListeners();
  }

  void setPageIndex(int? val) {
    pageIndex = val!;
    notifyListeners();
  }

  void navigationToNextPage() {
    print("navigationToNextPage ${gigrrTypeController.text}");
    if (validateToGigrrInfo()) {
      controller.animateToPage(
        1,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }
  }

  void navigatorToBack() {
    if (pageIndex == 1) {
      onWillPop();
    } else
      navigationService.back();
  }

  bool validateToGigrrInfo() {
    if (gigrrNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter gig name.");
      return false;
    } else if (priceController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter price");
      return false;
    } else if (priceTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select cost criteria.");
      return false;
    } else if (businessTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select business.");
      return false;
    }
    return true;
  }

  bool validateToOperational() {
    if (formDateController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select from date.");
      return false;
    } else if (toDateController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select to date.");
      return false;
    } else if (formTimeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select from time.");
      return false;
    } else if (toTimeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select to time.");
      return false;
    }
    return true;
  }

  Future<void> selectDatePicker(
    BuildContext context, {
    required DateTime initialDate,
    required TextEditingController textController,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: independenceColor, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.black, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: independenceColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate = picked;
      // textController.text = DateFormat("dd MMM yyyy").format(selectedDate);
      textController.text = DateFormat("yyyy-MM-dd").format(selectedDate);
      notifyListeners();
    }
  }

  Future<void> selectTimePicker(
    BuildContext context, {
    required TimeOfDay initialTime,
    required TextEditingController textController,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: independenceColor,
              onSurface: Colors.black,
            ),
            buttonTheme: const ButtonThemeData(
              colorScheme: ColorScheme.light(
                primary: independenceColor,
              ),
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      selectedTime = picked;
      textController.text = picked.format(context);
      notifyListeners();
    }
  }

  Future<void> addGigrrApiCall() async {
    if (validateToOperational()) {
      setBusy(true);
      final response =
          await businessRepo.addGigs(await _getRequestForAddGigs());
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (gigs) async {
          snackBarService.showSnackbar(message: gigs.message);
          onWillPop();
          gigrrNameController.clear();
          priceController.clear();
          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForAddGigs() async {
    Map<String, String> request = Map();
    request['business_id'] = businessTypeController.text;
    request['gigrr_type'] = gigrrTypeController.text;
    request['gig_name'] = gigrrNameController.text;
    request['start_date'] = formDateController.text;
    request['end_date'] = toDateController.text;
    request['start_time'] = formTimeController.text;
    request['end_time'] = toTimeController.text;
    request['price_criteria'] = priceTypeController.text;
    request['from_amount'] = priceController.text.toString();
    request['to_amount'] = priceController.text.toString();

    log("getRequestForCompleteProfile :: $request");
    return request;
  }
}
