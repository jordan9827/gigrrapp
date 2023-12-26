import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.router.dart';
import '../../util/themes.dart';
import 'my_app_view_model.dart';

class MyAppView extends StatelessWidget {
  final AdaptiveThemeMode initialThemeMode;
  const MyAppView({
    super.key,
    this.initialThemeMode = AdaptiveThemeMode.system,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyAppViewModel>.nonReactive(
      onViewModelReady: (viewModel) {
        viewModel.setFcmService();
        viewModel.init();
      },
      viewModelBuilder: () => MyAppViewModel(),
      builder: (context, viewModel, child) {
        return FutureBuilder(
          future: viewModel.routeUser(),
          builder: (context, snapshot) {
            return AdaptiveTheme(
              // There is no light theme currently for the app.
              light: lightTheme,
              dark: darkTheme,
              initial: initialThemeMode,
              builder: (theme, darkTheme) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: theme.copyWith(
                    textSelectionTheme: const TextSelectionThemeData(
                      selectionHandleColor: Colors.transparent,
                    ),
                  ),
                  darkTheme: darkTheme.copyWith(
                    textSelectionTheme: const TextSelectionThemeData(
                      selectionHandleColor: Colors.transparent,
                    ),
                  ),
                  title: "Gigger App",
                  initialRoute: viewModel.initialRoute,
                  locale: context.locale,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  onGenerateRoute: StackedRouter().onGenerateRoute,
                  navigatorKey: StackedService.navigatorKey,
                  themeMode: ThemeMode.system,
                  navigatorObservers: [StackedService.routeObserver],
                );
              },
            );
          },
        );
      },
    );
  }
}
