import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/get_contact_subject.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/account_repos.dart';
import '../../../../domain/repos/common_repos.dart';

class SupportEmailViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final commonRepo = locator<CommonRepo>();
  final user = locator<UserAuthResponseData>();
  List<GetContactSubjectData> contactSubjectList = <GetContactSubjectData>[];
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  bool isVisible = false;
  int subjectId = 0;

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void onVisibleAction() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future<void> onItemSelect(String? val) async {
    subjectController.text = val ?? "";
    for (var i in contactSubjectList) {
      if (i.name.toLowerCase() == subjectController.text.toLowerCase()) {
        subjectId = i.id;
      }
    }
    notifyListeners();
  }

  Future<void> contactUS() async {
    if (validateInput()) {
      setBusy(true);
      final response = await commonRepo.contactSupport(
        await _getContactUSRequestBody(),
      );

      response.fold((failure) {
        setBusy(false);
      }, (response) {
        navigationService.back();
        snackBarService.showSnackbar(message: response.message);
        setBusy(false);
      });
    }
  }

  bool validateInput() {
    if (subjectController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_sel_contact_type".tr());
      return false;
    } else if (messageController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_msg".tr());
      return false;
    }
    return true;
  }

  Future<void> loadContactSubject() async {
    setBusy(true);
    final response = await commonRepo.fetchContactSubject();

    response.fold((failure) {
      snackBarService.showSnackbar(message: failure.errorMsg);
      setBusy(false);
    }, (response) {
      contactSubjectList.addAll(response);
      notifyListeners();
      setBusy(false);
    });
  }

  Future<Map<String, String>> _getContactUSRequestBody() async {
    Map<String, String> request = {};
    request['subject_id'] = "$subjectId";
    request['message'] = messageController.text;
    return request;
  }
}
