import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart'
    show NavigationService, SnackbarService;
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/local/preference_keys.dart';
import '../../../data/network/dtos/social_login_data.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/auth_repos.dart';
import '../../../others/constants.dart';
import '../../../util/enums/login_type.dart';

class LoginViewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final loginFormKey = GlobalKey<FormState>();
  final authRepo = locator<Auth>();
  final user = locator<UserAuthResponseData>();
  String loginType = LoginType.MOBILE.name.toLowerCase();

  TextEditingController mobileController = TextEditingController();
  String mobileMessage = "";
  int initialIndex = 0;
  String roleId = "4";

  List<String> sendOTPTypeList = ["sms", "whatsapp"];
  String initialOTPType = "sms";

  LoginViewViewModel() {
    sharedPreferences.setString(PreferenceKeys.GIGRR_TYPE.text, initialOTPType);
  }

  void setInitialIndex(int index) {
    initialIndex = index;
    roleId = initialIndex == 1 ? "3" : "4";
    notifyListeners();
  }

  void navigationToSignUpView() {
    if (initialIndex == 1) {
      navigationService.navigateTo(Routes.employerRegisterScreenView);
    }
  }

  void navigationToForgetPwdView() {
    navigationService.navigateTo(Routes.forgetPasswordView);
  }

  void setOTPType(String? val) {
    initialOTPType = val!;
    sharedPreferences.setString(PreferenceKeys.GIGRR_TYPE.text, "$val");
    print("initialOTPType $initialOTPType");
    notifyListeners();
  }

  void mobileNoValidation() {
    String valueText = mobileController.text;
    if (valueText.isEmpty) {
      mobileMessage = "field_cannot_be_empty";
    } else if (valueText.isNotEmpty && !validatePhone(valueText)) {
      mobileMessage = "plz_enter_valid_mobile_no";
    } else {
      mobileMessage = "";
    }
    notifyListeners();
  }

  Future<void> login() async {
    mobileNoValidation();
    if (mobileMessage.isEmpty) {
      setBusy(true);
      var result = await navigationService.navigateTo(
        Routes.oTPVerifyScreen,
        arguments: OTPVerifyScreenArguments(
          mobile: mobileController.text,
          roleId: roleId,
        ),
      );
      if (result["isCheck"] ?? false) {
        await _navigationToStatusLogin(result["profile_status"]);
      }
    }
    setBusy(false);
    notifyListeners();
  }

  Future<void> _navigationToStatusLogin(String value) async {
    var employer = (roleId == "3" ? true : false);
    switch (value) {
      case "otp-verify":
        if (employer) {
          navigationService.navigateTo(
            Routes.employerRegisterScreenView,
            arguments: EmployerRegisterScreenViewArguments(
              phoneNumber: mobileController.text,
            ),
          );
        } else {
          navigationService.navigateTo(
            Routes.candidateRegisterScreenView,
            arguments: CandidateRegisterScreenViewArguments(
              phoneNumber: mobileController.text,
            ),
          );
        }
        break;
      case "completed":
        navigationService.clearStackAndShow(Routes.homeView);
        break;
      case "profile-completed":
        navigationService.clearStackAndShow(
          Routes.candidateKYCScreenView,
        );
        break;
    }
  }

  Future<void> googleLogin() async {
    // if (initialIndex == 1) {
    setBusy(true);
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    await googleSignIn.signOut();
    var account = await googleSignIn.signIn();
    setBusy(false);
    if (account != null) {
      var log = SocialSignInData(
        email: account.email,
        googleId: account.id,
        name: account.displayName ?? "",
        socialMediaType: SocialType.GOOGLE.name.toLowerCase(),
      );
      await socialApiCall(log);
    }
  }

  Future<void> fbLogin() async {
    var facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    var facebookLoginResult = await facebookLogin.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.success:
        final profile = await facebookLogin.getUserProfile();

        if (profile!.userId.isNotEmpty) {
          var log = SocialSignInData(
            email: await facebookLogin.getUserEmail() ?? "",
            name: profile.name ?? "",
            facebookId: profile.userId,
            socialMediaType: SocialType.FACEBOOK.name.toLowerCase(),
          );
          await socialApiCall(log);
        }
        break;
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.cancel:
        break;
    }
  }

  void appleLogin({Function? success, Function? fail, Function? cancel}) async {
    var account = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
  }

  Future<void> socialApiCall(
    SocialSignInData signInData,
  ) async {
    setBusy(true);
    final response = await authRepo.socialLogin(
      await _getRequestForLogIn(signInData),
    );
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (res) async {
        await sharedPreferences.setString(
          PreferenceKeys.USER_DATA.text,
          json.encode(res),
        );
        await _navigationToStatusSocialLogin(
          res: res,
          socialId: signInData.googleId,
          socialType: signInData.socialMediaType,
        );
        setBusy(false);
      },
    );
    notifyListeners();
  }

  Future<void> _navigationToStatusSocialLogin({
    required UserAuthResponseData res,
    String socialType = "",
    String socialId = "",
  }) async {
    var value = res.profileStatus.toLowerCase();
    print("checkStatus --- ${res.isEmployer}");
    switch (value) {
      case "login":
        if (res.isEmployer) {
          navigationService.navigateTo(
            Routes.employerRegisterScreenView,
            arguments: EmployerRegisterScreenViewArguments(
              socialType: socialType,
              socialId: socialId,
              isSocialLogin: true,
            ),
          );
        } else {
          navigationService.navigateTo(
            Routes.candidateRegisterScreenView,
            arguments: CandidateRegisterScreenViewArguments(
              socialType: socialType,
              socialId: socialId,
              isSocialLogin: true,
            ),
          );
        }
        break;
      case "profile-completed":
        if (res.isEmployer) {
          await navigationToOTPScreen(
            res: res,
            socialType: socialType,
            socialId: socialId,
          );
        } else {
          navigationService.clearStackAndShow(
            Routes.candidateKYCScreenView,
            arguments: CandidateKYCScreenViewArguments(
              isSocial: true,
              socialType: socialType,
              socialId: socialId,
            ),
          );
        }
        break;
      case "kyc-completed":
        await navigationToOTPScreen(
          res: res,
          socialType: socialType,
          socialId: socialId,
        );
        break;
      case "completed":
        navigationService.clearStackAndShow(Routes.homeView);
        break;
    }
  }

  Future<void> navigationToOTPScreen({
    required UserAuthResponseData res,
    String socialType = "",
    String socialId = "",
  }) async {
    var data = await navigationService.navigateTo(
      Routes.oTPVerifyScreen,
      arguments: OTPVerifyScreenArguments(
        mobile: res.mobile,
        roleId: res.roleId,
        socialType: socialType,
        socialId: socialId,
        loginType: LoginType.SOCIAL.name.toLowerCase(),
      ),
    );
    if (data["isCheck"] ?? false) {
      navigationService.clearStackAndShow(Routes.homeView);
    }
  }

  Future<Map<String, String>> _getRequestForLogIn(
      SocialSignInData socialData) async {
    Map<String, String> request = Map();
    request['role'] = roleId;
    request['social_id'] = socialType(socialData);
    request['social_type'] = socialData.socialMediaType;
    request['device_token'] = (await fcmToken());
    request['device_type'] = getDeviceType();
    request['full_name'] = socialData.name;
    request['email'] = socialData.email;
    request['country_code'] = "+91";
    request['mobile_no'] = socialData.phone;
    log("getRequestForLogIn :: $request");
    return request;
  }

  String socialType(SocialSignInData data) {
    if (data.socialMediaType == SocialType.GOOGLE.name.toLowerCase())
      return data.googleId;
    if (data.socialMediaType == SocialType.FACEBOOK.name.toLowerCase())
      return data.facebookId;
    return data.appleId;
  }
}
