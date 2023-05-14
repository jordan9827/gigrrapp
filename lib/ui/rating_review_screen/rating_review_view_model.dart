import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/user_auth_response_data.dart';

class RatingReviewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  double _initialRating = 2.0;
  double _rating = 0.0;

  double get initialRating => _initialRating;

  double get rating => _rating;

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
  }

  void onRatingUpdate(double rate) {
    _rating = rate;
    log("onRatingUpdate ----> $rate");
    notifyListeners();
  }
}
