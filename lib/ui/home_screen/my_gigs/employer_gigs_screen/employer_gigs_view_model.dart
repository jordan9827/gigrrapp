import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/employer_gigs_screen/screen/candidate_offer_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../employer_gigrr_view/employer_gigrr_detail_view/employer_gigrr_detail_view.dart';

class EmployerGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();
  final user = locator<UserAuthResponseData>();
  final fCMService = locator<FCMService>();

  int responseCount = 0;
  List<MyGigsData> myGigsList = [];
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();

  EmployerGigsViewModel() {
    fCMService.listenForegroundMessage((p0) => fetchMyGigsList());
  }

  List<String> setStackedImage(MyGigsData data) {
    List<String> urlImages = [];
    for (var i in data.gigsRequestData) {
      if (i.status == "accepted") {
        if (i.candidateImageList.isEmpty) {
          urlImages.add(i.candidate.imageURL);
        } else {
          // print(
          //     "candidateImageList----> ${i.candidateImageList.first.imageURL}");
          urlImages.add(i.candidateImageList.first.imageURL);
        }
      }
    }
    responseCount = urlImages.length;
    return urlImages;
  }

  String get setResponseCount {
    if (responseCount <= 4) {
      return "$responseCount  response";
    } else {
      return "+$responseCount response";
    }
  }

  Future<void> navigationToShortListedDetailView(MyGigsData gigs) async {
    await navigationService.navigateWithTransition(
      EmployerGigrrDetailView(
        gigsName: gigs.gigName,
        address: gigs.gigAddress,
        gigs: gigs,
        isShortListed: true,
        price: price(
          from: gigs.fromAmount,
          to: gigs.toAmount,
          priceCriteria: gigs.priceCriteria,
        ),
        skillList: gigs.skillsTypeCategoryList,
      ),
    );
    fetchMyGigsList();
  }

  Future<void> fetchMyGigsList() async {
    setBusy(true);
    var result = await businessRepo.fetchMyGigs();
    result.fold((fail) {
      setBusy(false);
      snackBarService.showSnackbar(message: fail.errorMsg);
    }, (myGigs) {
      myGigsList = myGigs.myGigsData;
      notifyListeners();
      setBusy(false);
    });
    notifyListeners();
  }

  String price({String from = "", String to = "", String priceCriteria = ""}) {
    return "₹ ${double.parse(from).toStringAsFixed(0)}-${double.parse(to).toStringAsFixed(0)}/$priceCriteria";
  }

  String isActiveStatus(MyGigsData gigs) {
    String gigrStatus = "";
    if (gigs.gigsRequestData.isNotEmpty) {
      for (var i in gigs.gigsRequestData) {
        gigrStatus = i.status.toLowerCase();
      }
    }
    return gigrStatus;
  }

  bool isEmptyModelCheck(MyGigsData gigs) {
    bool isCheck = false;
    var data = isActiveStatus(gigs);
    if (data == "complete" || data == "") {
      isCheck = true;
    }
    return isCheck;
  }

  Future<void> navigationToCandidateOfferRequest(
    EmployerGigsViewModel viewModel,
    MyGigsData gigs,
  ) async {
    var isCheck = await navigationService.navigateWithTransition(
      CandidateOfferView(gigs: gigs),
    );
    if (isCheck) {
      await fetchMyGigsList();
    }
  }

  Future<void> loadGigsCandidateOffer({
    int gigsId = 0,
    int candidateId = 0,
  }) async {
    if (offerPriceController.text.isNotEmpty) {
      setBusy(true);
      var result = await businessRepo.gigsCandidateOffer(
        await _getRequestGigsCandidateOffer(
          id: gigsId,
          candidateId: candidateId,
        ),
      );
      result.fold((fail) {
        setBusy(false);
        snackBarService.showSnackbar(message: fail.errorMsg);
      }, (myGigs) async {
        navigationService.back(result: true);
        setBusy(false);
      });
    } else {
      snackBarService.showSnackbar(message: "Please enter offer");
    }
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestGigsCandidateOffer({
    int id = 0,
    int candidateId = 0,
  }) async {
    Map<String, String> request = {};
    request['gigs_id'] = "$id";
    request['candidate_id'] = "$candidateId";
    request['offer_amount'] = offerPriceController.text;
    return request;
  }
}
