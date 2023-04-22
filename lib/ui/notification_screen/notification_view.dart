import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/common_app_bar.dart';
import '../../util/others/image_constants.dart';
import '../../util/others/text_styles.dart';
import 'notification_view_model.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({Key? key}) : super(key: key);

  @override
  State<NotificationScreenView> createState() => _NotificationScreenViewState();
}

class _NotificationScreenViewState extends State<NotificationScreenView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NotificationScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: getAppBar(
          context,
          "notifications",
          showBack: true,
        ),
        body: ListView(
          children: [
            // Align(
            //   alignment: Alignment.center,
            //   child: _buildEmptyNotificationView(viewModel),
            // ),
            _buildNotificationData(viewModel)
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationData(NotificationScreenViewModel viewModel) {
    return Padding(
      padding: edgeInsetsMargin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_15,
          ),
          Text(
            "Today",
            style: TSB.semiBoldSmall(textColor: independenceColor),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return _buildMessageUI();
              })
        ],
      ),
    );
  }

  Widget _buildMessageUI() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(SizeConfig.margin_padding_10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(ic_edit_profile),
            radius: SizeConfig.margin_padding_18,
          ),
          SizedBox(
            width: SizeConfig.margin_padding_15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Gigrr Suresh Kumar arrived.",
                maxLines: 3,
                softWrap: false,
                style: TSB.regularLarge(),
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              Text(
                "Oct 16, 2021",
                style: TSB.regularSmall(textColor: textNoticeColor),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEmptyNotificationView(NotificationScreenViewModel viewModel) {
    return Column(
      children: [
        Image.asset(
          ic_obj_no_notification,
          scale: 3,
        ),
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          textAlign: TextAlign.center,
          "notifications_empty_message".tr(),
          style: TSB.regularLarge(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_20,
        ),
        SizedBox(
          width: SizeConfig.margin_padding_50 * 5,
          child: LoadingButton(
            action: () {},
            title: "go_to_home",
          ),
        )
      ],
    );
  }
}
