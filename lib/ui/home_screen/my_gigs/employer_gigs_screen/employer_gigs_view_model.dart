import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/employer_gigs_screen/screen/candidate_offer_view.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/employer_gigs_screen/screen/employer_gigs_detail_screen/employer_gigs_detail_view.dart';
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
  final PageController pageController = PageController();
  int requestL = 0;

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

  int getOfferSentCount(List<GigsRequestData> gigRequestList) {
    int count = 0;
    for (var element in gigRequestList) {
      if (element.status == "sent-offer") {
        count = count + 1;
      }
    }
    return count;
  }

  int getOfferReceivedCount(List<GigsRequestData> gigRequestList) {
    int count = 0;
    for (var element in gigRequestList) {
      if (element.status == "received-offer") {
        count = count + 1;
      }
    }
    return count;
  }

  int getAcceptedCount(List<GigsRequestData> gigRequestList) {
    List<String> urlImages = [];
    for (var element in gigRequestList) {
      if (element.status == "accepted") {
        urlImages.add(element.candidate.imageURL);
      }
    }
    return urlImages.length;
  }

  int getRoasterCount(List<GigsRequestData> gigRequestList) {
    int count = 0;
    for (var element in gigRequestList) {
      if (element.status == "roster") {
        count = count + 1;
      }
    }
    return count;
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
    if (data == "complete" || data == "" || data == "start") {
      isCheck = true;
    }
    return isCheck;
  }

  Future<void> navigationToCandidateDetail(
    EmployerGigsViewModel viewModel,
    MyGigsData gigs,
    String gigsStatus,
  ) async {
    var isCheck = await navigationService.navigateWithTransition(
      EmployerGigsDetailView(gigs: gigs, status: gigsStatus),
    );
    if (isCheck) {
      await fetchMyGigsList();
    }
    notifyListeners();
  }
}
