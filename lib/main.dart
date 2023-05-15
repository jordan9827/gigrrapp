import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:square_demo_architecture/ui/my_app/my_app_view.dart';
import 'package:square_demo_architecture/util/others/internet_check_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
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
  Future.delayed(Duration(seconds: 3))
      .then((value) => FlutterNativeSplash.remove());
  locator<InternetCheckService>().initializeInternetCheckServices();
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
