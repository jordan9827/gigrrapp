import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/widget/my_giggrrs_widget.dart';
import 'package:stacked/stacked.dart';
import '../../../../data/network/dtos/my_gigs_response.dart';
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

  const MyGigrrsDetailView({
    Key? key,
    this.id = "",
  }) : super(key: key);

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
          child: RefreshIndicator(
            color: independenceColor,
            onRefresh: viewModel.fetchMyGigrrRoster,
            child: viewModel.isBusy
                ? EmptyDataScreenView()
                : ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.margin_padding_10,
                      horizontal: SizeConfig.margin_padding_15,
                    ),
                    children: viewModel.gigrrsData.gigsRequestData
                        .map(
                          (e) => MyGigrrsWidget(
                            data: e,
                            statusView: _buildShortListGigsStatusView(
                              data: e,
                              viewModel: viewModel,
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildShortListGigsStatusView({
    required GigsRequestData data,
    required MyGigrrsDetailViewModel viewModel,
  }) {
    var status = viewModel.getGigStatus(data);
    var buttonText = viewModel.statusForMyGigrrsAction(data);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "job_status".tr(),
              style: TSB.semiBoldSmall(),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_3,
            ),
            Text(
              status.tr(),
              style: TSB.regularSmall(
                textColor: mainPinkColor,
              ),
            ),
          ],
        ),
        _buildStartEndOTPView(
          status: status.toLowerCase(),
          otp: viewModel.jobOTP,
        ),
        if (viewModel.isButtonVisible)
          _buildActionButton(
            buttonText: buttonText.tr(),
            onTap: () => viewModel.navigationToStatusForGigs(data),
          )
      ],
    );
  }

  Widget _buildStartEndOTPView({
    String otp = "",
    String status = "",
  }) {
    var title = status == "roster" ? "start_otp" : "end_otp";
    if ((status == "roster" || status == "start") && otp.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title.tr(),
            style: TSB.semiBoldSmall(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_3,
          ),
          Text(
            otp,
            style: TSB.regularSmall(
              textColor: mainPinkColor,
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
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
          border: Border.all(
            color: mainPinkColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_8,
          ),
        ),
        child: Text(
          buttonText.tr(),
          style: TSB.regularVSmall(
            textColor: mainPinkColor,
          ),
        ),
      ),
    );
  }
}
