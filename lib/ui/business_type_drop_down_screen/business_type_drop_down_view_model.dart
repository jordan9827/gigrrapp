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
  String groupValue = "";
  List<String> itemsList = [];
  bool isVisible = false;

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> setBusinessTypeList() async {
    for (var i in businessTypeService.businessTypeList) {
      itemsList.add(i.name);
      groupValue = itemsList.first;
      notifyListeners();
    }
  }

  void onItemSelect(String? val) {
    groupValue = val!;
    notifyListeners();
  }

  String? onSelectId() {
    for (var i in businessTypeService.businessTypeList) {
      if (i.name == groupValue) {
        return i.id.toString();
      }
    }
    return null;
  }
}
