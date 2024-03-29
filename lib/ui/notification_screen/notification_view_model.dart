import 'package:easy_localization/easy_localization.dart';
import 'package:square_demo_architecture/domain/repos/notification_repos.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../data/network/dtos/get_notification_response.dart';

class NotificationScreenViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  final notificationRepo = locator<NotificationRepo>();
  List<NotificationList> notificationList = <NotificationList>[];

  NotificationScreenViewModel() {
    fetchAllNotificationApi();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  Future<void> fetchAllNotificationApi() async {
    setBusy(true);
    final response = await notificationRepo.fetchNotifications();
    response.fold(
      (fail) {
        setBusy(false);
        snackBarService.showSnackbar(message: fail.errorMsg);
      },
      (response) async {
        notificationList = response.notificationList;
        notifyListeners();
        setBusy(false);
      },
    );
    notifyListeners();
  }

  Future<void> deleteNotificationApi() async {
    setBusy(true);
    final response = await notificationRepo.deleteNotifications();
    response.fold(
      (fail) {
        setBusy(false);
        snackBarService.showSnackbar(message: fail.errorMsg);
      },
      (response) async {
        notificationList.clear();
        setBusy(false);
      },
    );
    notifyListeners();
  }
}
