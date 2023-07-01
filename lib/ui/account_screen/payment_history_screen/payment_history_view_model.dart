import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/data/network/dtos/payment_history_response.dart';
import 'package:square_demo_architecture/domain/repos/account_repos.dart';
import 'package:square_demo_architecture/util/enums/dialog_type.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import 'widget/filter_dialog_view.dart';

class PaymentHistoryViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final accountRepo = locator<AccountRepo>();
  final user = locator<UserAuthResponseData>();
  TextEditingController nameController = TextEditingController();
  TextEditingController formDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  var timeNow = DateFormat('hh:mm a').format(DateTime.now());

  // var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var dateNow = DateFormat('dd MMM yyyy').format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  var _pageNumber = 0;
  int itemCount = 0;
  List<PaymentHistoryData> paymentList = [];
  var scrollController = ScrollController();
  bool _loading = false;

  bool get loading => _loading;

  PaymentHistoryViewModel() {
    formDateController.text = dateNow;
    toDateController.text = dateNow;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> refreshScreen() async {
    setBusy(true);
    paymentList = [];
    _pageNumber = 0;
    itemCount = 0;
    await fetchPayment();
    notifyListeners();
    setBusy(false);
  }

  void init() {
    fetchPayment();
    scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isBusy) _loading = true;
      await fetchPayment();
    }
    notifyListeners();
  }

  Future<void> fetchPayment() async {
    var result;
    _pageNumber = _pageNumber + 1;
    if (_pageNumber == 1) setBusy(true);
    if (!user.isEmployer) {
      result = await accountRepo.candidatePaymentHistory(
        page: _pageNumber,
        data: await _getRequestForCandidatePayment(),
      );
    } else {
      result = await accountRepo.employerPaymentHistory(
        page: _pageNumber,
        data: await _getRequestForCandidatePayment(),
      );
    }

    result.fold((fail) {
      paymentList = [];
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      paymentList.addAll(res.paymentHistoryData);
      log("paymentList ${paymentList.toList()}");
      _loading = false;
      setBusy(false);
    });
    setBusy(false);
    notifyListeners();
  }

  void showFilterDialog(PaymentHistoryViewModel viewModel) {
    final builders = {
      DialogType.paymentFilter: (_, request, completer) =>
          FilterDialogView(viewModel: viewModel),
    };

    dialogService.registerCustomDialogBuilders(builders);

    dialogService.showCustomDialog(
      variant: DialogType.paymentFilter,
    );
  }

  String filterStatusForPayment(String value) {
    String status = "";
    if (value == "completed") {
      status = "Successfully Paid";
    }
    return status;
  }

  void pickFormDate(DateTime dateTime) {
    formDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }

  void pickToDate(DateTime dateTime) {
    toDateController.text = DateFormat("dd MMM yyyy").format(dateTime);
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForCandidatePayment() async {
    Map<String, String> request = Map();
    // request['start_date'] = "";
    // request['end_date'] = "";
    // log("getRequestForLogIn :: $request");
    return request;
  }
}
