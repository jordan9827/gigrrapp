import 'package:easy_localization/easy_localization.dart';
import 'package:square_demo_architecture/domain/repos/account_repos.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../app/app.locator.dart';
import '../../../data/network/dtos/my_gigrrs_roster_response.dart';
import '../../../data/network/dtos/my_gigs_response.dart';
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
  GigsRequestData myGigrrsRequestData = GigsRequestData.fromJson({});
  @override
  void initialise() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
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

  void submitPayment({
    required SelectPaymentModelViewModel viewModel,
    required GigsRequestData data,
  }) {
    if (paymentMethod.title.isNotEmpty) {
      loadPaymentDialog(viewModel, data);
    } else {
      snackBarService.showSnackbar(message: "plz_select_u_payment_method".tr());
    }
  }

  Future<void> loadPaymentDialog(
    SelectPaymentModelViewModel viewModel,
    GigsRequestData gigrrsData,
  ) async {
    final builders = {
      DialogType.candidatePayment: (_, request, completer) => PaymentDialogView(
            gigrrsData: gigrrsData,
            viewModel: viewModel,
            onTap: () => loadPaymentMethod(gigrrsData),
          )
    };
    dialogService.registerCustomDialogBuilders(builders);
    await dialogService.showCustomDialog(
      variant: DialogType.candidatePayment,
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    navigationService.back();
    print("handlePaymentSuccessResponse  ${response.paymentId}");
    if (response.paymentId!.isNotEmpty) {
      loadCandidatePayment(
        data: myGigrrsRequestData,
        paymentType: "online",
        paymentResponse: response.toString(),
        paymentID: response.paymentId ?? "",
      );
    }
    notifyListeners();
  }

  void loadPaymentMethod(GigsRequestData data) {
    var index = PaymentMethod.paymentList.indexOf(paymentMethod);
    if (index == 1) {
      print("Razor Pay");
      myGigrrsRequestData = data;
      loadRazorPayPayment(data);
    } else {
      navigationService.back();
      loadCandidatePayment(
        data: data,
        paymentType: "cash",
      );
    }
    notifyListeners();
  }

  void loadRazorPayPayment(GigsRequestData data) {
    var price = data.offerAmount.toPriceFormat(0);
    var amount = int.parse(price) * 100;
    var options = {
      'key': 'rzp_test_nYsbGl2JnIjUDy', // Testing //
      //  'key': 'rzp_live_aGAF5DHohgOzfr', // Live //
      'amount': amount,
      'name': data.candidate.fullName,
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
    required GigsRequestData data,
    String paymentType = "",
    String paymentResponse = "",
    String paymentID = "",
  }) async {
    setBusy(true);
    var result = await accountRepo.gigsCandidatePayment(
      await _getRequestForPayment(
        data: data,
        paymentType: paymentType,
        paymentID: paymentID,
        paymentResponse: paymentResponse,
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
    required GigsRequestData data,
    String paymentType = "",
    String paymentResponse = "",
    String paymentID = "",
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = "${data.gigsId}";
    request['candidate_id'] = "${data.candidate.id}";
    request['amount'] = data.offerAmount;
    request['payment_mode'] = paymentType;
    request['transaction_response'] = paymentResponse;
    request['transaction_id'] = paymentID;
    return request;
  }
}

class PaymentMethod {
  final String title;
  final String image;

  PaymentMethod({
    this.image = "",
    this.title = "",
  });

  static var paymentList = [
    PaymentMethod(title: "Pay Cash", image: cash_hand),
    PaymentMethod(title: "RazorPay", image: cash_hand),
  ];
}
