import 'package:easy_localization/easy_localization.dart';

import '../enums/register_login.dart';

extension RegisterLoginExtension on RegisterLogin {
  String get text {
    switch (this) {
      case RegisterLogin.Register:
        return 'register_text'.tr();
      default:
        return 'login_text'.tr();
    }
  }
}
