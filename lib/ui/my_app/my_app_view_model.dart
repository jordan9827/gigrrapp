import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../data/network/dtos/user_auth_response_data.dart';

class MyAppViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final log = getLogger('Splash Screen View');
  final userData = locator<UserAuthResponseData>();

  late final bool isFirstTime;
  var initialRoute = Routes.loginView;
  final dialogService = locator<DialogService>();

  MyAppViewModel() {
    setInitialRoute();
  }

  void setInitialRoute() {
    if (userData.accessToken.isNotEmpty && userData.status != "incompleted") {
      initialRoute = Routes.homeScreenView;
    }
    notifyListeners();
  }

  Future<bool> routeUser() async {
    return true;
  }
}
