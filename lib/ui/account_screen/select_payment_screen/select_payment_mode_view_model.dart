import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../util/enums/dialog_type.dart';
import '../../../util/others/image_constants.dart';
import 'widget/payment_dialog_view.dart';

class SelectPaymentModelViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final user = locator<UserAuthResponseData>();
  List<String> paymentList = ["Pay Cash, Razor Pay"];
  PaymentMethod paymentMethod = PaymentMethod();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void selectPayment(PaymentMethod? val) {
    if (val != null) {
      paymentMethod = val;
    }
    notifyListeners();
  }

  void submitPayment() {
    if (paymentMethod.title.isNotEmpty) {
    } else {
      snackBarService.showSnackbar(
          message: "Please select you payment method.");
    }
  }

  void loadPaymentDialog(SelectPaymentModelViewModel viewModel) {
    final builders = {
      DialogType.candidatePayment: (_, request, completer) => PaymentDialogView(
            viewModel: viewModel,
          )
    };
    dialogService.registerCustomDialogBuilders(builders);
    dialogService.showCustomDialog(
      variant: DialogType.candidatePayment,
    );
  }
}

class PaymentMethod {
  final String title;
  final String image;

  PaymentMethod({this.image = "", this.title = ""});

  static var paymentList = [
    PaymentMethod(title: "Pay Cash", image: cash_hand),
    PaymentMethod(title: "RazorPay", image: cash_hand),
  ];
}
