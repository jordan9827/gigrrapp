import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class HelpSupportScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  bool isVisible = false;

  void onActionVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToChatView() {
    navigationService.navigateTo(Routes.chatScreenView);
  }

  void navigationToSupportEmailView() {
    navigationService.navigateTo(Routes.supportEmailScreenView);
  }
}
