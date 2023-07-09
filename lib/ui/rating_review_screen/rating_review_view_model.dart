import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
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

  double get initialRating => _initialRating;

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void onRatingUpdate(double rate) {
    _initialRating = rate;
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

  Future<void> ratingReviewSubmit({
    String id = "",
    String candidateId = "",
  }) async {
    if (validate()) {
      setBusy(true);
      final response = await businessRepo.ratingReview(
        await _getRequestForSubmitRating(
          id: id,
          candidateId: candidateId,
        ),
      );
      response.fold(
        (fail) {
          setBusy(false);
          snackBarService.showSnackbar(message: fail.errorMsg);
        },
        (rating) {
          navigationService.back(result: true);
          snackBarService.showSnackbar(message: rating.message);
          setBusy(false);
        },
      );
      notifyListeners();
    }
  }

  Future<Map<String, String>> _getRequestForSubmitRating({
    String id = "",
    String candidateId = "",
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = id;
    request['candidate_id'] = candidateId;
    request['rating'] = initialRating.toString();
    request['comments'] = commentController.text;
    log("Rating Request Body :: $request");
    return request;
  }
}
