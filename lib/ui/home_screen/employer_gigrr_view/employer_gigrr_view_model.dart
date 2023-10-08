import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../data/network/dtos/employer_gigs_request.dart';
import '../../../data/network/dtos/employer_request_preferences_model.dart';
import '../../../data/network/dtos/find_gigrr_profile_response.dart';
import '../../../data/network/dtos/my_gigs_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/business_repos.dart';
import '../../../domain/repos/candidate_repos.dart';
import '../../account_screen/employer/employer_preferences_screen/employer_preferences_view.dart';
import 'candidate_offer_create_gigrr_view.dart';

class EmployerGigrrsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final gigrrsPref = locator<EmployerRequestPreferencesResp>();
  final PageController pageController = PageController();
  final user = locator<UserAuthResponseData>();
  final candidateRepo = locator<CandidateRepo>();
  final businessRepo = locator<BusinessRepo>();
  List<FindGigrrsProfileData> gigsData = <FindGigrrsProfileData>[];
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();

  EmployerGigrrsViewModel() {
    if (gigrrsPref.businessId.isNotEmpty) {
      fetchFindGigrrsProfile();
    }
  }

  void navigateToGigrrDetailScreen(FindGigrrsProfileData e) {}

  void navigateToBusiness() {
    navigationService.navigateTo(
      Routes.businessesScreenView,
    );
  }

  Future<void> navigateToEmployerPrefView() async {
    await navigationService.navigateTo(
      Routes.employerPreferenceScreenView,
    );
  }

  Future<void> fetchFindGigrrsProfile() async {
    setBusy(true);
    var result = await businessRepo.employerFindGigrr(
      await _getRequestForFindGigrrs(),
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

  Future<void> navigationToCandidateOfferRequest(
    FindGigrrsProfileData e,
  ) async {
    await navigationService.navigateTo(
      Routes.candidateOfferToCreateGigrrView,
      arguments: CandidateOfferToCreateGigrrViewArguments(data: e),
    );
  }

  Future<void> navigationToSendOfferDetailView({
    required FindGigrrsProfileData gigs,
  }) async {
    await navigationService.navigateTo(
      Routes.employerGigrrDetailView,
      arguments: EmployerGigrrDetailViewArguments(
        gigsId: gigs.id,
        candidateId: gigs.employerProfile.userId,
        isShortListed: false,
        price: price(gigs),
        address: gigs.address,
        imageURL: gigs.imageUrl,
        candidateName: gigs.firstName,
        experience: gigs.employerProfile.experience,
        availability: gigs.employerProfile.availibility,
        skillList: gigs.employeeSkills.first.skills,
        longitude: gigs.longitude,
        latitude: gigs.latitude,
      ),
    );
  }

  String price(FindGigrrsProfileData e) {
    var p = e.employerProfile;
    return "₹ ${p.priceFrom.toStringAsFixed(0)}-${p.priceFrom.toStringAsFixed(0)}/${p.priceCriteria}";
  }

  Future<Map<String, dynamic>> _getRequestForFindGigrrs() async {
    return locator<EmployerRequestPreferencesResp>().toJson();
  }

  Future<void> loadGigsCandidateOffer({
    int candidateId = 0,
  }) async {
    if (offerPriceController.text.isNotEmpty) {
      setBusy(true);
      var result = await businessRepo.createGigrrToCandidateOffer(
        await _getRequestGigsCandidateOffer(
          candidateId: candidateId,
        ),
      );
      result.fold((fail) {
        setBusy(false);
        snackBarService.showSnackbar(message: fail.errorMsg);
      }, (myGigs) async {
        navigationService.clearStackAndShow(
          Routes.homeView,
          arguments: HomeViewArguments(
            initialIndex: 1,
            isInitial: false,
          ),
        );
        setBusy(false);
      });
    } else {
      snackBarService.showSnackbar(message: "msg_plz_enter_offer".tr());
    }
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestGigsCandidateOffer({
    int candidateId = 0,
  }) async {
    Map<String, String> request = {};
    request['candidate_id'] = "$candidateId";
    request['gig_name'] = gigrrsPref.gigName;
    request['business_id'] = gigrrsPref.businessId;
    request['address'] = gigrrsPref.address;
    request['start_date'] = gigrrsPref.startDate;
    request['end_date'] = gigrrsPref.endDate;
    request['from_amount'] = gigrrsPref.fromAmount.toString();
    request['to_amount'] = gigrrsPref.toAmount.toString();
    request['latitude'] = gigrrsPref.latitude;
    request['longitude'] = gigrrsPref.longitude;
    request['skills'] = gigrrsPref.skills;
    request['gender'] = gigrrsPref.gender;
    request['offer_amount'] = offerPriceController.text;
    return request;
  }
}
