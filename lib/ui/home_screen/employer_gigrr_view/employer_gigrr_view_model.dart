import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../data/network/dtos/employer_gigs_request.dart';
import '../../../data/network/dtos/employer_request_preferences_model.dart';
import '../../../data/network/dtos/find_gigrr_profile_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/business_repos.dart';
import '../../../domain/repos/candidate_repos.dart';
import '../../account_screen/employer/employer_preferences_screen/employer_preferences_view.dart';

class EmployerGigrrsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final employerGigrrsPref = locator<EmployerRequestPreferencesResp>();
  final PageController pageController = PageController();
  final user = locator<UserAuthResponseData>();
  final candidateRepo = locator<CandidateRepo>();
  final businessRepo = locator<BusinessRepo>();
  List<FindGigrrsProfileData> gigsData = <FindGigrrsProfileData>[];

  EmployerGigrrsViewModel() {
    if (employerGigrrsPref.businessId.isNotEmpty) {
      // fetchFindGigrrsId();
    }
  }

  void navigateToGigrrDetailScreen(FindGigrrsProfileData e) {}

  void navigateToBusiness() {
    navigationService.navigateTo(
      Routes.businessesScreenView,
    );
  }

  Future<void> navigateToEmployerPrefView() async {
    await navigationService.navigateToView(
      EmployerPreferenceScreenView(),
    );
  }

  Future<void> fetchFindGigrrsId() async {
    setBusy(true);
    var result = await businessRepo.employerFindGigrr(
      await _getRequestForFindGigrrs(),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) async {
      await fetchFindGigrrsProfile(res.id);
      setBusy(false);
      notifyListeners();
    });
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchFindGigrrsProfile(int id) async {
    setBusy(true);
    var result = await businessRepo.employerSearchCandidateGigs(
      await _getRequestForGig(gigrrId: id),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      gigsData = res;
      setBusy(false);
      notifyListeners();
    });
    setBusy(false);
    notifyListeners();
  }

  String price(FindGigrrsProfileData e) {
    var p = e.employerProfile;
    return "₹ ${p.priceFrom.toStringAsFixed(0)}-${p.priceFrom.toStringAsFixed(0)}/${p.priceCriteria}";
  }

  Future<Map<String, String>> _getRequestForGig({int gigrrId = 0}) async {
    Map<String, String> request = {};
    request["gigs_id"] = "$gigrrId";
    notifyListeners();
    return request;
  }

  Future<Map<String, dynamic>> _getRequestForFindGigrrs() async {
    return locator<EmployerRequestPreferencesResp>().toJson();
  }
}
