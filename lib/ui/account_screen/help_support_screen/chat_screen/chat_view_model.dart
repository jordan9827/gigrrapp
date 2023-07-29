import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/data/network/dtos/chat_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../../app/app.locator.dart';
import '../../../../data/network/dtos/user_auth_response_data.dart';
import '../../../../domain/repos/account_repos.dart';

class ChatViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final accountRepo = locator<AccountRepo>();
  final user = locator<UserAuthResponseData>();

  TextEditingController chatTextController = TextEditingController();
  List<ChatResponseData> helpChatList = [];
  int currentPage = 1;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool loadMore = false;
  bool loadMoreFlag = false;
  String userId = '';
  bool isPressed = false;
  bool apiCalling = false;
  ScrollController? controller;

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> fetchChatList() async {
    // setBusy(true);
    _isLoading = true;
    final response = await accountRepo.getChat();

    response.fold((failure) {
      setBusy(false);
    }, (response) {
      chatTextController.clear();
      helpChatList.clear();
      helpChatList.addAll(response.chatList);
      _isLoading = false;
      setBusy(false);
      notifyListeners();
    });
  }

  Future<void> sentChat() async {
    if (validateInput()) {
      setBusy(true);
      final response =
          await accountRepo.saveChat(await _getRequestForSendChat());

      response.fold((failure) {
        setBusy(false);
      }, (response) {
        chatTextController.clear();
        helpChatList.insert(0, response);
        notifyListeners();
        setBusy(false);
      });
    }
  }

  Future<Map<String, String>> _getRequestForSendChat() async {
    Map<String, String> request = {};
    request['message'] = chatTextController.text;
    return request;
  }

  bool validateInput() {
    if (chatTextController.text.isEmpty) {
      snackBarService.showSnackbar(message: "plz_enter_msg".tr());
      return false;
    }
    return true;
  }
}
