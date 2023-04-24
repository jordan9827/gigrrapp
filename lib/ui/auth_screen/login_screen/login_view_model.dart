import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart'
    show NavigationService, SnackbarService;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../others/constants.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginViewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mobileMessage = "";
  String pwdMessage = "";

  void navigationToSignUpView(int index) {
    if (index == 0) {
      return;
    } else {
      navigationService.navigateTo(Routes.employPersonalInfoFormView);
      return;
    }
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
        Routes.homeScreenView,
      );
    }
  }

  void navigationToOTPScreen() {
    navigationService.navigateTo(Routes.oTPVerifyScreen);
  }

  Future<void> googleLogin() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    await googleSignIn.signOut();
    var account = await googleSignIn.signIn();
  }

  Future<void> fbLogin(
      {Function? success, Function? fail, Function? cancel}) async {
    var facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    var facebookLoginResult = await facebookLogin.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        fail!();
        break;
      case FacebookLoginStatus.cancel:
        cancel!();
        break;
      case FacebookLoginStatus.success:
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
    if (account != null) {}
  }
}
