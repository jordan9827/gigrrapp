import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../app/app.locator.dart';
import '../../../../../../domain/repos/auth_repos.dart';

class CandidateKYCViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }
}
