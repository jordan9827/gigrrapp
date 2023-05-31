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
  String mobileMessage = "";
  int initialIndex = 0;
  String roleId = "4";

  List<String> sendOTPTypeList = ["sms", "whatsapp"];
  String initialOTPType = "sms";

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
    print("initialOTPType $initialOTPType");
    notifyListeners();
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

  Future<void> login() async {
    mobileNoValidation();
    if (mobileMessage.isEmpty) {
      bool result = await navigationService.navigateTo(
        Routes.oTPVerifyScreen,
        arguments: OTPVerifyScreenArguments(
          mobile: mobileController.text,
          otpType: initialOTPType,
          roleId: roleId,
        ),
      );
      print("OTPVerifyScreenArguments $result");
      if (result) {
        _navigationToStatusLogin();
      }
    }
  }

  void _navigationToStatusLogin() {
    if (roleId == "3") {
      navigationService.clearStackAndShow(Routes.employerRegisterScreenView);
    } else {
      navigationService.clearStackAndShow(Routes.candidateRegisterScreenView);
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
        socialMediaType: LoginType.GOOGLE.name.toLowerCase(),
      );
      await socialApiCall(log);
    }
    // } else
    //   snackBarService.showSnackbar(message: "Coming Soon");
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
      (res) async {
        await sharedPreferences.setString(
          PreferenceKeys.USER_DATA.text,
          json.encode(res),
        );
        _navigationToStatusSocialLogin(res);
        setBusy(false);
      },
    );
    notifyListeners();
  }

  void navigationToSignup(UserAuthResponseData res) {}

  Future<void> _navigationToStatusSocialLogin(UserAuthResponseData res) async {
    var value = res.profileStatus.toLowerCase();
    print("checkStatus --- ${res.isEmployer}");
    switch (value) {
      case "login":
        if (res.isEmployer) {
          navigationService
              .clearStackAndShow(Routes.employerRegisterScreenView);
        } else {
          navigationService
              .clearStackAndShow(Routes.candidateRegisterScreenView);
        }
        break;
      case "profile-completed":
        if (res.isEmployer) {
          await navigationService.clearStackAndShow(
            Routes.oTPVerifyScreen,
            arguments: OTPVerifyScreenArguments(
              mobile: res.mobile,
              otpType: initialOTPType,
              roleId: res.roleId,
            ),
          );
        } else {
          snackBarService.showSnackbar(message: "Coming Soon 1");
        }
        break;
      default:
        navigationService.clearStackAndShow(Routes.homeView);
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
    request['role'] = roleId;
    request['social_id'] = socialType(socialData);
    request['social_type'] = socialData.socialMediaType;
    request['device_token'] = (await deviceToken());
    request['device_type'] = getDeviceType();
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
