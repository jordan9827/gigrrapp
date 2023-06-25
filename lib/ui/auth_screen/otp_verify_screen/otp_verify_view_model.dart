import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final sharedPreferences = locator<SharedPreferences>();
  final authRepo = locator<Auth>();
  final user = locator<UserAuthResponseData>();
  var enableResend = false;
  final totalWaitTime = 300;
  var min = 5;
  Timer? timer;
  var seconds = 0;
  String mobileNumber = "";
  String otpType = "";
  String roleId = "";
  String isVerificationId = "";

  TextEditingController pinController = TextEditingController();

  OTPVerifyScreenModel(
      {required String mobile, String otpType = "", String roleId = ""}) {
    this.mobileNumber = mobile;
    this.otpType = otpType;
    this.roleId = roleId;
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

  // void sentVerifyOTP(String mobile) async {
  //   setBusy(true);
  //   await firebaseAuth.verifyPhoneNumber(
  //     phoneNumber: mobile,
  //     verificationCompleted: (PhoneAuthCredential credential) {},
  //     verificationFailed: (FirebaseAuthException e) {
  //       snackBarService.showSnackbar(message: e.toString());
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       this.isVerificationId = verificationId;
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {},
  //   );
  //   setBusy(false);
  //   notifyListeners();
  // }
  //
  // void verifyOTPCall() async {
  //   if (validateInput()) {
  //     print("isVerificationId $isVerificationId");
  //     setBusy(true);
  //     PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: isVerificationId,
  //       smsCode: pinController.text,
  //     );
  //     try {
  //       var result = await firebaseAuth.signInWithCredential(credential);
  //       print("firebaseAuth result " + result.toString());
  //       if (result.user != null) {
  //         await verifyUserToServerApi();
  //       }
  //     } on FirebaseAuthException catch (_, e) {
  //       snackBarService.showSnackbar(message: e.toString());
  //       setBusy(false);
  //     }
  //   }
  // }
  void init() async {
    await sendOTP();
    startCountDownTimer();
  }

  void startCountDownTimer() {
    setBusy(true);
    enableResend = false;
    min = totalWaitTime ~/ 60;
    seconds = totalWaitTime % 60;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final time = totalWaitTime - timer.tick;
      min = time ~/ 60;
      seconds = time % 60;
      if (timer.tick == totalWaitTime) {
        enableResend = true;
        timer.cancel();
      }
      notifyListeners();
      setBusy(false);
    });
  }

  String get timerText {
    return " $min:${seconds.toString().length == 1 ? "0$seconds" : seconds}";
  }

  Future<void> sendOTP() async {
    setBusy(true);
    final response = await authRepo.sendOTP(await _getRequestForSendOtp());
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (res) async {
        setBusy(false);
      },
    );
    notifyListeners();
  }

  void verifyOtpApiCall() {
    if (pinController.text.length == 4) {
      if (!enableResend) {
        verifyOTP();
      } else {
        pinController.text = "";
        FocusManager.instance.primaryFocus?.unfocus();
        snackBarService.showSnackbar(message: "please Resend OTP");
      }
    }
  }

  void verifyOTP() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setBusy(true);
    final response = await authRepo.verifyOTP(await _getRequestForVerifyOtp());
    response.fold(
      (fail) {
        pinController.clear();
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
        notifyListeners();
      },
      (res) {
        print("verifyOTP ::::-----------------");
        navigationService.back(
          result: {
            "isCheck": true,
            "profile_status": res.profileStatus,
          },
        );
      },
    );
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForVerifyOtp() async {
    Map<String, String> request = {};
    request['role'] = roleId;
    request['country_code'] = countryCode;
    request['otp'] = pinController.text;
    request['mobile_no'] = mobileNumber;
    request['device_token'] = (await fcmToken());
    request['device_type'] = getDeviceType();
    request['certification_type'] = "development";
    log('Body Verify OTP :: $request');
    return request;
  }

  Future<Map<String, String>> _getRequestForSendOtp() async {
    Map<String, String> request = {};
    request['role'] = roleId;
    request['country_code'] = countryCode;
    request['mobile_no'] = mobileNumber;
    request['otp_type'] = otpType;
    log('Body Send OTP :: $request');
    return request;
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
