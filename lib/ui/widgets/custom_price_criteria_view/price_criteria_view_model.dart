import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PriceCriteriaViewModel extends BaseViewModel {
  TextEditingController controller = TextEditingController();

  PriceCriteriaViewModel(TextEditingController con) {
    controller = con;
    controller.text = "hourly";
  }

  List<String> costCriteriaList = [
    "hourly",
    "daily",
    "weekly",
    "monthly",
    "total"
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
