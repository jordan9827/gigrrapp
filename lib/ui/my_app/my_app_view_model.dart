import 'package:fcm_service/fcm_service.dart';
import 'package:location/location.dart' as l;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../data/local/preference_keys.dart';
import '../../data/network/dtos/user_auth_response_data.dart';
import '../../domain/reactive_services/business_type_service.dart';
import '../../domain/repos/business_repos.dart';
import '../../util/others/fcm_notification_handler.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class MyAppViewModel extends BaseViewModel {
  final sharedPreferences = locator<SharedPreferences>();
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();
  final fCMService = locator<FCMService>();
  final businessTypeService = locator<BusinessTypeService>();

  final log = getLogger('My App View');
  final userData = locator<UserAuthResponseData>();

  late final bool isFirstTime;
  var initialRoute = Routes.loginView;
  final dialogService = locator<DialogService>();

  MyAppViewModel() {
    init();
    print("userData ${userData.profileStatus}");
  }

  void init() async {
    await checkLocation();
    await businessTypeCategoryApiCall();
  }

  void setInitialRoute() {
    print(
        "setInitialRoute  \n${userData.accessToken}\n${userData.profileStatus}");
    if (icCheckIntroScreen() && userData.accessToken.isEmpty) {
      initialRoute = Routes.introScreenView;
    } else if (userData.accessToken.isNotEmpty) {
      initialRoute = _buildInitialCurrentRoutes();
    }
    notifyListeners();
  }

  String _buildInitialCurrentRoutes() {
    String routes = Routes.loginView;

    switch (userData.profileStatus) {
      case "login":
        if (userData.isEmployer) {
          routes = Routes.employerRegisterScreenView;
        } else {
          routes = Routes.candidateRegisterScreenView;
        }
        break;
      case "profile-completed":
        routes = Routes.candidateKYCScreenView;
        break;
      case "otp-verify":
        routes = Routes.loginView;
        break;
      case "":
        routes = Routes.loginView;
        break;
      default:
        routes = Routes.homeView;
    }
    return routes;
  }

  bool icCheckIntroScreen() {
    return sharedPreferences.getBool(PreferenceKeys.FIRST_TIME.text) ?? true;
  }

  Future<bool> routeUser() async {
    print(
        "setInitialRoute  \n${userData.accessToken}\n${userData.profileStatus}");
    if (icCheckIntroScreen() && userData.accessToken.isEmpty) {
      initialRoute = Routes.introScreenView;
    } else if (userData.accessToken.isNotEmpty) {
      initialRoute = _buildInitialCurrentRoutes();
    }
    return true;
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    await businessRepo.businessTypeCategory();
  }

  Future<void> checkLocation() async {
    setBusy(true);
    l.Location location = l.Location();
    bool serviceEnabled;
    l.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == l.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != l.PermissionStatus.granted) {
        return null;
      }
    }
  }

  Future<void> setFcmService() async {
    try {
      await fCMService.setFCMService(
          onBackgroundHandler: _firebaseMessagingBackgroundHandler);
      fCMService.listenForegroundMessage(onForegroundMessage);
      await fCMService.setUpLocalNotification(
        onSelectNotificationAction: notificationRedirections,
      );
      onNotificationOpenApp();
    } catch (e) {
      log.e(e);
    }
  }

  void onNotificationOpenApp() {
    fCMService.onMessageOpenedAppStream().listen((event) {
      navigationService.navigateTo(Routes.homeView);
      fCMService.isOpenFromNotification = true;
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    try {
      await Firebase.initializeApp();
      handleNotification(message, true);
      log.i("Notification is ${message.data}");
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    }
  }

  void notificationRedirections(String? redirectTo) {
    log.i("notificationRedirections is $redirectTo");
    navigationService.navigateTo(Routes.homeView);
  }

  void onForegroundMessage(RemoteMessage message) async {
    try {
      handleNotification(message, false);
      log.i(
          "Foreground message ${message.data}\nForeground details ${message.from}");
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack, fatal: true);
    }
  }
}
