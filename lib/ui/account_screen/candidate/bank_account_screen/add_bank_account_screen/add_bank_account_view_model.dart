import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../domain/repos/account_repos.dart';
import '../../../../../others/constants.dart';

class AddBankAccountViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final TextEditingController holderNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final accountRepo = locator<AccountRepo>();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  bool validationAddBankAccount() {
    if (holderNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter holder name.".tr());
      return false;
    } else if (bankNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter bank name,".tr());
      return false;
    } else if (accountNumberController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter account no.".tr());
      return false;
    } else if (accountNumberController.text.length <= 15) {
      snackBarService.showSnackbar(
          message: "Please enter valid account no.".tr());
      return false;
    } else if (ifscCodeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter IFSC code.".tr());
      return false;
    } else if (ifscCodeController.text.isNotEmpty &&
        !validateIFSC(ifscCodeController.text)) {
      snackBarService.showSnackbar(
          message: "Please enter valid IFSC code.".tr());
      return false;
    } else if (accountTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter account type.".tr());
      return false;
    }
    return true;
  }

  Future<void> addBankAccount() async {
    if (validationAddBankAccount()) {
      var result = await accountRepo
          .addBankAccount(await _getRequestForAddBankAccount());
      result.fold((fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      }, (res) {
        navigationService.back();
        snackBarService.showSnackbar(message: res.message);
        notifyListeners();
        setBusy(false);
      });
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForAddBankAccount() async {
    Map<String, String> request = {};
    request['account_holder_name'] = holderNameController.text;
    request['bank_name'] = bankNameController.text;
    request['account_number'] = accountNumberController.text;
    request['ifsc_code'] = ifscCodeController.text;
    request['account_type'] = accountTypeController.text;
    log("Body Add Bank Account>>> $request");
    return request;
  }
}
