import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/common_app_bar.dart';
import 'package:stacked/stacked.dart';

import '../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../others/constants.dart';
import '../../../../others/loading_screen.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';
import '../../../widgets/empty_data_screen.dart';
import '../../../widgets/notification_icon.dart';
import '../../../widgets/stacked_widget.dart';
import '../widget/my_gigs_view_widget.dart';
import 'employer_gigs_view_model.dart';

class EmployerGigsView extends StatefulWidget {
  const EmployerGigsView({Key? key}) : super(key: key);

  @override
  State<EmployerGigsView> createState() => _EmployerGigsViewState();
}

class _EmployerGigsViewState extends State<EmployerGigsView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchMyGigsList(),
      viewModelBuilder: () => EmployerGigsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "my_gigs",
            textColor: independenceColor,
            backgroundColor: mainWhiteColor,
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: RefreshIndicator(
              color: independenceColor,
              onRefresh: viewModel.fetchMyGigsList,
              child: _buildMyGigsList(viewModel),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyGigsList(EmployerGigsViewModel viewModel) {
    return Container(
      margin: EdgeInsets.all(
        SizeConfig.margin_padding_10,
      ),
      child: ListView(
        children: [
          if (viewModel.myGigsList.isNotEmpty)
            Column(
              children: viewModel.myGigsList
                  .map(
                    (gigs) => MyGigsViewWidget(
                      title: gigs.gigName,
                      address: gigs.gigAddress,
                      price: viewModel.price(gigs),
                      startDate: gigs.gigsStartDate,
                      isEmptyModel: !viewModel.isEmptyModelCheck(gigs),
                      jobDuration: "${gigs.duration}" + " days".tr(),
                      bottomView: _buildStatusGigsView(viewModel, gigs),
                    ),
                  )
                  .toList(),
            ),
          if (viewModel.myGigsList.isEmpty) EmptyDataScreenView(),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          )
        ],
      ),
    );
  }

  Widget _buildStatusGigsView(
    EmployerGigsViewModel viewModel,
    MyGigsData gigs,
  ) {
    var isCheckAcceptCount =
        (viewModel.getAcceptedCount(gigs.gigsRequestData) > 0);
    var isCheckOfferSentCount =
        (viewModel.getOfferSentCount(gigs.gigsRequestData) > 0);
    var isCheckOfferReceivedCount =
        (viewModel.getOfferReceivedCount(gigs.gigsRequestData) > 0);
    var isCheckRoasterCount =
        (viewModel.getRoasterCount(gigs.gigsRequestData) > 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isCheckAcceptCount,
          child: _buildAcceptedCandidateView(
            viewModel: viewModel,
            gigs: gigs,
          ),
        ),
        if (!isCheckAcceptCount && isCheckOfferReceivedCount)
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
        Visibility(
          visible: isCheckOfferReceivedCount,
          child: _buildShortListCandidateView(
            gigs: gigs,
            viewModel: viewModel,
          ),
        ),
        if (isCheckOfferReceivedCount && !isCheckAcceptCount)
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: isCheckOfferSentCount,
              child: _buildOfferSendView(gigs: gigs, viewModel: viewModel),
            ),
            Visibility(
              visible: isCheckRoasterCount,
              child: _buildShortListedView(
                gigs: gigs,
                viewModel: viewModel,
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOfferSendView({
    required MyGigsData gigs,
    required EmployerGigsViewModel viewModel,
  }) {
    var count = viewModel.getOfferSentCount(gigs.gigsRequestData);
    return Text(
      "$count Offers Sent",
      style: TSB.regularSmall(
        textColor: mainPinkColor,
      ),
    );
  }

  Widget _buildShortListedView({
    required MyGigsData gigs,
    required EmployerGigsViewModel viewModel,
  }) {
    var count = viewModel.getRoasterCount(gigs.gigsRequestData);
    return InkWell(
      onTap: () =>
          viewModel.navigationToCandidateDetail(viewModel, gigs, "shortListed"),
      child: Text(
        "$count ShortListed",
        style: TSB.regularSmall(
          textColor: mainPinkColor,
        ),
      ),
    );
  }

  Widget _buildAcceptedCandidateView({
    required EmployerGigsViewModel viewModel,
    required MyGigsData gigs,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.margin_padding_10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStackedImages(
                data: gigs,
                viewModel: viewModel,
              ),
              SizedBox(
                height: SizeConfig.margin_padding_5,
              ),
              Text(
                viewModel.setResponseCount,
                style: TSB.regularSmall(textColor: independenceColor),
              )
            ],
          ),
          _buildDetailView(
            onTap: () => viewModel.navigationToCandidateDetail(
                viewModel, gigs, "accepted"),
          )
        ],
      ),
    );
  }

  Widget _buildShortListCandidateView({
    required MyGigsData gigs,
    required EmployerGigsViewModel viewModel,
  }) {
    var count = viewModel.getOfferReceivedCount(gigs.gigsRequestData);
    return Row(
      children: [
        Text(
          "$count " + "candidate_shortlisted".tr(),
          style: TSB.regularSmall(
            textColor: independenceColor,
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_3,
        ),
        InkWell(
          onTap: () => viewModel.navigationToCandidateDetail(
              viewModel, gigs, "shortList"),
          child: Text(
            "see_details".tr(),
            style: TSB.regularSmall(
              textColor: mainPinkColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStackedImages({
    required MyGigsData data,
    TextDirection? direction,
    required EmployerGigsViewModel viewModel,
  }) {
    const double size = 40;
    const double xShift = 20;
    var urlImages = viewModel.setStackedImage(data);
    final items = urlImages.map((urlImage) => buildImage(urlImage)).toList();
    return StackedWidgets(
      items: items,
      size: size,
      xShift: xShift,
    );
  }

  Widget buildImage(String urlImage) {
    return ClipOval(
      child: Container(
        color: Colors.white,
        child: ClipOval(
          child: Image.network(
            urlImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailView({required Function() onTap}) {
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
          "view".tr(),
          style: TSB.regularVSmall(textColor: mainPinkColor),
        ),
      ),
    );
  }
}
