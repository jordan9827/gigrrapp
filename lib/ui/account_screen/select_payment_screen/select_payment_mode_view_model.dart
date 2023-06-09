import 'package:square_demo_architecture/domain/repos/account_repos.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../app/app.locator.dart';
import '../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';
import '../../../util/enums/dialog_type.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/razorpay_payment_helper.dart';
import 'widget/payment_dialog_view.dart';

class SelectPaymentModelViewModel extends BaseViewModel with Initialisable {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final dialogService = locator<DialogService>();
  final user = locator<UserAuthResponseData>();
  final accountRepo = locator<AccountRepo>();
  final Razorpay _razorpay = Razorpay();

  List<String> paymentList = ["pay_cash, razor_pay"];
  PaymentMethod paymentMethod = PaymentMethod();

  @override
  void initialise() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        RazorPayPaymentHelper.handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        RazorPayPaymentHelper.handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        RazorPayPaymentHelper.handleExternalWalletSelected);
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void selectPayment(PaymentMethod? val) {
    if (!isBusy) {
      if (val != null) {
        paymentMethod = val;
      }
      notifyListeners();
    }
  }

  void submitPayment(
    SelectPaymentModelViewModel viewModel,
    MyGigrrsRosterData gigrrsData,
  ) {
    if (paymentMethod.title.isNotEmpty) {
      loadPaymentDialog(viewModel, gigrrsData);
    } else {
      snackBarService.showSnackbar(
          message: "Please select you payment method.");
    }
  }

  Future<void> loadPaymentDialog(
    SelectPaymentModelViewModel viewModel,
    MyGigrrsRosterData gigrrsData,
  ) async {
    final builders = {
      DialogType.candidatePayment: (_, request, completer) => PaymentDialogView(
            gigrrsData: gigrrsData,
            viewModel: viewModel,
            onTap: () => loadPaymentMethod(gigrrsData),
          )
    };
    dialogService.registerCustomDialogBuilders(builders);
    var data = await dialogService.showCustomDialog(
      variant: DialogType.candidatePayment,
    );
    print("dialogService $data");
  }

  void loadPaymentMethod(MyGigrrsRosterData data) {
    var index = PaymentMethod.paymentList.indexOf(paymentMethod);
    if (index == 1) {
      print("Razor Pay");
      loadRazorPayPayment(data);
    } else {
      navigationService.back();
      loadCandidatePayment(
        data: data,
        paymentType: "cash",
      );
    }
  }

  void loadRazorPayPayment(MyGigrrsRosterData data) {
    var request = data.gigsRequestData.first;
    var price = request.offerAmount.toPriceFormat(0);
    var amount = int.parse(price) * 100;
    var options = {
      'key': 'rzp_live_aGAF5DHohgOzfr',
      'amount': amount,
      'name': request.candidate.fullName,
      "currency": "INR",
      'description': 'Payment',
      'prefill': {
        'contact': user.mobile,
        'email': user.email,
      }
    };
    print("RazorPay Request Body --- ${options.toString()}");
    try {
      _razorpay.open(options);
    } catch (e) {
      snackBarService.showSnackbar(message: e.toString());
    }
  }

  Future<void> loadCandidatePayment({
    required MyGigrrsRosterData data,
    String paymentType = "",
    String paymentResponse = "",
    String paymentID = "",
  }) async {
    setBusy(true);
    var result = await accountRepo.gigsCandidatePayment(
      await _getRequestForPayment(
        data: data,
        paymentType: paymentType,
      ),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      setBusy(false);
      navigationService.back();
      navigationService.back();
    });
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForPayment({
    required MyGigrrsRosterData data,
    String paymentType = "",
    String paymentResponse = "",
    String paymentID = "",
  }) async {
    var requestData = data.gigsRequestData.first;
    Map<String, String> request = {};
    request['gigs_id'] = "${data.id}";
    request['candidate_id'] = "${requestData.candidate.id}";
    request['amount'] = requestData.offerAmount;
    request['payment_mode'] = paymentType;
    request['transaction_response'] = paymentResponse;
    request['transaction_id'] = paymentID;
    return request;
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
