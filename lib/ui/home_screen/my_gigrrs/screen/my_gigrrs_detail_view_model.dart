import 'package:fcm_service/fcm_service.dart';
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
  final fCMService = locator<FCMService>();

  bool isStatusSize = false;
  String statusMyGig = "";
  String gigrId = "";
  String jobOTP = "";
  bool isButtonVisible = true;

  MyGigrrsDetailViewModel(String id) {
    this.gigrId = id;
    fCMService.listenForegroundMessage((p0) => fetchMyGigrrRoster());
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

  String statusForMyGigrrsAction(GigsRequestData i) {
    if (i.status == "Complete") {
      statusMyGig = "Complete";
    } else if (i.paymentStatus == "pending") {
      statusMyGig = "pay_candidate";
    } else if (i.ratingFromEmployer == "no") {
      statusMyGig = "rate";
    } else if (i.ratingFromEmployer == "yes" &&
        i.paymentStatus == "completed" &&
        i.status == "complete") {
      statusMyGig = "paid";
    }

    return statusMyGig;
  }

  String getGigStatus(GigsRequestData e) {
    String status = "";
    switch (e.status) {
      case "complete":
        status = "completed";
        break;
      case "roster":
        isButtonVisible = false;
        jobOTP = e.startOTP;
        status = "roster";
        break;
      case "start":
        isButtonVisible = false;
        status = "start";
        jobOTP = e.endOTP;
        break;
    }
    return status;
  }

  void navigationToGoogleMap({
    String lat = "0.0",
    String lng = "0.0",
  }) {
    navigationService.navigateTo(
      Routes.googleMapViewScreen,
      arguments: GoogleMapViewScreenArguments(
        lat: double.parse(lat),
        lng: double.parse(lng),
      ),
    );
  }

  Future<void> navigationToStatusForGigs(GigsRequestData request) async {
    bool result = false;
    var status = statusForMyGigrrsAction(request).toLowerCase();
    if (status == "rate") {
      result = await navigationService.navigateTo(
        Routes.ratingReviewScreenView,
        arguments: RatingReviewScreenViewArguments(
          gigsId: gigrrsData.id.toString(),
          name: request.employeeName,
          profile: request.candidate.imageURL,
          candidateId: request.employeId.toString(),
        ),
      );
      if (result) fetchMyGigrrRoster();
    } else if (status == "pay_candidate") {
      var check = await navigationService.navigateTo(
        Routes.selectPaymentModeView,
        arguments: SelectPaymentModeViewArguments(
          data: request,
        ),
      );
      if (check ?? false) {
        fetchMyGigrrRoster();
      }
    }
  }
}
