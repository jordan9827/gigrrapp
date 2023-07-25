import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/account_repos.dart';

class SupportEmailViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final accountRepo = locator<AccountRepo>();
  final user = locator<UserAuthResponseData>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> contactUS() async {
    if (validateInput()) {
      setBusy(true);
      final response =
          await accountRepo.saveChat(await _getContactUSRequestBody());

      response.fold((failure) {
        setBusy(false);
      }, (response) {
        navigationToBack();
        setBusy(false);
        log("message Response--------->>>>\n $response");
      });
    }
  }

  Future<Map<String, String>> _getContactUSRequestBody() async {
    Map<String, String> request = {};
    request['subject_id'] = "";
    request['message'] = messageController.text;
    return request;
  }

  bool validateInput() {
    if (messageController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_msg".tr());
      return false;
    }
    return true;
  }
}
