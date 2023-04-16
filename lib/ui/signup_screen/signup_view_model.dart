import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart'
    show NavigationService, SnackbarService;
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../domain/repos/auth_repos.dart';
import '../../others/constants.dart';
import '../../util/exceptions/failures/failure.dart';

class SignUpViewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final loginFormKey = GlobalKey<FormState>();
  final authRepo = locator<Auth>();

  final TextEditingController fullNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController pwdTextController = TextEditingController();
  String fullNameErrorMsg = "";
  String emailErrorMsg = "";
  String phoneErrorMsg = "";
  String pwdErrorMsg = "";

  void fullNameErrorMsgValidation(String value) {
    if (value.isEmpty) {
      fullNameErrorMsg = "Field can not be empty.";
    } else if (value.length < 3) {
      fullNameErrorMsg = "Should be 3 characters long.";
    } else {
      fullNameErrorMsg = "";
    }
    notifyListeners();
  }

  void emailErrorMsgValidation(String value) {
    if (value.isEmpty) {
      emailErrorMsg = "Field can not be empty.";
    } else if (value.isNotEmpty && !validateEmail(value)) {
      emailErrorMsg = "Please Enter valid email address.";
    } else if (value.length < 8) {
      emailErrorMsg = "Should be 8 characters long.";
    } else {
      emailErrorMsg = "";
    }
    notifyListeners();
  }

  void phoneErrorMsgValidation(String value) {
    if (value.isEmpty) {
      phoneErrorMsg = "Field can not be empty.";
    } else if (value.length < 10) {
      phoneErrorMsg = "Should be 10 characters long.";
    } else {
      phoneErrorMsg = "";
    }
    notifyListeners();
  }

  void pwdErrorMsgValidation(String value) {
    if (value.isEmpty) {
      pwdErrorMsg = "Field can not be empty.";
    } else if (value.isNotEmpty && !validatePassword(value)) {
      pwdErrorMsg = "Please Enter valid password.";
    } else if (value.length < 8) {
      pwdErrorMsg = "Should be 8 characters long.";
    } else {
      pwdErrorMsg = "";
    }
    notifyListeners();
  }

  Future<void> register() async {
    setBusy(true);
    final response = await authRepo.registerUser(
      await _getRequestForSignUp(),
    );
    response.fold(
      (fail) => failBody(fail),
      (res) => successBody(res),
    );
  }

  Future<void> successBody(bool res) async {
    snackBarService.showSnackbar(message: "Resister Successfully");
    await Future.delayed(const Duration(seconds: 2));
    navigationService.navigateTo(Routes.homeScreenView);
    setBusy(false);
  }

  void failBody(Failure fail) {
    snackBarService.showSnackbar(message: fail.errorMsg);
    setBusy(false);
  }

  Future<Map<String, dynamic>> _getRequestForSignUp() async {
    Map<String, String> request = {};
    // request['role'] = 'android_customer';
    request['name'] = fullNameTextController.text;
    request['email'] = emailTextController.text;
    request['country_code'] = "+1";
    request['phone_number'] = phoneTextController.text;
    request['password'] = pwdTextController.text;
    // request['device_token'] = (await DeviceInfoPlugin().androidInfo).id;
    log("Request SignUp Body ---> $request");
    return request;
  }
}
