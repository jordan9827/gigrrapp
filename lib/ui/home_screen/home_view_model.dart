import 'dart:developer';

import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.logger.dart';
import '../../data/network/dtos/user_auth_response_data.dart';

class HomeScreenViewModel extends BaseViewModel {
  BottomNavBarService bottomNavBarService = locator<BottomNavBarService>();
  final user = locator<UserAuthResponseData>();
  final log = getLogger("HomeScreenViewModel");

  HomeScreenViewModel() {
    log.i(
        "User Response --------------------------\nId= ${user.id}\nStatus= ${user.status}\nRole= ${user.roleId}\nToken= ${user.accessToken}\n--------------------");
  }

  void changeScreenIndex(int index) {
    bottomNavBarService.changeCurrentIndex(index);
    notifyListeners();
  }
}
