import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/repos/auth_impl.dart';
import 'package:square_demo_architecture/data/repos/notification_impl.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/chat_screen/chat_view.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/help_support_view.dart';
import 'package:square_demo_architecture/ui/account_screen/language_screen/language_view.dart';
import 'package:square_demo_architecture/ui/account_screen/payment_history_screen/payment_history_view.dart';
import 'package:square_demo_architecture/ui/auth_screen/forgetpassword_screen/forgetPassword_view.dart';
import 'package:square_demo_architecture/ui/notification_screen/notification_view.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../data/network/app_chopper_client.dart';
import '../data/network/dtos/user_auth_response_data.dart';
import '../data/repos/account_impl.dart';
import '../data/repos/business_impl.dart';
import '../domain/reactive_services/business_type_service.dart';
import '../domain/repos/account_repos.dart';
import '../domain/repos/auth_repos.dart';
import '../domain/repos/business_repos.dart';
import '../domain/repos/notification_repos.dart';
import '../ui/account_screen/about_us_screen/about_us_view.dart';
import '../ui/account_screen/businesses_screen/businesses_view.dart';
import '../ui/account_screen/businesses_screen/edit_businesses_screen/edit_businesses_view.dart';
import '../ui/account_screen/help_support_screen/support_email_screen/support_email_view.dart';
import '../ui/account_screen/privacy_policy/privacy_policy_view.dart';
import '../ui/account_screen/terms_and_conditions/terms_and_condition_view.dart';
import '../ui/add_gigs/add_gigs_view.dart';
import '../ui/auth_screen/edit_profile_screen/edit_profile_view.dart';
import '../ui/auth_screen/login_screen/login_view.dart';
import '../ui/auth_screen/otp_verify_screen/otp_verify_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/employer_business_form_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/employer_personal_form_view.dart';
import '../ui/home_screen/home_view.dart';
import '../ui/into_screen/intro_view.dart';
import '../ui/my_gigs/my_gigs_view.dart';
import '../ui/rating_review_screen/rating_review_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ForgetPasswordView),
    MaterialRoute(page: OTPVerifyScreen),
    MaterialRoute(page: HomeScreenView),
    MaterialRoute(page: IntroScreenView),
    MaterialRoute(page: MyGigss),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: RatingReviewScreenView),
    MaterialRoute(page: BusinessesScreenView),
    MaterialRoute(page: EditBusinessesScreenView),
    MaterialRoute(page: AboutUsScreenView),
    MaterialRoute(page: AddGigsScreenView),
    MaterialRoute(page: PrivacyPolicyScreenView),
    MaterialRoute(page: TermsAndConditionScreenView),
    MaterialRoute(page: HelpSupportScreenView),
    MaterialRoute(page: ChatScreenView),
    MaterialRoute(page: SupportEmailScreenView),
    MaterialRoute(page: LanguageScreenView),
    MaterialRoute(page: NotificationScreenView),
    MaterialRoute(page: EditProfileScreenView),
    MaterialRoute(page: PaymentHistoryScreenView),
    MaterialRoute(page: EmployerPersonalInfoFormView),
    MaterialRoute(page: EmployerBusinessInfoFormView),
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
      classType: AccountImpl,
      asType: AccountRepo,
    ),
    Factory(
      classType: NotificationImpl,
      asType: NotificationRepo,
    ),
    LazySingleton(
      classType: NavigationService,
    ),
    Presolve(
      classType: UserAuthResponseData,
      presolveUsing: UserAuthResponseData.getUserData,
    ),
    LazySingleton(
      classType: BusinessTypeService,
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
    ),
    Presolve(
      classType: BusinessImpl,
      asType: BusinessRepo,
      presolveUsing: BusinessImpl.getBusinessRepoImpl,
    ),
  ],
  logger: StackedLogger(),
)
class App {}
