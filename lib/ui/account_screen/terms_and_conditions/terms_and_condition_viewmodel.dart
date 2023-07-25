import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../domain/repos/account_repos.dart';

class TermsAndConditionViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final accountRepo = locator<AccountRepo>();

  String _content = "";

  String get content => _content;
  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
  }

  Future<void> getTermsAndCondition() async {
    setBusy(true);
    final response = await accountRepo.termsAndCondition();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (success) async {
        _content = success.content;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
