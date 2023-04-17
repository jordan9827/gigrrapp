import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart'
    show NavigationService, SnackbarService;
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../others/constants.dart';

class LoginViewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mobileMessage = "";
  String pwdMessage = "";

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
      pwdMessage = 'pwd_validation';
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
    if (pwdMessage.isEmpty && mobileMessage.isEmpty) {}
  }

  void navigationToOTPScreen() {
    navigationService.navigateTo(Routes.oTPVerifyScreen);
  }
}
