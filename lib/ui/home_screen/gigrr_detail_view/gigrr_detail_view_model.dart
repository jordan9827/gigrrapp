import 'package:square_demo_architecture/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class GigrrDetailViewModel extends BaseViewModel {
  final NavigationService navigationServices = locator<NavigationService>();

  void navigateBack() {
    navigationServices.back();
  }
}
