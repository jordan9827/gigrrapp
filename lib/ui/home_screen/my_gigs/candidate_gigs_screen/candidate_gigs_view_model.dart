import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/candidate_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';

class CandidateGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final candidateRepo = locator<CandidateRepo>();
  final user = locator<UserAuthResponseData>();
  int initialIndex = 0;
  int itemCount = 0;
  var _pageNumber = 0;
  bool _loading = false;

  bool get loading => _loading;
  List<MyGigsData> appliedGigsList = [];
  List<MyGigsData> shortListGigsList = [];
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

  Future<void> fetchAppliedGigs() async {
    _pageNumber = _pageNumber + 1;
    if (_pageNumber == 1) setBusy(true);
    var result = await candidateRepo.acceptedGigs(_pageNumber);
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      appliedGigsList.addAll(res.myGigsData);
      itemCount = res.myGigsData.length;
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
      shortListGigsList.addAll(res.myGigsData);
      itemCount = res.myGigsData.length;
      notifyListeners();
      setBusy(false);
      // log("CandidateRoster " + res.myGigsData.toList().toString());
    });
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
