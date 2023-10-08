import 'package:fcm_service/fcm_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:square_demo_architecture/data/repos/auth_impl.dart';
import 'package:square_demo_architecture/data/repos/notification_impl.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/chat_screen/chat_view.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/help_support_view.dart';
import 'package:square_demo_architecture/ui/account_screen/language_screen/language_view.dart';
import 'package:square_demo_architecture/ui/account_screen/payment_history_screen/payment_history_view.dart';
import 'package:square_demo_architecture/ui/auth_screen/forgetpassword_screen/forgetPassword_view.dart';
import 'package:square_demo_architecture/ui/no_internet_screen/no_internet_view.dart';
import 'package:square_demo_architecture/ui/notification_screen/notification_view.dart';
import 'package:square_demo_architecture/util/others/bottom_nav_bar_service.dart';
import 'package:square_demo_architecture/util/others/internet_check_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../data/network/app_chopper_client.dart';
import '../data/network/dtos/employer_request_preferences_model.dart';
import '../data/network/dtos/get_address_response.dart';
import '../data/network/dtos/user_auth_response_data.dart';
import '../data/repos/account_impl.dart';
import '../data/repos/business_impl.dart';
import '../data/repos/candidate_impl.dart';
import '../data/repos/common_impl.dart';
import '../domain/reactive_services/business_type_service.dart';
import '../domain/reactive_services/state_service.dart';
import '../domain/repos/account_repos.dart';
import '../domain/repos/auth_repos.dart';
import '../domain/repos/business_repos.dart';
import '../domain/repos/candidate_repos.dart';
import '../domain/repos/common_repos.dart';
import '../domain/repos/notification_repos.dart';
import '../ui/account_screen/about_us_screen/about_us_view.dart';
import '../ui/account_screen/businesses_screen/add_businesses_screen/add_businesses_view.dart';
import '../ui/account_screen/businesses_screen/businesses_view.dart';
import '../ui/account_screen/businesses_screen/edit_businesses_screen/edit_businesses_view.dart';
import '../ui/account_screen/candidate/bank_account_screen/add_bank_account_screen/add_bank_account_view.dart';
import '../ui/account_screen/candidate/bank_account_screen/add_upi_screen/add_upi_view.dart';
import '../ui/account_screen/candidate/bank_account_screen/bank_account_view.dart';
import '../ui/account_screen/candidate/candidate_preferences_screen/candidate_preferences_view.dart';
import '../ui/account_screen/candidate/manage_address_screen/add_address_screen/add_address_view.dart';
import '../ui/account_screen/candidate/manage_address_screen/manage_address_view.dart';
import '../ui/account_screen/employer/employer_preferences_screen/employer_preferences_view.dart';
import '../ui/account_screen/help_support_screen/support_email_screen/support_email_view.dart';
import '../ui/account_screen/language_screen/defualt_language_screen/defualt_language_view.dart';
import '../ui/account_screen/privacy_policy/privacy_policy_view.dart';
import '../ui/account_screen/select_payment_screen/select_payment_mode_view.dart';
import '../ui/account_screen/terms_and_conditions/terms_and_condition_view.dart';
import '../ui/add_gigs/add_gigs_view.dart';
import '../ui/auth_screen/edit_profile_screen/edit_profile_view.dart';
import '../ui/auth_screen/login_screen/login_view.dart';
import '../ui/auth_screen/otp_verify_screen/otp_verify_view.dart';
import '../ui/auth_screen/signup_screen/candidate_register_screen/candidate_register_view.dart';
import '../ui/auth_screen/signup_screen/candidate_register_screen/widget/candidate_kyc_screen/candidate_kyc_view.dart';
import '../ui/auth_screen/signup_screen/candidate_register_screen/widget/candidate_role_form_view.dart';
import '../ui/auth_screen/signup_screen/employer_register_screen/employer_register_view.dart';
import '../ui/home_screen/employer_gigrr_view/candidate_offer_create_gigrr_view.dart';
import '../ui/home_screen/employer_gigrr_view/employer_gigrr_detail_view/employer_gigrr_detail_view.dart';
import '../ui/home_screen/home_view.dart';
import '../ui/home_screen/my_gigrrs/screen/my_gigrrs_detail_view.dart';
import '../ui/home_screen/my_gigs/employer_gigs_screen/screen/candidate_offer_view.dart';
import '../ui/into_screen/intro_view.dart';
import '../ui/rating_review_screen/rating_review_view.dart';
import '../ui/widgets/giggr_request_view.dart';
import '../ui/widgets/map_view.dart';

