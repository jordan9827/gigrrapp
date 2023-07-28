import 'package:easy_localization/easy_localization.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class AddressValidationHelper {
  static final snackBarService = locator<SnackbarService>();

  static bool validationSaveAddress({
    String address = "",
    String city = "",
    String state = "",
    String pinCode = "",
  }) {
    if (address.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_address".tr(),
      );
      return false;
    } else if (city.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_city".tr(),
      );
      return false;
    } else if (state.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_state".tr(),
      );
      return false;
    } else if (pinCode.isEmpty) {
      snackBarService.showSnackbar(
        message: "msg_pinCode".tr(),
      );
      return false;
    }
    return true;
  }
}
