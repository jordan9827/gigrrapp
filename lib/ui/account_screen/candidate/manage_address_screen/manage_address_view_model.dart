import 'package:square_demo_architecture/data/network/dtos/get_address_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/common_repos.dart';

class ManageAddressViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final user = locator<UserAuthResponseData>();
  final commonRepo = locator<CommonRepo>();

  List<GetAddressResponseData> addressList = [];

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> navigationToAddAddressView() async {
    var isCheck = await navigationService.navigateTo(
      Routes.addAddressScreenView,
      arguments: AddAddressScreenViewArguments(
        isEdit: true,
        addressData: GetAddressResponseData.emptyData(),
      ),
    );
    if (isCheck ?? false) {
      fetchAddress();
    }
  }

  Future<void> navigationToEditAddressView(
    GetAddressResponseData data,
  ) async {
    var isCheck = await navigationService.navigateTo(
      Routes.addAddressScreenView,
      arguments: AddAddressScreenViewArguments(
        isEdit: true,
        addressData: data,
      ),
    );
    if (isCheck ?? false) {
      fetchAddress();
    }
  }

  Future<void> fetchAddress() async {
    addressList = [];
    setBusy(true);
    final response = await commonRepo.fetchAddress();
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
