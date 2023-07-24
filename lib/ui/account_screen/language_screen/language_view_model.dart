import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';

class LanguageScreenViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final sharedPreferences = locator<SharedPreferences>();
  String language = LanguageModel.languageList.first.id;

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> initLocale() async {
    language = sharedPreferences.getString("language_select") ??
        LanguageModel.languageList.first.id;
  }

  void setLanguage(String value, BuildContext context) {
    language = value;
    EasyLocalization.of(context)!.setLocale(Locale(value));
    sharedPreferences.setString("language_select", value);
    notifyListeners();
  }
}

class LanguageModel {
  final String id;
  final String name;

  LanguageModel({
    required this.id,
    required this.name,
  });

  static List<LanguageModel> languageList = [
    LanguageModel(id: "en", name: "English"),
    LanguageModel(id: "hi", name: "Hindi"),
  ];
}
