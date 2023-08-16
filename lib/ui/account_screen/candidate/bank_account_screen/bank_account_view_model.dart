import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/local/preference_keys.dart';
import '../../../../data/network/dtos/fetch_bank_detail_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/account_repos.dart';

class BankAccountViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final accountRepo = locator<AccountRepo>();
  GetBankDetailResponseData bankInfoData = GetBankDetailResponseData.init();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> navigationToAddAndEditBankAccountView(
      {bool isEdit = false}) async {
    var isCheck = await navigationService.navigateTo(
      Routes.addBankAccountScreenView,
      arguments: AddBankAccountScreenViewArguments(
        data: bankInfoData,
        isEdit: isEdit,
      ),
    );
    if (isCheck ?? false) {
      fetchAccountInfo();
    }
  }

  String get setAccountNo {
    if (bankInfoData.accountNumber.length >= 4) {
      return "XXXXXXXXXX" +
          bankInfoData.accountNumber
              .substring(bankInfoData.accountNumber.length - 4);
    } else
      return "";
  }

  Future<void> fetchAccountInfo() async {
    setBusy(true);
    final response = await accountRepo.fetchCandidateBankDetail();
    response.fold((failure) {
      setBusy(false);
    }, (bank) async {
      bankInfoData = bank;
      if (user.bankStatus == 0) await updateBankStatusToLocal(bank);
      setBusy(false);
      notifyListeners();
    });
  }

  Future<void> updateBankStatusToLocal(GetBankDetailResponseData bank) async {
    if (bank.id != 0 && bank.accountNumber.isNotEmpty) {
      UserAuthResponseData data = user.copyWith(bankStatus: 1);
      locator.unregister<UserAuthResponseData>();
      locator.registerSingleton<UserAuthResponseData>(data);
      await sharedPreferences.setString(
        PreferenceKeys.USER_DATA.text,
        json.encode(data),
      );
    }
  }
}
