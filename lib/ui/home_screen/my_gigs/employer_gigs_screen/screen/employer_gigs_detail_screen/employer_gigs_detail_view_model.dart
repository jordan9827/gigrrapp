import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../../app/app.locator.dart';
import '../../../../../../app/app.router.dart';
import '../../../../../../domain/repos/business_repos.dart';

class EmployerGigsDetailViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final businessRepo = locator<BusinessRepo>();
  final PageController pageController = PageController();
  TextEditingController offerPriceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();

  String profileImage(GigsRequestData image) {
    String profile = "";
    for (var i in image.candidateImageList) {
      profile = i.imageURL;
    }
    return profile;
  }

  String price(MyGigsData e) {
    return "₹ ${double.parse(e.fromAmount).toStringAsFixed(0)}-${double.parse(e.toAmount).toStringAsFixed(0)}/${e.priceCriteria}";
  }

  Future<void> navigationToCandidateOfferRequest(
    MyGigsData gigs,
    GigsRequestData requestData,
  ) async {
    await navigationService.navigateTo(
      Routes.candidateOfferView,
      arguments:
          CandidateOfferViewArguments(gigs: gigs, requestData: requestData),
    );
  }

  Future<void> navigationToShortListedDetailView({
    required MyGigsData gigs,
    required GigsRequestData data,
    bool isShortListed = true,
  }) async {
    await navigationService.navigateTo(
      Routes.employerGigrrDetailView,
      arguments: EmployerGigrrDetailViewArguments(
        gigsRequestData: data,
        isShortListed: isShortListed,
        price: price(gigs),
        skillList: gigs.skillsTypeCategoryList,
      ),
    );
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
        navigationService.back(result: true);
        setBusy(false);
      });
    } else {
      snackBarService.showSnackbar(message: "msg_plz_enter_offer".tr());
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
