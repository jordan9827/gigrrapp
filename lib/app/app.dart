import 'package:square_demo_architecture/data/repos/auth_impl.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../data/network/app_chopper_client.dart';
import '../domain/repos/auth_repos.dart';
import '../ui/home_screen/home_view.dart';
import '../ui/login_screen/login_view.dart';
import '../ui/signup_screen/signup_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: HomeScreenView),
  ],
  dependencies: [
    Factory(
      classType: AuthImpl,
      asType: Auth,
    ),
    LazySingleton(
      classType: NavigationService,
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
