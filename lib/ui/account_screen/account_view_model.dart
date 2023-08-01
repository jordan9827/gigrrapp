import 'package:fcm_service/fcm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/local/preference_keys.dart';
import 'package:square_demo_architecture/util/exceptions/failures/failure.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../data/network/dtos/user_auth_response_data.dart';
import '../../domain/repos/auth_repos.dart';
import '../../domain/repos/notification_repos.dart';
import '../../others/constants.dart';

class AccountViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final authRepo = locator<Auth>();
  final notificationRepo = locator<NotificationRepo>();
  bool notificationSwitch = true;
  String platformVersion = "";

  AccountViewModel() {
    notificationSwitch = getNotificationSwitch();
    print("token---->>> ${user.accessToken} ${user.isEmployer}");
    initPlatformVersion();
  }

  bool onWillPop() {
    navigationService.clearStackAndShow(
      Routes.homeView,
      arguments: HomeViewArguments(
        initialIndex: user.isEmployer ? 0 : 1,
        isInitial: false,
      ),
    );
    return false;
  }

  Future<void> notificationSwitchAction(bool val) async {
    notificationSwitch = !notificationSwitch;
    notifyListeners();
    var data = notificationSwitch ? "on" : "off";
    var res = await notificationRepo.notificationSwitch(data);
    res.fold((l) => failRes(l), (r) => successForNotificationSwitch());
  }

  Future<void> successForNotificationSwitch() async {
    sharedPreferences.setBool(
        PreferenceKeys.NOTIFICATION_SWITCH.text, notificationSwitch);
    setBusy(false);
  }

  Future<void> failRes(Failure f) async {
    snackBarService.showSnackbar(message: f.errorMsg);
    setBusy(false);
  }

  bool getNotificationSwitch() {
    return sharedPreferences.getBool(PreferenceKeys.NOTIFICATION_SWITCH.text) ??
        false;
  }

  void initPlatformVersion() async {
    platformVersion = await appVersion();
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToEditProfileScreen() {
    navigationService.navigateTo(Routes.editProfileScreenView);
  }

  void navigationToBusinessesScreen() {
    navigationService.navigateTo(Routes.businessesScreenView);
  }

  void navigationToCandidatePreferencesScreen() {
    navigationService.navigateTo(Routes.candidatePreferenceScreenView);
  }

  void navigationToShareEarnScreen() {
    // navigationService.navigateTo(Routes.);
  }

  void navigationToLanguageScreen() {
    navigationService.navigateTo(Routes.languageScreenView);
  }

  void navigationToManageAddressScreen() {
    navigationService.navigateTo(Routes.manageAddressScreenView);
  }

  void navigationToPaymentHistoryScreen() {
    navigationService.navigateTo(Routes.paymentHistoryScreenView);
  }

  void navigationToAboutScreen() {
    navigationService.navigateTo(Routes.aboutUsScreenView);
  }

  void navigationToBankAccountScreen() {
    navigationService.navigateTo(Routes.bankAccountScreenView);
  }

  void navigationToHelpSupportScreen() {
    navigationService.navigateTo(Routes.helpSupportScreenView);
  }

  void navigationToPrivacyPolicyScreen() {
    navigationService.navigateTo(Routes.privacyPolicyScreenView);
  }

  void navigationToTermsAndConditionScreen() {
    navigationService.navigateTo(Routes.termsAndConditionScreenView);
  }

  Future<void> logOut() async {
    setBusy(true);
    var res = await authRepo.logout();
    res.fold((l) => failRes(l), (r) async {
      await sharedPreferences.clear();
      await locator.reset();
      await setupLocator();
      locator<FCMService>().deleteToken();
      await sharedPreferences.setBool(PreferenceKeys.FIRST_TIME.text, false);
      navigationService.clearStackAndShow(Routes.loginView);
      setBusy(false);
    });
    notifyListeners();
  }
}
