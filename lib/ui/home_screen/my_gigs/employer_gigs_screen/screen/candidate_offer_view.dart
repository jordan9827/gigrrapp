import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/widgets/giggr_request_view.dart';
import 'package:stacked/stacked.dart';
import '../../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../../others/loading_button.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../employer_gigs_view_model.dart';

class CandidateOfferView extends StackedView<EmployerGigsViewModel> {
  final MyGigsData gigs;

  CandidateOfferView({
    required this.gigs,
  });

  @override
  Widget builder(
      BuildContext context, EmployerGigsViewModel viewModel, Widget? child) {
    var candidate = gigs.gigsRequestData.first.candidate;
    return Scaffold(
      body: ListView(
        padding: edgeInsetsMargin,
        children: [
          _buildSpacer(),
          GigrrCustomRequestView(
            giggrName: gigs.gigName,
            profileImage: candidate.imageURL,
            priceController: viewModel.offerPriceController,
            selectPriceTypeController: viewModel.priceTypeController,
          ),
          LoadingButton(
            loading: viewModel.isBusy,
            action: () => viewModel.loadGigsCandidateOffer(
              gigsId: gigs.id,
              candidateId: candidate.id,
            ),
            title: "offer_daily_price",
          ),
          _buildSpacer(),
          Align(
            alignment: Alignment.center,
            child: Text(
              "continue_with_make_offer".tr(),
              style: TSB.regularSmall(
                textColor: mainPinkColor,
              ),
            ),
          ),
          _buildSpacer(),
        ],
      ),
    );
  }

  Widget _buildSpacer() {
    return SizedBox(
      height: SizeConfig.margin_padding_20,
    );
  }

  @override
  EmployerGigsViewModel viewModelBuilder(BuildContext context) =>
      EmployerGigsViewModel();
}
