import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:stacked/stacked.dart';

class HomeScreenViewModel extends BaseViewModel {
  BottomNavBarService bottomNavBarService = locator<BottomNavBarService>();

  void changeScreenIndex(int index) {
    bottomNavBarService.changeCurrentIndex(index);
    notifyListeners();
  }
}
