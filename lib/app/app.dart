import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/repos/auth_impl.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../data/network/app_chopper_client.dart';
import '../domain/repos/auth_repos.dart';
import '../ui/auth_screen/login_screen/login_view.dart';
import '../ui/auth_screen/otp_verify_screen/otp_verify_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/business_info_form_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/personal_info_form_view.dart';
import '../ui/home_screen/home_view.dart';
import '../ui/onboading_screen/intro_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: OTPVerifyScreen),
    MaterialRoute(page: HomeScreenView),
    MaterialRoute(page: IntroScreenView),
    MaterialRoute(page: PersonalInfoFormView),
    MaterialRoute(page: BusinessInfoFormView),
  ],
  dependencies: [
    Factory(
      classType: AuthImpl,
      asType: Auth,
    ),
    LazySingleton(
      classType: NavigationService,
    ),
    Presolve(
      classType: SharedPreferences,
      presolveUsing: SharedPreferences.getInstance,
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
  ],
  logger: StackedLogger(),
)
class App {}
