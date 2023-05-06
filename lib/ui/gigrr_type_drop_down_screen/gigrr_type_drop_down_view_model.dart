import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../data/network/dtos/business_type_category.dart';
import '../../../../../domain/repos/auth_repos.dart';
import '../../../../../domain/repos/business_repos.dart';
import '../../data/network/dtos/gigrr_type_response.dart';
import '../../domain/reactive_services/business_type_service.dart';

class GigrrTypeDropDownViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessRepo = locator<BusinessRepo>();
  final businessTypeService = locator<BusinessTypeService>();
  TextEditingController textController = TextEditingController();
  List<GigrrTypeCategoryList> gigrrTypeList = [];

  List<String> selectedItemList = [];
  List<String> itemsList = [];
  bool isVisible = false;
  GigrrTypeDropDownViewModel(TextEditingController controller) {
    this.textController = controller;
  }
  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> setGigrrTypeList() async {
    for (var i in businessTypeService.gigrrTypeList) {
      itemsList.add(i.name);
      notifyListeners();
    }
  }

  void onItemSelect(bool selected, int index) {
    if (selected == true) {
      if (selectedItemList.length < 3) {
        selectedItemList.add(itemsList[index]);
      } else
        snackBarService.showSnackbar(message: "Select UpTo 3");
    } else {
      selectedItemList.remove(itemsList[index]);
    }
    setItemID();
    notifyListeners();
  }

  void setItemID() {
    List id = [];
    for (var i in businessTypeService.gigrrTypeList) {
      for (var p in selectedItemList) {
        if (i.name == p) {
          id.add(i.id);
          textController.text = id.join(", ");
        }
      }
      notifyListeners();
    }
  }

  void remove(int index) {
    selectedItemList.removeAt(index);
    notifyListeners();
  }
}
