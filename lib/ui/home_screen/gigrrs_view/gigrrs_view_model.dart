import 'package:flutter/material.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GigrrsViewModel extends BaseViewModel {
  final PageController pageController = PageController();
  final NavigationService navigationService = locator<NavigationService>();

  void navigateToGigrrDetailScreen() {
    navigationService.navigateTo(
      Routes.gigrrDetailView,
    );
  }
}
