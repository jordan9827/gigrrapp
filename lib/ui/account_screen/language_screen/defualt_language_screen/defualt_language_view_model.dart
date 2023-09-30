import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.locator.dart';
import '../../../../data/local/preference_keys.dart';
import '../../../../util/others/image_constants.dart';

class SelectDefaultLanguageViewModel extends BaseViewModel {
  final sharedPreferences = locator<SharedPreferences>();
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  String initialSelected = "";
  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void onChange(String value) {
    this.initialSelected = value;
    notifyListeners();
  }

  Future<void> setLanguage() async {
    await sharedPreferences.setString(
      PreferenceKeys.APP_LANGUAGE.text,
      initialSelected,
    );
    Restart.restartApp();
  }
}

class LanguageModel {
  final String image;
  final String name;
  final String code;

  LanguageModel({
    this.image = "",
    this.name = "",
    this.code = "",
  });

  static List<LanguageModel> list = [
    LanguageModel(
      image: ic_india,
      name: "हिन्दी",
      code: "hi",
    ),
    LanguageModel(
      image: ic_us,
      name: "English",
      code: "en",
    ),
  ];
}
