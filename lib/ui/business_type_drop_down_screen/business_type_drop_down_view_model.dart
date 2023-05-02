import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/business_type_category.dart';
import '../../../../../domain/repos/auth_repos.dart';
import '../../../../../domain/repos/business_repos.dart';

class BusinessTypeDropDownViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<Business>();
  BusinessTypeCategoryList? selectedBusinessType;
  List<BusinessTypeCategoryList> businessTypeList = [];

  Future<void> businessTypeCategoryApiCall() async {
    setBusy(true);
    final response = await authRepo.businessTypeCategory();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (businessTypeResponse) {
        selectedBusinessType = businessTypeResponse.first;
        businessTypeList = businessTypeResponse;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
