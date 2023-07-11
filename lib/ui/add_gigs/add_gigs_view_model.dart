import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/get_businesses_response.dart';
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
  List<GetBusinessesData> businessesList = <GetBusinessesData>[];

  DateTime selectedDate = DateTime.now();
  var timeNow = DateFormat('hh:mm a').format(DateTime.now());
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  RangeValues currentRangeValues = const RangeValues(100, 1000);

  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  final authRepo = locator<Auth>();
  PageController controller = PageController();
  int pageIndex = 0;
  bool isVisible = false;
  String groupValue = "";

  AddGigsViewModel() {
    setInitialDataTime();
    print("businessTypeController.text ${businessTypeController.text}");
  }

  void setInitialDataTime() {
    formTimeController.text = timeNow;
    toTimeController.text = timeNow;
    formDateController.text = dateNow;
    toDateController.text = dateNow;
    priceTypeController.text = "hourly";
    refreshScreen();
    notifyListeners();
  }

  Future<void> refreshScreen() async {
    businessesList = [];
    await fetchAllBusinessesApi();
    notifyListeners();
  }

  void onItemSelect(String? val) {
    groupValue = val!;
    print(val);
    onSelectId();
    notifyListeners();
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void setPayRange(RangeValues? value) {
    currentRangeValues = value!;
    notifyListeners();
  }

  String get payRangeText {
    return "₹ ${currentRangeValues.start.toInt()} - ${currentRangeValues.end.toInt()}/${priceTypeController.text}";
  }

  void onSelectId() {
    for (var i in businessesList) {
      if (i.businessName == groupValue) {
        businessTypeController.text = i.id.toString();
        notifyListeners();
      }
    }
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

  void setPageIndex(int? val) {
    pageIndex = val!;
    notifyListeners();
  }

  void navigationToNextPage() {
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
    } else if (priceTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select cost criteria.");
      return false;
    } else if (gigrrTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please select Gigrr Type");
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
        (gigs) {
          // snackBarService.showSnackbar(message: gigs.message);
          navigationService.clearStackAndShow(
            Routes.homeView,
            arguments: HomeViewArguments(initialIndex: 1),
          );
          gigrrNameController.clear();
          priceController.clear();
          snackBarService.showSnackbar(message: gigs.message);
          notifyListeners();
          setBusy(false);
        },
      );
      notifyListeners();
    }
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
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForAddGigs() async {
    Map<String, String> request = Map();
    request['business_id'] = businessTypeController.text;
    request['gigrr_type'] = gigrrTypeController.text;
    request['gig_name'] = gigrrNameController.text.capitalize();
    request['start_date'] = formDateController.text;
    request['end_date'] = toDateController.text;
    request['start_time'] = formTimeController.text;
    request['end_time'] = toTimeController.text;
    request['price_criteria'] = priceTypeController.text.toLowerCase();
    request['from_amount'] = currentRangeValues.start.toString();
    request['to_amount'] = currentRangeValues.end.toString();
    log("getRequestForCompleteProfile :: $request");
    return request;
  }
}
