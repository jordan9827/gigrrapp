import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

class InternetCheckService {
  final internetConnectionChecker = InternetConnectionChecker();
  final navigationService = locator<NavigationService>();
  bool isNoInternetScreenPushed = false;

  void initializeInternetCheckServices() {
    internetConnectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.disconnected) {
        isNoInternetScreenPushed = true;
        navigateToNoInternetScreen();
      } else if (isNoInternetScreenPushed) {
        navigationService.back();
      }
    });
  }

  Future<void> checkInterNetConnection() async {
    final internetConnectionStatus =
        await internetConnectionChecker.connectionStatus;
    if (internetConnectionStatus == InternetConnectionStatus.connected &&
        isNoInternetScreenPushed) {
      navigationService.back();
    }
  }

  void navigateToNoInternetScreen() {
    navigationService.navigateTo(
      Routes.noInternetView,
    );
  }
}
