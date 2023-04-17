import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class OTPVerifyScreenModel extends BaseViewModel {
  TextEditingController pinController = TextEditingController();
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  var enableResend = false;
  final totalWaitTime = 180;
  var min = 5;
  Timer? timer;
  var seconds = 0;

  void startCountDownTimer() {
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
    });
  }

  void navigationToHomeView(String otpValue) {
    if (double.parse(otpValue) == 111111) {
      navigationService.back(result: true);
    } else {
      snackBarService.showSnackbar(message: "Please enter code 111111");
      navigationService.back(result: false);
      return;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String get timerText {
    return " $min:${seconds.toString().length == 1 ? "0$seconds" : seconds}";
  }
}
