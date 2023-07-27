import 'package:easy_localization/easy_localization.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/util/others/internet_check_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NoInternetViewModel extends BaseViewModel {
  final internetCheckService = locator<InternetCheckService>();
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();

  Future<void> checkInterNetStatus() async {
    setBusy(true);
    final isInterNetConnected =
        await internetCheckService.checkInterNetConnection();
    if (isInterNetConnected) {
      navigationService.back();
    } else {
      snackBarService.showSnackbar(message: "msg_for_no_internet_snack".tr());
    }
    setBusy(false);
  }
}
