import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/fetch_bank_detail_response.dart';
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
  bool isVisible = false;

  AddBankAccountViewModel(GetBankDetailResponseData data, bool isEdit) {
    if (isEdit) {
      holderNameController.text = data.holderName;
      bankNameController.text = data.bankName;
      accountNumberController.text = data.accountNumber;
      accountTypeController.text = data.accountType;
      ifscCodeController.text = data.ifscCode;
    }
  }
  final List<String> accountTypeList = [
    "saving_acc",
    "current_acc",
    "recurring_dep"
  ];

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back(result: false);
    }
    return;
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void onItemSelectForAccountType(String? val) {
    accountTypeController.text = val ?? "";
    notifyListeners();
  }

  bool validationAddBankAccount() {
    if (holderNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_holder_name".tr());
      return false;
    } else if (bankNameController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_bank_name".tr());
      return false;
    } else if (accountNumberController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_acc_no".tr());
      return false;
    } else if (ifscCodeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_ifsc_code".tr());
      return false;
    } else if (ifscCodeController.text.isNotEmpty &&
        !validateIFSC(ifscCodeController.text)) {
      snackBarService.showSnackbar(message: "plz_enter_valid_ifsc_code".tr());
      return false;
    } else if (accountTypeController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_acc_type".tr());
      return false;
    }
    return true;
  }

  Future<void> addBankAccount() async {
    if (validationAddBankAccount()) {
      setBusy(true);
      var result = await accountRepo.addBankAccount(
        await _getRequestForAddBankAccount(),
      );
      result.fold((fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      }, (res) {
        navigationService.back(result: true);
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
    return request;
  }
}
