import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class HelpSupportScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }
}
