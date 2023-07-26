import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.router.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';

class CandidateGigrrDetailViewModel extends BaseViewModel {
  final NavigationService navigationServices = locator<NavigationService>();
  final user = locator<UserAuthResponseData>();
  TextEditingController priceController = TextEditingController();
  TextEditingController priceTypeController = TextEditingController();
  void navigateBack() {
    navigationServices.back();
  }

  void navigatorToGiggrRequestView(String name) {}
}
