import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/get_businesses_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/auth_repos.dart';
import '../../../domain/repos/business_repos.dart';

final GlobalKey<RefreshIndicatorState> businessRefreshKey =
    GlobalKey<RefreshIndicatorState>();

class BusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  final authRepo = locator<Auth>();

  List<GetBusinessesData> businessesList = <GetBusinessesData>[];

  BusinessesViewModel() {
    fetchAllBusinessesApi();
    businessTypeCategoryApiCall();
  }

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
  }

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    await businessRepo.businessTypeCategory();
    await authRepo.loadState();
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

  Future<void> refreshScreen() async {
    businessesList = [];
    await fetchAllBusinessesApi();
    notifyListeners();
  }

  Future<void> navigationToAddBusinessView() async {
    var isCheck = await navigationService.navigateTo(
      Routes.addBusinessesScreenView,
    );
    if (isCheck ?? false) await fetchAllBusinessesApi();
  }

  Future<void> navigatorToEditBusinessesView(GetBusinessesData e) async {
    var isCheck = await navigationService.navigateTo(
      Routes.editBusinessesScreenView,
      arguments: EditBusinessesScreenViewArguments(businessData: e),
    );
    if (isCheck ?? false) await fetchAllBusinessesApi();
  }

  Future<void> fetchAllBusinessesApi() async {
    businessesList = [];
    setBusy(true);
    final response = await businessRepo.fetchAllBusinessesApi();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (response) async {
        businessesList = response.businessesList;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
