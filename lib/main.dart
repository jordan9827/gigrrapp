import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:square_demo_architecture/ui/my_app/my_app_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/app.locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //add license for google font (update)
  LicenseRegistry.addLicense(
    () async* {
      final license = await rootBundle.loadString('fonts/Inter/OFL.txt');
      yield LicenseEntryWithLineBreaks(
        ['google_fonts'],
        license,
      );
    },
  );
  await EasyLocalization.ensureInitialized();
  final initialThemeMode =
      (await AdaptiveTheme.getThemeMode()) ?? AdaptiveThemeMode.system;

  await setupLocator(environment: Environment.dev);

  locator<SnackbarService>().registerSnackbarConfig(
    SnackbarConfig(
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      animationDuration: const Duration(seconds: 1),
    ),
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      useOnlyLangCode: true,
      fallbackLocale: const Locale('en'),
      path: "assets/translations",
      child: MyAppView(
        initialThemeMode: initialThemeMode,
      ),
    ),
  );
}