@StackedApp(
  routes: [
    ///// Auth /////
    MaterialRoute(page: LoginView),
    MaterialRoute(page: ForgetPasswordView),
    MaterialRoute(page: OTPVerifyScreen),
    MaterialRoute(page: EditProfileScreenView),
    MaterialRoute(page: CandidateKYCScreenView),
    MaterialRoute(page: EmployerRegisterScreenView),
    MaterialRoute(page: CandidateRegisterScreenView),

    ///// Businesses /////
    MaterialRoute(page: MyGigrrsDetailView),
    MaterialRoute(page: GoogleMapViewScreen),
    MaterialRoute(page: EmployerPreferenceScreenView),
    MaterialRoute(page: EmployerGigrrDetailView),
    MaterialRoute(page: CandidateOfferView),
    MaterialRoute(page: SelectPaymentModeView),
    MaterialRoute(page: BusinessesScreenView),
    MaterialRoute(page: AddBusinessesScreenView),
    MaterialRoute(page: EditBusinessesScreenView),
    MaterialRoute(page: CandidateOfferToCreateGigrrView),

    ///// Account /////
    MaterialRoute(page: CandidateRoleFormView),
    MaterialRoute(page: AddUpiView),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: ChatScreenView),
    MaterialRoute(page: SelectDefaultLanguageView),
    MaterialRoute(page: AboutUsScreenView),
    MaterialRoute(page: BankAccountScreenView),
    MaterialRoute(page: ManageAddressScreenView),
    MaterialRoute(page: AddBankAccountScreenView),
    MaterialRoute(page: AddAddressScreenView),
    MaterialRoute(page: PaymentHistoryScreenView),
    MaterialRoute(page: PrivacyPolicyScreenView),
    MaterialRoute(page: HelpSupportScreenView),
    MaterialRoute(page: SupportEmailScreenView),
    MaterialRoute(page: TermsAndConditionScreenView),
    MaterialRoute(page: CandidatePreferenceScreenView),

    MaterialRoute(page: HomeView),
    MaterialRoute(page: IntroScreenView),
    MaterialRoute(page: RatingReviewScreenView),
    MaterialRoute(page: AddGigsScreenView),
    MaterialRoute(page: LanguageScreenView),
    MaterialRoute(page: NotificationScreenView),
    MaterialRoute(page: NoInternetView),
  ],
  dependencies: [
    Presolve(
      classType: SharedPreferences,
      presolveUsing: SharedPreferences.getInstance,
    ),
    Presolve(
      classType: FCMService,
      presolveUsing: FCMService.getInstance,
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
      classType: CommonImpl,
      asType: CommonRepo,
    ),
    Factory(
      classType: CandidateImpl,
      asType: CandidateRepo,
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
    Presolve(
      classType: EmployerRequestPreferencesResp,
      presolveUsing: EmployerRequestPreferencesResp.getUserData,
    ),
    Presolve(
      classType: GetAddressResponseData,
      presolveUsing: GetAddressResponseData.getUserAddressData,
    ),
    LazySingleton(
      classType: BusinessTypeService,
    ),
    LazySingleton(
      classType: StateCityService,
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
    LazySingleton(
      classType: InternetCheckService,
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
