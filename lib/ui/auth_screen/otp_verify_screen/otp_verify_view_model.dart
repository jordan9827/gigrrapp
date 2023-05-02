import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/auth_repos.dart';
import '../../../others/constants.dart';

class OTPVerifyScreenModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final authRepo = locator<Auth>();
  final user = locator<UserAuthResponseData>();

  String mobileNumber = "";
  String isVerificationId = "";

  TextEditingController pinController = TextEditingController();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  OTPVerifyScreenModel({required String mobile}) {
    mobileNumber = mobile;
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  bool validateInput() {
    if (pinController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter OTP.");
      return false;
    }
    return true;
  }

  void sentVerifyOTP(String mobile) async {
    setBusy(true);
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: mobile,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        snackBarService.showSnackbar(message: e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        this.isVerificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setBusy(false);
    notifyListeners();
  }

  void verifyOTPCall() async {
    if (validateInput()) {
      await verifyUserToServerApi();

      setBusy(true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: isVerificationId,
        smsCode: pinController.text,
      );
      try {
        var result = await firebaseAuth.signInWithCredential(credential);
        print("result " + result.toString());
        if (result.user != null) {
          await verifyUserToServerApi();
        }
      } on FirebaseAuthException catch (_, e) {
        snackBarService.showSnackbar(message: e.toString());
        setBusy(false);
      }
    }
  }

  Future<void> verifyUserToServerApi() async {
    setBusy(true);
    final response = await authRepo.verifyOTP(await _getRequestForVerifyOtp());
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
    // await sharedPreferences.setString(
    //     PreferenceKeys.USER_DATA.text, json.encode(res));
    navigationService.clearStackAndShow(Routes.homeScreenView);
    setBusy(false);
  }

  Future<Map<String, String>> _getRequestForVerifyOtp() async {
    Map<String, String> request = {};
    request['country_code'] = "+91";
    request['mobile_no'] = mobileNumber;
    request['device_token'] = (await deviceToken());
    request['device_type'] = getDeviceType();
    request['certification_type'] = "development";
    log('Body Verify OTP :: $request');
    return request;
  }
}
