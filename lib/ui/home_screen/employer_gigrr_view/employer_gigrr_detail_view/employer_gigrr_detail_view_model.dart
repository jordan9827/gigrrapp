import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/business_repos.dart';

class EmployerGigrrDetailViewModel extends BaseViewModel {
  final navigationServices = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();

  final user = locator<UserAuthResponseData>();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();
  final businessRepo = locator<BusinessRepo>();

  void navigateBack() {
    navigationServices.back();
  }

  Future<void> navigatorToGiggrRequestView({
    int id = 0,
    int candidateId = 0,
  }) async {
    setBusy(true);
    var result = await businessRepo.shortListedCandidate(
      await _getRequestForShortListCandidate(id: id, candidateId: candidateId),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      navigationServices.back();
      setBusy(false);
      notifyListeners();
    });
  }

  Future<Map<String, String>> _getRequestForShortListCandidate({
    int id = 0,
    int candidateId = 0,
    String action = "",
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = "$id";
    request['candidate_id'] = "$candidateId";
    request['status'] = "roster";
    return request;
  }
}
