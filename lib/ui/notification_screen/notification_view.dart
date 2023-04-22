import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: _buildEmptyNotificationView(viewModel),
            ),
          ],
        ),
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
