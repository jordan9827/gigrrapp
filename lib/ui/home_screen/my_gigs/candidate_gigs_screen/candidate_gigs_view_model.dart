import 'package:easy_localization/easy_localization.dart';
import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/candidate_repos.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../data/network/dtos/candidate_roster_gigs_response.dart';
import '../../../../data/network/dtos/gigs_accepted_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../util/enums/dialog_type.dart';
import '../../../widgets/custom_offer_dialog.dart';
import 'widget/candidate_otp_verify_dialog.dart';

class CandidateGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final candidateRepo = locator<CandidateRepo>();
  final fCMService = locator<FCMService>();
  final user = locator<UserAuthResponseData>();
  int initialIndex = 0;
  int itemCount = 0;
  String statusSlug = "";
  var _pageNumber = 0;
  bool _loading = false;
  TextEditingController otpController = TextEditingController();

  bool get loading => _loading;
  List<GigsAcceptedData> appliedGigsList = [];
  List<CandidateRosterData> shortListGigsList = [];
  var scrollController = ScrollController();

  CandidateGigsViewModel() {
    fCMService.listenForegroundMessage((p0) => refreshScreen());
  }

  void setInitialIndex(int index) {
    initialIndex = index;
    refreshScreen();
    notifyListeners();
  }

  Future<void> refreshScreen() async {
    setBusy(true);
    appliedGigsList = [];
    shortListGigsList = [];
    _pageNumber = 0;
    itemCount = 0;
    if (initialIndex == 1) await fetchShortListedGigs();
    if (initialIndex == 0) await fetchAppliedGigs();
    notifyListeners();
    setBusy(false);
  }

  void init() {
    fetchAppliedGigs();
    scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isBusy) _loading = true;
      if (initialIndex == 1) await fetchShortListedGigs();
      if (initialIndex == 0) await fetchAppliedGigs();
    }
    notifyListeners();
  }

  void showAcceptOfferDialog(
      CandidateGigsViewModel viewModel, GigsAcceptedData gigs) {
    var offerPrice = gigs.gigsRequestData.first.offerAmount.toPriceFormat(0);
    final builders = {
      DialogType.acceptOffer: (_, request, completer) => CustomOfferDialog(
            onTap: () => acceptedGigsOffer(gigs.id),
            title: "accept_this_offer",
            subTitle: "has_offer_you"
                .tr(args: [" ${gigs.priceCriteria} \nprice of ₹ $offerPrice"]),
            buttonText: "accept_this_offer",
          ),
    };
    dialogService.registerCustomDialogBuilders(builders);
    dialogService.showCustomDialog(
      variant: DialogType.acceptOffer,
    );
    notifyListeners();
  }

  Future<void> fetchAppliedGigs() async {
    _pageNumber = _pageNumber + 1;
    if (_pageNumber == 1) setBusy(true);
    var result = await candidateRepo.acceptedGigs(_pageNumber);
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      appliedGigsList.addAll(res.gigsAcceptedData);
      itemCount = res.gigsAcceptedData.length;
      _loading = false;

      setBusy(false);
      notifyListeners();
    });
    setBusy(false);
    notifyListeners();
  }

  Future<void> fetchShortListedGigs() async {
    _pageNumber = _pageNumber + 1;
    if (_pageNumber == 1) setBusy(true);
    var result = await candidateRepo.candidateRosterGigs(_pageNumber);
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      _loading = false;
      shortListGigsList.addAll(res.candidateRosterData);
      itemCount = res.candidateRosterData.length;
      notifyListeners();
      setBusy(false);
      // log("CandidateRoster " + res.myGigsData.toList().toString());
    });
    notifyListeners();
  }

  Future<void> acceptedGigsOffer(int id) async {
    navigationService.back();
    setBusy(true);
    var result = await candidateRepo.acceptedGigsOffer(
      await _getRequestForCandidate(gigsId: id, status: "accept"),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) async {
      await refreshScreen();
      setBusy(false);
    });
    notifyListeners();
  }

  void showCandidateOTPVerifyStartJob({
    required CandidateGigsViewModel viewModel,
    required CandidateRosterData gigs,
    String status = "",
    String message = "",
  }) {
    final builders = {
      DialogType.OTPVerifyStartJob: (_, request, completer) =>
          CandidateJobOTPVerifyDialog(
            gigs: gigs,
            title: message,
            status: status,
            viewModel: viewModel,
          ),
    };
    dialogService.registerCustomDialogBuilders(builders);
    dialogService.showCustomDialog(
      variant: DialogType.OTPVerifyStartJob,
    );
    notifyListeners();
  }

  Future<void> loadUpdateJobStatusApi(
    CandidateRosterData gigs,
    CandidateGigsViewModel viewModel,
  ) async {
    var bankStatus = (user.bankStatus == 1 ? true : false);
    for (var i in gigs.gigsRequestData) {
      if (i.status == "roster") {
        if (bankStatus) {
          await updateJobStatus(gigs, "start", viewModel);
        } else {}
      } else if (i.status == "start") {
        await updateJobStatus(gigs, "complete", viewModel);
      } else if (i.paymentStatus == "pending") {
      } else if (i.ratingToEmployer == "no") {
        navigationService.navigateTo(Routes.ratingReviewScreenView);
      }
    }
    notifyListeners();
  }

  Future<void> updateJobStatus(
    CandidateRosterData gigs,
    status,
    CandidateGigsViewModel viewModel,
  ) async {
    // navigationService.back();
    setBusy(true);
    var result = await candidateRepo.updateJobStatus(
      await _getRequestForCandidate(gigsId: gigs.id, status: status),
    );
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) async {
      showCandidateOTPVerifyStartJob(
        viewModel: viewModel,
        gigs: gigs,
        status: status,
        message: res.message,
      );
      setBusy(false);
    });
    notifyListeners();
  }

  Future<void> loadGigsVerifyOTP({
    required int id,
    required String status,
  }) async {
    if (otpController.text.isNotEmpty) {
      navigationService.back();
      setBusy(true);
      var result = await candidateRepo.gigsVerifyOTP(
        await _getRequestForSubmitOtp(gigsId: id, status: status),
      );
      result.fold((fail) {
        otpController.clear();
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      }, (res) async {
        await refreshScreen();
        setBusy(false);
      });
    } else {
      snackBarService.showSnackbar(message: "Please enter OTP");
    }
    notifyListeners();
  }

  String price({String from = "", String to = "", String priceCriteria = ""}) {
    return "₹ ${double.parse(from).toStringAsFixed(0)}-${double.parse(to).toStringAsFixed(0)}/$priceCriteria";
  }

  String getGigStatus(List<GigsRequestData> list) {
    String status = "";
    for (var i in list) {
      statusSlug = i.status;
      switch (i.status) {
        case "accepted":
          status = 'Accepted By You';
          break;
        case "sent-offer":
          status = 'Offer Received';
          break;
        case "accepted":
          status = 'Accepted By You';
          break;
        case "received-offer":
          status = 'Offer accepted By You';
          break;
        case "roster":
          status = "ShortListed";
          break;
        case "start":
          status = "Job Started";
          break;
        case "complete":
          status = "Job Completed";
          break;
      }
    }
    return status;
  }

  String statusForShortList(List<GigsRequestData> list) {
    String status = "";
    for (var i in list) {
      if (i.status == "roster") {
        status = "Start Job";
      } else if (i.status == "start") {
        status = "Complete";
      } else if (i.paymentStatus == "pending") {
        status = "Un Paid";
      } else if (i.ratingToEmployer == "no") {
        status = "Rate";
      } else if (i.status == "complete" &&
          i.ratingToEmployer == "yes" &&
          i.paymentStatus == "completed") {
        status = "Completed";
      }
    }
    return status;
  }

  Future<Map<String, String>> _getRequestForCandidate({
    int gigsId = 0,
    String status = "",
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = "$gigsId";
    request['status'] = status;
    return request;
  }

  Future<Map<String, String>> _getRequestForSubmitOtp({
    int gigsId = 0,
    String status = "",
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = "$gigsId";
    request['otp'] = otpController.text;
    request['status'] = status;
    return request;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
