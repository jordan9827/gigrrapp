import 'package:square_demo_architecture/data/network/dtos/faq_response.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../domain/repos/account_repos.dart';
import '../../../domain/repos/common_repos.dart';

class HelpSupportScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final commonRepo = locator<CommonRepo>();

  List<FAQResponseData> faqData = [];
  bool isVisible = false;

  HelpSupportScreenViewModel() {
    fetchFAQ();
  }

  void onActionVisible() {
    isVisible = !isVisible;
    notifyListeners();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  void navigationToChatView() {
    navigationService.navigateTo(Routes.chatScreenView);
  }

  void navigationToSupportEmailView() {
    navigationService.navigateTo(Routes.supportEmailScreenView);
  }

  Future<void> fetchFAQ() async {
    setBusy(true);
    final response = await commonRepo.faq();
    response.fold(
      (fail) {
        snackBarService.showSnackbar(message: fail.errorMsg);
        setBusy(false);
      },
      (faqList) async {
        faqData = faqList;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
