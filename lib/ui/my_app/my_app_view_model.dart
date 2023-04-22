import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';

class MyAppViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final log = getLogger('Splash Screen View');
  late final bool isFirstTime;
  var initialRoute = Routes.settingScreenView;
  final dialogService = locator<DialogService>();

  Future<bool> routeUser() async {
    return true;
  }
}
