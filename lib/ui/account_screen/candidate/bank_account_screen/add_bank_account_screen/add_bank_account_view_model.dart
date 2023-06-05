import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';

class AddBankAccountViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  bool validationAddBankAccount() {
    if (bankNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "".tr());
      return false;
    } else if (accountNumberController.text.isEmpty) {
      snackBarService.showSnackbar(message: "".tr());
      return false;
    } else if (ifscCodeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "".tr());
      return false;
    } else if (accountTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "".tr());
      return false;
    }
    return true;
  }
}
