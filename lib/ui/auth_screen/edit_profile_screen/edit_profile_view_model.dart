import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class EditProfileViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();

  TextEditingController nameController =
      TextEditingController(text: "Jack Milton");
  TextEditingController mobileController =
      TextEditingController(text: "+91 1234567890");
  TextEditingController addressController =
      TextEditingController(text: "House no., Street name, Area");

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }
}
