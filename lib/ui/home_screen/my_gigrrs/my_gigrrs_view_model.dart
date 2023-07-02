import 'dart:math';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:square_demo_architecture/domain/repos/business_repos.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../data/network/dtos/user_auth_response_data.dart';

class MyGigrrsViewModel extends BaseViewModel {
  final snackBarService = locator<SnackbarService>();
  final navigationService = locator<NavigationService>();
  final user = locator<UserAuthResponseData>();
  final businessRepo = locator<BusinessRepo>();
  Map<String, dynamic> calender = <String, dynamic>{};
  DataSource dataSource = DataSource([]);

  MyGigrrsViewModel() {
    fetchCalender();
  }

  Future<void> refreshScreen() async {}

  Future<void> fetchCalender() async {
    setBusy(true);
    var result = await businessRepo.getCandidate();
    result.fold((fail) {
      snackBarService.showSnackbar(message: fail.errorMsg);
      setBusy(false);
    }, (res) {
      calender = res;
      dataSource = DataSource(_getAppointments());
      setBusy(false);
      notifyListeners();
    });
  }

  void navigationToMyGigrrsDetailView(CalendarTapDetails val) {
    if (val.appointments != null) {
      String id = val.appointments!.first.id.toString();
      print("appointments ID $id");
      navigationService.navigateTo(
        Routes.myGigrrsDetailView,
        arguments: MyGigrrsDetailViewArguments(id: id),
      );
    }
  }

  List<Appointment> _getAppointments() {
    final List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    final List<Color> colorCollection = <Color>[];
    colorCollection.add(mainPinkColor.withOpacity(0.8));
    colorCollection.add(independenceColor.withOpacity(0.9));
    colorCollection.add(mainPinkColor.withOpacity(0.7));
    colorCollection.add(independenceColor.withOpacity(0.8));
    colorCollection.add(mainPinkColor.withOpacity(0.6));
    colorCollection.add(independenceColor.withOpacity(0.7));
    colorCollection.add(mainPinkColor.withOpacity(0.8));
    colorCollection.add(independenceColor.withOpacity(0.9));
    colorCollection.add(mainPinkColor.withOpacity(0.7));
    colorCollection.add(independenceColor.withOpacity(0.8));

    final Random random = Random();
    final DateTime rangeStartDate =
        DateTime.now().add(const Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = DateTime.now().add(const Duration(days: 365));
    final List<Appointment> appointments = <Appointment>[];
    for (DateTime i = rangeStartDate;
        i.isBefore(rangeEndDate);
        i = i.add(const Duration(days: 1))) {
      final DateTime date = i;

      final DateTime startDate = DateTime(
          date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
      var formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(startDate);
      if (calender.containsKey(formattedDate.toString())) {
        for (var map in calender[formattedDate]) {
          var mapInside = map["gigs_request_details"];
          String gigsId = map["id"].toString();
          String name = map["gig_name"];
          String startTime = map["gigs_starttime"];
          String endTime = map["gigs_endtime"];
          appointments.add(
            Appointment(
              subject: name,
              id: gigsId,
              startTime: DateFormat("yyyy-MM-dd HH:mm")
                  .parse(formattedDate + " " + startTime),
              endTime: DateFormat("yyyy-MM-dd HH:mm")
                  .parse(formattedDate + " " + endTime),
              color: colorCollection[random.nextInt(9)],
              isAllDay: false,
            ),
          );
        }
      }
    }
    return appointments;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
