import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/repos/auth_impl.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/help_support_view.dart';
import 'package:square_demo_architecture/ui/account_screen/language_screen/language_view.dart';
import 'package:square_demo_architecture/ui/account_screen/payment_history_screen/payment_history_view.dart';
import 'package:square_demo_architecture/ui/notification_screen/notification_view.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../data/network/app_chopper_client.dart';
import '../data/network/dtos/user_auth_response_data.dart';
import '../data/repos/business_impl.dart';
import '../domain/repos/auth_repos.dart';
import '../domain/repos/business_repos.dart';
import '../ui/auth_screen/edit_profile_screen/edit_profile_view.dart';
import '../ui/auth_screen/login_screen/login_view.dart';
import '../ui/auth_screen/otp_verify_screen/otp_verify_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/employ_business_form_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/employ_personal_form_view.dart';
import '../ui/home_screen/home_view.dart';
import '../ui/onboading_screen/intro_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OTPVerifyScreen),
    MaterialRoute(page: HomeScreenView),
    MaterialRoute(page: IntroScreenView),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: HelpSupportScreenView),
    MaterialRoute(page: LanguageScreenView),
    MaterialRoute(page: NotificationScreenView),
    MaterialRoute(page: EditProfileScreenView),
    MaterialRoute(page: PaymentHistoryScreen),
    MaterialRoute(page: EmployPersonalInfoFormView),
    MaterialRoute(page: EmployBusinessInfoFormView),
  ],
  dependencies: [
    Presolve(
      classType: SharedPreferences,
      presolveUsing: SharedPreferences.getInstance,
    ),
    Factory(
      classType: AuthImpl,
      asType: Auth,
    ),
    Factory(
      classType: BusinessImpl,
      asType: Business,
    ),
    LazySingleton(
      classType: NavigationService,
    ),
    Presolve(
      classType: UserAuthResponseData,
      presolveUsing: UserAuthResponseData.getUserData,
    ),
    LazySingleton(
      classType: DialogService,
    ),
    LazySingleton(
      classType: SnackbarService,
    ),
    LazySingleton(
      classType: AppChopperClient,
    ),
    LazySingleton(
      classType: BottomNavBarService,
    )
  ],
  logger: StackedLogger(),
)
class App {}
