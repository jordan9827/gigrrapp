import 'package:square_demo_architecture/domain/repos/account_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class AboutUsViewModel extends BaseViewModel {
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

  Future<void> getAboutUs() async {
    setBusy(true);
    final response = await accountRepo.aboutUs();
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
