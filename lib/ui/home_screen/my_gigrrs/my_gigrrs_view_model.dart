import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';

class MyGirrsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final user = locator<UserAuthResponseData>();

  Future<void> refreshScreen() async {}
}
