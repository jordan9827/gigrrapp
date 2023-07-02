import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PriceCriteriaViewModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();

  PriceCriteriaViewModel(TextEditingController con) {
    controller = con;
    controller.text = "Hourly";
  }

  List<String> costCriteriaList = [
    "Hourly",
    "Daily",
    "Weekly",
    "Monthly",
    "Total"
  ];
  bool isVisible = false;

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void onCostCriteriaSelect(String? val) {
    controller.text = val!;
    print("onCostCriteriaSelect :: " + controller.text);
    notifyListeners();
  }
}
