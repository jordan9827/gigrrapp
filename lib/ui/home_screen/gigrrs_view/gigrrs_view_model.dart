import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/ui/home_screen/gigrr_detail_view/gigrr_detail_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../data/network/dtos/candidate_gigs_request.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/candidate_repos.dart';

class GigrrsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();

  final PageController pageController = PageController();
  final user = locator<UserAuthResponseData>();
  final candidateRepo = locator<CandidateRepo>();
  List<CandidateGigsRequestData> gigsData = [];

  GigrrsViewModel() {
    fetchGigsRequest();
  }

  void navigateToGigrrDetailScreen(CandidateGigsRequestData e) {
    navigationService.navigateTo(Routes.gigrrDetailView,
        arguments: GigrrDetailViewArguments(data: e));
  }

  Future<void> fetchGigsRequest() async {
    setBusy(true);
    var result = await candidateRepo.getGigsRequest(await _getRequestForGig());
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      gigsData = res.gigsRequestData;
      setBusy(false);
      notifyListeners();
    });
    setBusy(false);
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForGig() async {
    Map<String, String> request = {};
    request["address"] = user.address;
    request["latitude"] = user.latitude;
    request["longitude"] = user.longitude;
    notifyListeners();
    return request;
  }
}
