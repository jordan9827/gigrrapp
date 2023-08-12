import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/domain/reactive_services/state_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../domain/repos/auth_repos.dart';

class StateCityWidgetViewModel extends BaseViewModel {
  final authRepo = locator<Auth>();
  final stateCityService = locator<StateCityService>();
  final snackBarService = locator<SnackbarService>();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isVisibleForState = false;
  bool isVisibleForCity = false;

  StateCityWidgetViewModel({
    required TextEditingController state,
    required TextEditingController city,
  }) {
    this.stateController = state;
    this.cityController = city;
  }

  void onVisibleActionForState() {
    isVisibleForState = !isVisibleForState;
    notifyListeners();
  }

  void onVisibleActionForCity() {
    if (stateCityService.stateList.isNotEmpty) {
      isVisibleForCity = !isVisibleForCity;
    } else {
      snackBarService.showSnackbar(message: "plz_sel_state_first".tr());
    }
    notifyListeners();
  }

  Future<void> onItemSelectForState(String? val) async {
    stateController.text = val ?? "";
    cityController.clear();
    for (var i in stateCityService.stateList) {
      if (i.name.toLowerCase() == stateController.text.toLowerCase()) {
        setBusy(true);
        await authRepo.loadCity(i.id);
        setBusy(false);
      }
    }
    notifyListeners();
  }

  Future<void> onItemSelectForCity(String? val) async {
    cityController.text = val ?? "";
    notifyListeners();
  }
}
