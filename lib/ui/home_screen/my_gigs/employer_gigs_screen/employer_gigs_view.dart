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
            child: _buildMyGigsList(viewModel),
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
                      price: viewModel.price(
                        from: gigs.fromAmount,
                        to: gigs.toAmount,
                        priceCriteria: gigs.priceCriteria,
                      ),
                      startDate: gigs.gigsStartDate,
                      jobDuration: "${gigs.duration} ${gigs.priceCriteria}",
                      bottomView: _buildAcceptedGigsView(viewModel, gigs),
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

  Widget _buildAcceptedGigsView(
      EmployerGigsViewModel viewModel, MyGigsData gigs) {
    var status = "";
    if (gigs.gigsRequestData.isNotEmpty) {
      status = gigs.gigsRequestData.first.status;
    }
    if (status == "accepted") {
      return _buildAcceptedCandidateView(viewModel: viewModel, gigs: gigs);
    } else if (status == "received-offer" || status == "sent-offer") {
      return _buildShortListCandidateView(gigs: gigs, viewModel: viewModel);
    } else
      return SizedBox();
  }

  Widget _buildAcceptedCandidateView(
      {required EmployerGigsViewModel viewModel, required MyGigsData gigs}) {
    return Row(
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
        _buildDetailView()
      ],
    );
  }

  Widget _buildShortListCandidateView({
    required MyGigsData gigs,
    required EmployerGigsViewModel viewModel,
  }) {
    return Row(
      children: [
        Text(
          "05 " + "candidate_shortlisted".tr(),
          style: TSB.regularSmall(
            textColor: independenceColor,
          ),
        ),
        SizedBox(
          width: SizeConfig.margin_padding_3,
        ),
        InkWell(
          onTap: () => viewModel.navigationToShortListedDetailView(gigs),
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
    const double borderSize = 5;

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

  Widget _buildDetailView() {
    return Container(
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
    );
  }
}
