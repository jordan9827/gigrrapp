import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/business_repos.dart';

class MyGigrrsDetailViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  MyGigrrsRosterData gigrrsData = MyGigrrsRosterData.getEmptyMyGigrrs();
  bool isStatusSize = false;
  String statusMyGig = "";
  String gigrId = "";

  MyGigrrsDetailViewModel(String id) {
    this.gigrId = id;
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> refreshScreen() async {}

  Future<void> fetchMyGigrrRoster() async {
    setBusy(true);
    var result = await businessRepo.myGigrrsRoster(gigrId);
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      gigrrsData = res;
      setBusy(false);
    });
    notifyListeners();
  }

  String statusForMyGigrrs() {
    for (var i in gigrrsData.gigsRequestData) {
      if (i.status == "start") {
        statusMyGig = "Complete";
      } else if (i.paymentStatus == "pending") {
        isStatusSize = true;
        statusMyGig = "Un Paid";
      } else if (i.ratingFromEmployer == "no") {
        isStatusSize = true;
        statusMyGig = "Rate";
      } else if (i.ratingFromEmployer == "yes" &&
          i.paymentStatus == "completed" &&
          i.status == "complete") {
        isStatusSize = true;
        statusMyGig = "Paid";
      }
    }
    return statusMyGig;
  }

  String getGigStatus() {
    String status = "";
    for (var i in gigrrsData.gigsRequestData) {
      switch (i.status) {
        case "complete":
          status = "Completed";
          break;
      }
    }
    return status;
  }

  Future<void> navigationToStatusForGigs() async {
    if (statusMyGig.toLowerCase() == "rate") {
      var request = gigrrsData.gigsRequestData.first;
      var result = await navigationService.navigateTo(
        Routes.ratingReviewScreenView,
        arguments: RatingReviewScreenViewArguments(
          gigsId: gigrrsData.id.toString(),
          name: gigrrsData.gigName,
          profile: request.candidate.imageURL,
          candidateId: request.employeId.toString(),
        ),
      );
      if (result) fetchMyGigrrRoster();
    }
  }
}
