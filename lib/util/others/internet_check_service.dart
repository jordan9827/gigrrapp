import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class InternetCheckService {
  final _internetConnectionChecker = InternetConnectionChecker();
  final _navigationService = locator<NavigationService>();

  void initializeInternetCheckServices() {
    _internetConnectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        navigateToNoInternetScreen();
      }
    });
  }

  Future<bool> checkInterNetConnection() async {
    final internetConnectionStatus =
        await _internetConnectionChecker.connectionStatus;
    return internetConnectionStatus == InternetConnectionStatus.connected;
  }

  void navigateToNoInternetScreen() {
    _navigationService.navigateTo(
      Routes.noInternetView,
    );
  }
}
