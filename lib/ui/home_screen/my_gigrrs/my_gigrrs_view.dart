import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import '../../../util/others/calander_parsing.dart';
import '../../widgets/empty_data_screen.dart';
import '../../widgets/notification_icon.dart';
import 'my_gigrrs_view_model.dart';

class MyGirrsView extends StatelessWidget {
  const MyGirrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MyGigrrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "my_gigrrs",
            backgroundColor: mainWhiteColor,
            textColor: mainBlackColor,
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: RefreshIndicator(
              onRefresh: viewModel.refreshScreen,
              child: _buildCalenderView(viewModel),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCalenderView(MyGigrrsViewModel viewModel) {
    return viewModel.dataSource.appointments!.isNotEmpty
        ? SfCalendar(
            showDatePickerButton: true,
            scheduleViewMonthHeaderBuilder: _buildScheduleViewBuilder,
            view: CalendarView.schedule,
            dataSource: viewModel.dataSource,
            onTap: viewModel.navigationToMyGigrrsDetailView,
          )
        : EmptyDataScreenView();
  }

  Widget _buildScheduleViewBuilder(
    BuildContext buildContext,
    ScheduleViewMonthHeaderDetails details,
  ) {
    final String monthName = CalenderParsing.getMonthDate(details.date.month);
    return Stack(
      children: <Widget>[
        Image(
          image: AssetImage('assets/calender/' + monthName + '.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height,
        ),
        Positioned(
          left: 55,
          right: 0,
          top: 20,
          bottom: 0,
          child: Text(
            monthName + ' ' + details.date.year.toString(),
            style: const TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
