import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/account_repos.dart';

class ManageAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final accountRepo = locator<AccountRepo>();

  List<GetAddressResponseData> addressList = [];

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> navigationToAddAddressView() async {
    bool isCheck = await navigationService.navigateTo(
      Routes.addAddressScreenView,
    );
    if (isCheck) {
      fetchAddress();
    }
  }

  Future<void> navigationToEditAddressView(GetAddressResponseData data) async {
    bool isCheck = await navigationService.navigateTo(
      Routes.addAddressScreenView,
      arguments: AddAddressScreenViewArguments(
        isEdit: true,
        state: data.state,
        pinCode: data.pincode,
        address: data.address,
        city: data.city,
        addressType: data.addressType,
      ),
    );
    if (isCheck) {
      fetchAddress();
    }
  }

  Future<void> fetchAddress() async {
    addressList = [];
    setBusy(true);
    final response = await accountRepo.fetchAddress();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (list) async {
        addressList = list;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
