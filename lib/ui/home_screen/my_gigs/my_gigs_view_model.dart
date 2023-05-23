import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/data/network/dtos/my_gigs_response.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MyGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();

  List<MyGigsResponseList> myGigsList = [];

  Future<void> fetchMyGigsList() async {
    setBusy(true);
    var result = await businessRepo.fetchMyGigs();
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (myGigs) {
      myGigsList = myGigs.gigsResponseList;
      notifyListeners();
      setBusy(false);
    });
    notifyListeners();
  }
}