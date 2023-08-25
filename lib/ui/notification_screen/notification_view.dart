import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/data/network/dtos/get_notification_response.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/common_app_bar.dart';
import '../../util/others/text_styles.dart';
import '../widgets/empty_data_screen.dart';
import 'notification_view_model.dart';
import 'widget/notification_widget.dart';

class NotificationScreenView extends StatelessWidget {
  const NotificationScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NotificationScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "notifications",
          showBack: true,
          onBackPressed: viewModel.navigationToBack,
          actions: [
            InkWell(
              onTap: viewModel.deleteNotificationApi,
              child: Container(
                padding: EdgeInsets.only(
                  right: SizeConfig.margin_padding_10,
                ),
                alignment: Alignment.center,
                child: Text(
                  "clear_all".tr(),
                  style: TSB.regularSmall(
                    textColor: mainWhiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: ListView(
            children: [
              if (viewModel.todayList.isNotEmpty)
                _buildNotificationData(
                  title: "today",
                  list: viewModel.todayList,
                ),
              if (viewModel.weekList.isNotEmpty)
                _buildNotificationData(
                  title: "week",
                  list: viewModel.weekList,
                ),
              if (viewModel.monthList.isNotEmpty)
                _buildNotificationData(
                  title: "month",
                  list: viewModel.monthList,
                ),
              if (viewModel.yearList.isNotEmpty)
                _buildNotificationData(
                  title: "year",
                  list: viewModel.yearList,
                ),
              SizedBox(
                height: SizeConfig.margin_padding_20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationData({
    required String title,
    required List<NotificationList> list,
  }) {
    if (list.isEmpty) {
      return EmptyDataScreenView(
        enableBackButton: true,
      );
    } else {
      return Padding(
        padding: edgeInsetsMargin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.margin_padding_10,
            ),
            Text(
              title.tr(),
              style: TSB.semiBoldSmall(
                textColor: independenceColor,
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Column(
              children: list
                  .map(
                    (e) => NotificationWidget(item: e),
                  )
                  .toList(),
            )
          ],
        ),
      );
    }
  }
}
