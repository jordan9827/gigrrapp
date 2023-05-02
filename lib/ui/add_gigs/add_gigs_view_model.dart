import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../domain/repos/auth_repos.dart';

class AddGigsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  PageController controller = PageController();
  List<String> priceList = ["daily_price", "total_price"];
  int pageIndex = 0;
  String initialPrice = "daily_price";

  bool onWillPop() {
    controller.previousPage(
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    return false;
  }

  void setPrice(String? val) {
    initialPrice = val!;
    notifyListeners();
  }

  void setPageIndex(int? val) {
    pageIndex = val!;
    notifyListeners();
  }

  void navigationToNextPage() {
    controller.animateToPage(
      1,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }
}
