import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class PaymentHistoryViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }
}
