import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../domain/repos/auth_repos.dart';
import '../../domain/reactive_services/business_type_service.dart';

class BusinessTypeDropDownViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final authRepo = locator<Auth>();
  final businessTypeService = locator<BusinessTypeService>();
  TextEditingController textController = TextEditingController();

  String groupValue = "";
  List<String> itemsList = [];
  bool isVisible = false;

  BusinessTypeDropDownViewModel(TextEditingController controller) {
    this.textController = controller;
    int();
  }
  void int() async {
    setBusinessTypeList();
    await setInitialIndex();
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> setBusinessTypeList() async {
    print("setBusinessTypeList--------? ${textController.text}");
    for (var i in businessTypeService.businessTypeList) {
      itemsList.add(i.name);
    }
    notifyListeners();
  }

  Future<void> setInitialIndex() async {
    var list = businessTypeService.businessTypeList;
    for (var i in list) {
      if (textController.text.toString() == i.id.toString()) {
        print("setInitialIndex 11@ ${textController.text}");
        groupValue = i.name;
        return;
      } else if (textController.text.isEmpty) {
        print("setInitialIndex 22@ ${textController.text}");
        groupValue = itemsList.first;
        textController.text = list.first.id.toString();
      }
    }
    notifyListeners();
  }

  void onItemSelect(String? val) {
    groupValue = val!;
    print(val);
    onSelectId();
    notifyListeners();
  }

  void onSelectId() {
    for (var i in businessTypeService.businessTypeList) {
      if (i.name == groupValue) {
        textController.text = i.id.toString();
        notifyListeners();
      }
    }
  }
}
