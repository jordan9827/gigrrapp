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
  List<NotificationList> todayList = <NotificationList>[];
  List<NotificationList> weekList = <NotificationList>[];
  List<NotificationList> monthList = <NotificationList>[];
  List<NotificationList> yearList = <NotificationList>[];

  NotificationScreenViewModel() {
    fetchAllNotificationApi();
  }

  void navigationToBack() {
    if (!isBusy) {
      navigationService.back();
    }
    return;
  }

  bool get isListEmpty => (todayList.isEmpty &&
      weekList.isEmpty &&
      monthList.isEmpty &&
      yearList.isEmpty);

  Future<void> clearList() async {
    todayList.clear();
    weekList.clear();
    monthList.clear();
    yearList.clear();
  }

  Future<void> refreshScreen() async {
    await clearList();
    await fetchAllNotificationApi();
    notifyListeners();
  }

  Future<void> fetchAllNotificationApi() async {
    setBusy(true);
    final response = await notificationRepo.fetchNotifications();
    response.fold(
      (fail) {
        setBusy(false);
        snackBarService.showSnackbar(
          message: fail.errorMsg,
        );
      },
      (response) async {
        clearList();
        await getSortedDateList(
          response.notificationList,
        );
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
        snackBarService.showSnackbar(
          message: fail.errorMsg,
        );
      },
      (response) async {
        setBusy(false);
      },
    );
    notifyListeners();
  }

  Future<void> getSortedDateList(
    List<NotificationList> list,
  ) async {
    DateTime currentDate = DateTime.now();
    for (var e in list) {
      var date = DateTime.parse(e.createdAt);
      if (currentDate.difference(date).inDays < 1) {
        todayList.add(e);
      } else if (currentDate.difference(date).inDays <= 7) {
        weekList.add(e);
      } else if (currentDate.difference(date).inDays <= 30 &&
          !weekList.contains(date)) {
        monthList.add(e);
      } else {
        yearList.add(e);
      }
    }
    notifyListeners();
  }
}
