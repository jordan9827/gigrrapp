import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/data/network/api_services/business_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../data/network/dtos/candidate_gigs_request.dart';
import '../../../data/network/dtos/employer_gigs_request.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/business_repos.dart';
import '../../../domain/repos/candidate_repos.dart';

class EmployerGigrrsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();

  final PageController pageController = PageController();
  final user = locator<UserAuthResponseData>();
  final candidateRepo = locator<CandidateRepo>();
  final businessRepo = locator<BusinessRepo>();
  List<EmployerGigsRequestData> gigsData = [];

  EmployerGigrrsViewModel() {
    // fetchGigsRequest();
  }

  void navigateToGigrrDetailScreen(EmployerGigsRequestData e) {
    // navigationService.navigateTo();
  }

  Future<void> fetchGigsRequest() async {
    setBusy(true);
    var result =
        await businessRepo.employerGigsRequest(await _getRequestForGig());
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

  String price(EmployerGigsRequestData e) {
    var p = e.employerProfile;
    return "₹ ${p.priceFrom.toStringAsFixed(1)}-${p.priceFrom.toStringAsFixed(0)}/${p.priceCriteria}";
  }

  Future<Map<String, String>> _getRequestForGig() async {
    Map<String, String> request = {};
    request["id"] = "0";
    notifyListeners();
    return request;
  }
}
