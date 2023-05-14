import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/user_auth_response_data.dart';
import '../../domain/repos/business_repos.dart';

class RatingReviewViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  TextEditingController commentController = TextEditingController();
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

  bool validate() {
    if (commentController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please Share your experience");
      return false;
    }
    return true;
  }

  Future<void> ratingReviewSubmit() async {
    if (validate()) {
      setBusy(true);
      final response = await businessRepo.addGigs(
        await _getRequestForSubmitRating(),
      );
      response.fold(
        (fail) {
          snackBarService.showSnackbar(message: fail.errorMsg);
          setBusy(false);
        },
        (rating) async {
          snackBarService.showSnackbar(message: rating.message);
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForSubmitRating() async {
    Map<String, String> request = {};
    request['gigs_id'] = "";
    request['candidate_id'] = "";
    request['rating'] = rating.toString();
    request['comments'] = commentController.text;
    log("Rating Request Body :: $request");
    return request;
  }
}
