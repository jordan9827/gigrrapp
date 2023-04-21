import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';

class EmployeRegisterViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToBusinessFormView() {
    navigationService.navigateTo(Routes.employBusinessInfoFormView);
  }
}
