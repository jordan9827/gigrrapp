import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';

class SettingScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToShareEarnScreen() {
    navigationService.navigateTo(Routes.languageScreenView);
  }

  void navigationToLanguageScreen() {
    navigationService.navigateTo(Routes.languageScreenView);
  }

  void navigationToPaymentHistoryScreen() {
    //  navigationService.navigateTo(Routes.languageScreenView);
  }

  void navigationToAboutScreen() {
    //  navigationService.navigateTo(Routes.languageScreenView);
  }

  void navigationToHelpSupportScreen() {
    navigationService.navigateTo(Routes.helpSupportScreenView);
  }

  void navigationToPrivacyPolicyScreen() {
    //  navigationService.navigateTo(Routes.languageScreenView);
  }
}
