import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';

class RazorPayPaymentHelper {
  final Razorpay _razorpay = Razorpay();
  static final snackBarService = locator<SnackbarService>();
  static final navigationService = locator<NavigationService>();

  static void handlePaymentErrorResponse(PaymentFailureResponse response) {
    navigationService.back(result: "Vinay 123 Ghodela");
    snackBarService.showSnackbar(message: response.message.toString());
  }

  static void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    navigationService.back(result: response);
  }

  static void handleExternalWalletSelected(ExternalWalletResponse response) {}
}
