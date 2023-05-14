import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../data/network/dtos/user_auth_response_data.dart';
import '../../domain/reactive_services/business_type_service.dart';
import '../../domain/repos/business_repos.dart';

class MyAppViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();

  final log = getLogger('Splash Screen View');
  final userData = locator<UserAuthResponseData>();

  late final bool isFirstTime;
  var initialRoute = Routes.loginView;
  final dialogService = locator<DialogService>();

  MyAppViewModel() {
    init();
    setInitialRoute();
  }
  void init() async {
    await checkLocation();
    await businessTypeCategoryApiCall();
  }

  void setInitialRoute() {
    if (userData.accessToken.isNotEmpty) {
      initialRoute = Routes.ratingReviewScreenView;
    }
    notifyListeners();
  }

  Future<bool> routeUser() async {
    return true;
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    await businessRepo.businessTypeCategory();
  }

  Future<void> checkLocation() async {
    setBusy(true);
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
  }
}
