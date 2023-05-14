import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/get_businesses_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../domain/repos/business_repos.dart';

final GlobalKey<RefreshIndicatorState> businessRefreshKey =
    GlobalKey<RefreshIndicatorState>();

class BusinessesViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final sharedPreferences = locator<SharedPreferences>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  List<GetBusinessesList> businessesList = <GetBusinessesList>[];

  void navigatorToBack() {
    if (!isBusy) {
      navigationService.back();
    }
  }

  Future<void> refreshScreen() async {
    businessesList = [];
    await fetchAllBusinessesApi();
    notifyListeners();
  }

  Future<void> navigatorToEditBusinessesView(GetBusinessesList e) async {
    await navigationService.navigateTo(
      Routes.editBusinessesScreenView,
      arguments: EditBusinessesScreenViewArguments(businessData: e),
    );
    await fetchAllBusinessesApi();
  }

  Future<void> fetchAllBusinessesApi() async {
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
