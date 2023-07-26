import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/ui/home_screen/employer_gigrr_view/employer_gigrr_view.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.logger.dart';
import '../../app/app.router.dart';
import '../../data/network/dtos/user_auth_response_data.dart';
import '../../domain/repos/business_repos.dart';

class HomeViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  BottomNavBarService bottomNavBarService = locator<BottomNavBarService>();
  final user = locator<UserAuthResponseData>();
  final log = getLogger("HomeScreenViewModel");
  final businessRepo = locator<BusinessRepo>();
  int initialIndex = 0;

  HomeViewModel(int index) {
    this.initialIndex = index;
    gigrrTypeApiCall();
    log.i(
        "User Response --------------------------\nId= ${user.toString()}\nStatus= ${user.status}\nRole= ${user.roleId}\nToken= ${user.accessToken}\n--------------------");
  }

  void changeScreenIndex(int index) {
    bottomNavBarService.changeCurrentIndex(index);
    notifyListeners();
  }

  void setInitialIndex(bool isInitial) {
    if (!user.isEmployer) {
      var index = isInitial ? 1 : initialIndex;
      bottomNavBarService.currentIndex = index;
    } else {
      bottomNavBarService.currentIndex = initialIndex;
    }
    notifyListeners();
  }

  Future<void> gigrrTypeApiCall() async {
    setBusy(true);
    await businessRepo.gigrrTypeCategory();
    notifyListeners();
  }

  void navigatorToAddGigsView() {
    navigationService.navigateTo(Routes.addGigsScreenView);
  }

  void navigatorToGigrrsView() {
    navigationService.navigateWithTransition(EmployerGigrrsView());
  }
}
