import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../../../others/common_app_bar.dart';
import '../../../../../../others/constants.dart';
import '../../../../../widgets/gigrr_card_widget.dart';
import '../gigrrs_candidate_detail_widget.dart';
import 'employer_gigs_detail_view_model.dart';

class EmployerGigsDetailView extends StatelessWidget {
  final MyGigsData gigs;
  final String status;

  const EmployerGigsDetailView({
    Key? key,
    required this.gigs,
    this.status = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerGigsDetailViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "my_gigs_detail",
          showBack: true,
          onBackPressed: () => viewModel.navigationService.back(),
          textColor: independenceColor,
          showBackColor: mainBlackColor,
          backgroundColor: mainWhiteColor,
        ),
        body: Column(
          children: [
            if (status == "accepted") _buildGigsAcceptedView(viewModel),
            if (status != "accepted") _buildGigsOfferAndShortListDetailView()
          ],
        ),
      ),
    );
  }

  Widget _buildGigsAcceptedView(EmployerGigsDetailViewModel viewModel) {
    return Expanded(
      child: PageView(
        scrollDirection: Axis.vertical,
        children: gigs.gigsRequestData
            .where((element) => element.status == "accepted")
            .map((e) {
          return GiggrCardWidget(
            title: e.employeeName,
            profile: e.candidate.imageURL,
            price: viewModel.price(gigs),
            gigrrActionName: 'offer_send',
            distance: e.distance,
            experience: e.availabilityResp.experience,
            skillList: gigs.skillsTypeCategoryList.map((e) => e.name).toList(),
            acceptedGigsRequest: () =>
                viewModel.navigationToCandidateOfferRequest(gigs, e),
            gigrrActionButton: () =>
                viewModel.navigationToShortListedDetailView(
              gigs: gigs,
              data: e,
              isShortListed: false,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGigsOfferAndShortListDetailView() {
    return ListView(
      shrinkWrap: true,
      children: gigs.gigsRequestData
          .map(
            (e) => GigrrsCandidateWidget(
              gigsData: gigs,
              data: e,
            ),
          )
          .toList(),
    );
  }
}
