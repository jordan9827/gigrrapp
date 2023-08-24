import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/fetch_upi_detail_response.dart';
import '../../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../../domain/repos/account_repos.dart';

class AddUpiViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final TextEditingController upiController = TextEditingController();

  final accountRepo = locator<AccountRepo>();

  AddUpiViewModel(GetUpiDetailResponseData data, bool isEdit) {
    upiController.text = data.upiId;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back(result: false);
    }
    return;
  }

  bool validationAddUpiId() {
    if (upiController.text.isEmpty) {
      snackBarService.showSnackbar(
        message: "plz_enter_upi_id".tr(),
      );
      return false;
    }
    /*else if (upiController.text.isNotEmpty &&
        !validateUpi(upiController.text)) {
      snackBarService.showSnackbar(
        message: "plz_enter_valid_upi".tr(),
      );
      return false;
    }*/
    return true;
  }

  Future<void> addUpiId() async {
    if (validationAddUpiId()) {
      setBusy(true);
      var result = await accountRepo.addUpiId(
        await _getRequestForAddUpiId(),
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

  Future<Map<String, String>> _getRequestForAddUpiId() async {
    Map<String, String> request = {};
    request['upi_id'] = upiController.text;
    return request;
  }
}
