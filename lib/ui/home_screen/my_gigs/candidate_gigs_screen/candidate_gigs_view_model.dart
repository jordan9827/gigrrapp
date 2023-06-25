import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/candidate_repos.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/candidate_gigs_screen/widget/accept_offer_dialog_view.dart';
import 'package:square_demo_architecture/util/extensions/string_extension.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../data/network/dtos/candidate_roster_gigs_response.dart';
import '../../../../data/network/dtos/gigs_accepted_response.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../util/enums/dialog_type.dart';

class CandidateGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final candidateRepo = locator<CandidateRepo>();
  final user = locator<UserAuthResponseData>();
  int initialIndex = 0;
  int itemCount = 0;
  String statusSlug = "";
  var _pageNumber = 0;
  bool _loading = false;

  bool get loading => _loading;
  List<GigsAcceptedData> appliedGigsList = [];
  List<CandidateRosterData> shortListGigsList = [];
  var scrollController = ScrollController();

  CandidateGigsViewModel() {}

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
      DialogType.acceptOffer: (_, request, completer) => AcceptOfferDialogView(
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
    var result = await candidateRepo
        .acceptedGigsOffer(await _getRequestForAcceptOffer(id));
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) async {
      await refreshScreen();
      setBusy(false);
    });
    notifyListeners();
  }

  String price({String from = "", String to = "", String priceCriteria = ""}) {
    return "₹ ${double.parse(from).toStringAsFixed(0)}-${double.parse(to).toStringAsFixed(0)}/$priceCriteria";
  }

  String getGigStatus(List<GigsRequestData> list, int userId) {
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<Map<String, String>> _getRequestForAcceptOffer(int id) async {
    Map<String, String> request = {};
    request['gigs_id'] = id.toString();
    request['status'] = "accept";
    return request;
  }
}
