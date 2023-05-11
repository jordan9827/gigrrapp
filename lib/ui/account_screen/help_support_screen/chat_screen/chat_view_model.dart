import 'dart:developer';

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
    setBusy(true);
    final response = await accountRepo.getChat(user.id);

    response.fold((failure) {
      setBusy(false);
    }, (response) {
      chatTextController.clear();
      helpChatList.clear();
      helpChatList.insert(0, response);
      setBusy(false);
      notifyListeners();
    });
  }

  Future<void> sentChat() async {
    if (validateInput()) {
      _isLoading = true;

      final response =
          await accountRepo.saveChat(await _getRequestForSendChat());

      response.fold((failure) {
        _isLoading = false;
      }, (response) {
        chatTextController.clear();
        helpChatList.clear();
        helpChatList.insert(0, response);
        _isLoading = false;
      });
    }
    notifyListeners();
  }

  Future<Map<String, String>> _getRequestForSendChat() async {
    Map<String, String> request = {};
    request['message'] = chatTextController.text;
    log("Chat Request Body :: $request");
    return request;
  }

  bool validateInput() {
    if (chatTextController.text.isEmpty) {
      snackBarService.showSnackbar(message: "Please enter message.");
      return false;
    }
    return true;
  }
}
