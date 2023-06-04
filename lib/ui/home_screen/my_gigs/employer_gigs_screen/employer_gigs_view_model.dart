import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../data/network/dtos/user_auth_response_data.dart';

class EmployerGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();
  final user = locator<UserAuthResponseData>();
  int responseCount = 0;
  List<MyGigsData> myGigsList = [];

  List<String> setStackedImage(MyGigsData data) {
    List<String> urlImages = [];
    for (var i in data.gigsRequestData) {
      if (i.candidateImageList.isEmpty) {
      } else {
        print("candidateImageList----> ${i.candidateImageList.first.imageURL}");
        urlImages.add(i.candidateImageList.first.imageURL);
      }
    }
    responseCount = urlImages.length;
    return urlImages;
  }

  String get setResponseCount {
    if (responseCount <= 4) {
      return "$responseCount  response";
    } else {
      return "+ $responseCount response";
    }
  }

  Future<void> fetchMyGigsList() async {
    setBusy(true);
    var result = await businessRepo.fetchMyGigs();
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (myGigs) {
      myGigsList = myGigs.myGigsData;
      notifyListeners();
      setBusy(false);
    });
    notifyListeners();
  }
}
