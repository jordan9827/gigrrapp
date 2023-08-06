import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
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

  void navigationToAddBankAccountView() {
    navigationService.navigateTo(
      Routes.addBankAccountScreenView,
    );
  }

  Future<void> fetchAccountInfo() async {
    setBusy(true);
    final response = await accountRepo.fetchCandidateBankDetail();
    response.fold((failure) {
      setBusy(false);
    }, (bank) {
      bankInfoData = bank;
      setBusy(false);
      notifyListeners();
    });
  }
}
