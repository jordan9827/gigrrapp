import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';

class MyGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final businessRepo = locator<BusinessRepo>();
  final user = locator<UserAuthResponseData>();

  bool onWillPop() {
    navigationService.clearStackAndShow(
      Routes.homeView,
      arguments: HomeViewArguments(
        initialIndex: user.isEmployer ? 0 : 1,
        isInitial: false,
      ),
    );
    return false;
  }
}
