import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../data/local/preference_keys.dart';

class IntroScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final sharedPreferences = locator<SharedPreferences>();
  int currentPageValue = 0;
  int previousPageValue = 0;
  PageController pageController = PageController();

  Future<void> navigationToLoginView() async {
    // await sharedPreferences.setBool(PreferenceKeys.FIRST_TIME.text, false);
    navigationService.replaceWith(Routes.loginView);
  }

  void scrollPageList(double size) async {
    pageController.nextPage(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
  }
}
