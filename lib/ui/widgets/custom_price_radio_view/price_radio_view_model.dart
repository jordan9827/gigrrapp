import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class CustomPriceRadioButtonViewModel extends BaseViewModel {
  List<String> priceList = ["daily_price", "total_price"];

  String initialPrice = "daily_price";

  CustomPriceRadioButtonViewModel(TextEditingController controller) {
    controller.text = "price";
  }

  void setPrice(String? val, TextEditingController controller) {
    initialPrice = val!;
    controller.text = (val == "daily_price" ? "price" : "total");

    print("initialPrice $initialPrice");
    notifyListeners();
  }
}
