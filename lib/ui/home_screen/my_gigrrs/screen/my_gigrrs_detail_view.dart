import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/widget/my_giggrrs_widget.dart';
import 'package:stacked/stacked.dart';
import '../../../../others/common_app_bar.dart';
import '../../../../others/constants.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/empty_data_screen.dart';
import '../../../widgets/notification_icon.dart';
import 'my_gigrrs_detail_view_model.dart';

class MyGigrrsDetailView extends StatelessWidget {
  final String id;
  const MyGigrrsDetailView({Key? key, this.id = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchMyGigrrRoster(),
      viewModelBuilder: () => MyGigrrsDetailViewModel(id),
      builder: (_, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "my_gigrrs_detail",
          showBack: true,
          showBackColor: mainBlackColor,
          backgroundColor: mainWhiteColor,
          textColor: mainBlackColor,
          onBackPressed: viewModel.navigationToBack,
          actions: [
            NotificationIcon(),
          ],
        ),
        body: LoadingScreen(
          loading: viewModel.isBusy,
          child: viewModel.isBusy
              ? EmptyDataScreenView()
              : MyGigrrsWidget(
                  statusView:
                      _buildShortListGigsStatusView(viewModel: viewModel),
                ),
        ),
      ),
    );
  }

  Widget _buildShortListGigsStatusView({
    required MyGigrrsDetailViewModel viewModel,
  }) {
    var status = viewModel.getGigStatus();
    var buttonText = viewModel.statusForMyGigrrs();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              "Job Status",
              style: TSB.semiBoldSmall(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_3,
            ),
            Text(
              status,
              style: TSB.regularSmall(
                textColor: mainPinkColor,
              ),
            ),
          ],
        ),
        _buildActionButton(
          buttonText: buttonText.tr(),
          onTap: viewModel.navigationToStatusForGigs,
        )
      ],
    );
  }

  Widget _buildActionButton({
    required Function() onTap,
    String buttonText = "",
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_17,
          vertical: SizeConfig.margin_padding_8,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: mainPinkColor, width: 1.5),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_8,
          ),
        ),
        child: Text(
          buttonText.tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }
}
