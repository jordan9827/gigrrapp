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

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mobileMessage = "";
  String pwdMessage = "";
  int initialIndex = 0;

  void setInitialIndex(int index) {
    initialIndex = index;
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

  void mobileNoValidation() {
    String valueText = mobileController.text;
    if (valueText.isEmpty) {
      mobileMessage = "Field cannot be empty";
    } else if (valueText.isNotEmpty && !validatePhone(valueText)) {
      mobileMessage = 'Please enter valid mobile no';
    } else {
      mobileMessage = "";
    }
    notifyListeners();
  }

  void passwordValidation() {
    String valueText = passwordController.text;
    if (valueText.isEmpty) {
      pwdMessage = "Field cannot be empty";
    } else if (valueText.isNotEmpty && !validatePassword(valueText)) {
      pwdMessage = 'Please enter valid password';
    } else if (valueText.length < 8) {
      pwdMessage = 'Should be 8 characters long';
    } else {
      pwdMessage = "";
    }
    notifyListeners();
  }

  void validation() {
    mobileNoValidation();
    passwordValidation();
  }

  void login() {
    validation();
    if (pwdMessage.isEmpty && mobileMessage.isEmpty) {
      navigationService.navigateTo(
        Routes.homeView,
      );
    }
  }

  Future<void> googleLogin() async {
    if (initialIndex == 1) {
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
          socialMediaType: LoginType.GOOGLE.name.toLowerCase(),
        );
        await socialApiCall(log);
      }
    } else
      snackBarService.showSnackbar(message: "Coming Soon");
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

  Future<void> socialApiCall(SocialSignInData signInData) async {
    setBusy(true);
    final response = await authRepo.socialLogin(
      await _getRequestForLogIn(signInData),
    );
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (res) => successBody(res),
    );
    notifyListeners();
  }

  Future<void> successBody(UserAuthResponseData res) async {
    await sharedPreferences.setString(
        PreferenceKeys.USER_DATA.text, json.encode(res));
    checkStatus(res);
    setBusy(false);
  }

  void navigationToSignup(UserAuthResponseData res) {}

  void checkStatus(UserAuthResponseData res) {
    var value = res.profileStatus.toLowerCase();
    print("checkStatus --- ${res.isEmployer}");
    switch (value) {
      case "login":
        if (res.isEmployer) {
          navigationService
              .clearStackAndShow(Routes.employerRegisterScreenView);
        } else {
          snackBarService.showSnackbar(message: "Coming Soon");
        }
        break;
      case "profile-completed":
        if (res.isEmployer) {
          navigationService.clearStackAndShow(
            Routes.oTPVerifyScreen,
            arguments: OTPVerifyScreenArguments(
              mobile: res.phoneNumber,
            ),
          );
        } else {
          snackBarService.showSnackbar(message: "Coming Soon");
        }
        break;
      default:
        if (res.isEmployer) {
          navigationService.clearStackAndShow(Routes.homeView);
        }
        break;
    }
  }

  void navigationToOTPScreen() {
    // navigationService.navigateTo(Routes.oTPVerifyScreen,
    //     arguments: OTPVerifyScreenArguments(mobile: "+916565656565"));
  }

  Future<Map<String, String>> _getRequestForLogIn(
      SocialSignInData socialData) async {
    Map<String, String> request = Map();

    request['social_id'] = socialType(socialData);
    request['social_type'] = socialData.socialMediaType;
    request['device_token'] = (await deviceToken());
    request['device_type'] = getDeviceType();
    request['role'] = initialIndex == 1 ? "3" : "4";
    request['full_name'] = socialData.name;
    request['email'] = socialData.email;
    request['country_code'] = "+91";
    request['mobile_no'] = socialData.phone;
    log("getRequestForLogIn :: $request");
    return request;
  }

  String socialType(SocialSignInData data) {
    if (data.socialMediaType == LoginType.GOOGLE.name.toLowerCase())
      return data.googleId;
    if (data.socialMediaType == LoginType.FACEBOOK.name.toLowerCase())
      return data.facebookId;
    return data.appleId;
  }
}
