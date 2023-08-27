import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/candidate_gigs_request.dart';
import '../../../data/network/dtos/get_address_response.dart';
import '../../../data/network/dtos/get_businesses_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/candidate_repos.dart';
import '../../../domain/repos/common_repos.dart';
import 'candidate_gigrr_detail_view/candidate_gigrr_detail_view.dart';

class CandidateGigrrsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final defaultAddress = locator<GetAddressResponseData>();
  final fCMService = locator<FCMService>();

  final PageController pageController = PageController();
  final user = locator<UserAuthResponseData>();
  final candidateRepo = locator<CandidateRepo>();
  List<CandidateGigsRequestData> gigsData = [];
  final commonRepo = locator<CommonRepo>();

  CandidateGigrrsViewModel() {
    fCMService.listenForegroundMessage((p0) => fetchGigsRequest());
    setDefaultAddress();
  }

  Future<void> setDefaultAddress() async {
    if (defaultAddress.address.isEmpty) {
      await commonRepo.fetchAddress();
    }
  }

  List<String> listOfAvailability(CandidateGigsRequestData data) {
    List<String> listOfAvailability = [];
    if (data.availabilityResp.availability.isNotEmpty)
      listOfAvailability.add(data.availabilityResp.availability);
    return listOfAvailability;
  }

  void navigateBack() {
    navigationService.back();
  }

  void navigateToManageAddressView() {
    navigationService.navigateTo(Routes.manageAddressScreenView);
  }

  void navigateToGigrrDetailScreen(CandidateGigsRequestData e) {
    navigationService.navigateWithTransition(
      CandidateGigrrDetailView(data: e),
    );
  }

  Future<void> fetchGigsRequest() async {
    setBusy(true);
    var result = await candidateRepo.getGigsRequest(
      await _getRequestForGig(),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      gigsData = res.gigsRequestData;
      notifyListeners();
    });
    setBusy(false);
    notifyListeners();
  }

  int setDistance(CandidateGigsRequestData e) {
    int distance = 0;
    for (var i in e.gigsRequestData) {
      distance = i.distance;
    }
    return distance;
  }

  Future<void> acceptedGigsRequest(
    int id,
    int index, {
    bool isBack = false,
  }) async {
    setBusy(true);
    var result = await candidateRepo.acceptedGigsRequest(id);
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) async {
      await navigationService.clearStackAndShow(
        Routes.homeView,
        arguments: HomeViewArguments(
          initialIndex: 0,
          isInitial: false,
        ),
      );
      await fetchGigsRequest();
      setBusy(false);
    });
  }

  String price(CandidateGigsRequestData e) {
    return "₹ ${double.parse(e.fromAmount).toStringAsFixed(0)}-${double.parse(e.toAmount).toStringAsFixed(0)}/${e.priceCriteria}";
  }

  String profileImage(GetBusinessesData image) {
    String profile = "";
    for (var i in image.businessesImage) {
      profile = i.imageUrl;
    }
    return profile;
  }

  Future<Map<String, String>> _getRequestForGig() async {
    Map<String, String> request = {};
    request["address"] = defaultAddress.address;
    request["latitude"] = defaultAddress.latitude;
    request["longitude"] = defaultAddress.longitude;
    notifyListeners();
    return request;
  }
}
