import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/widgets/giggr_request_view.dart';
import 'package:stacked/stacked.dart';
import '../../../../../data/network/dtos/my_gigs_response.dart';
import '../../../../../others/loading_button.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../../widgets/detail_app_bar.dart';
import '../employer_gigs_view_model.dart';
import 'employer_gigs_detail_screen/employer_gigs_detail_view_model.dart';

class CandidateOfferView extends StackedView<EmployerGigsDetailViewModel> {
  final MyGigsData gigs;
  final GigsRequestData requestData;
  CandidateOfferView({
    required this.requestData,
    required this.gigs,
  });

  @override
  Widget builder(context, viewModel, child) {
    SizeConfig.init(context);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: edgeInsetsMargin,
            children: [
              _buildSpacer(),
              GigrrCustomRequestView(
                giggrName: gigs.gigName,
                profileImage: requestData.candidate.imageURL,
                priceController: viewModel.offerPriceController,
                selectPriceTypeController: viewModel.priceTypeController,
              ),
              LoadingButton(
                loading: viewModel.isBusy,
                action: () => viewModel.loadGigsCandidateOffer(
                  gigsId: gigs.id,
                  candidateId: requestData.candidate.id,
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
          Positioned(
            top: SizeConfig.margin_padding_24,
            child: DetailAppBar(),
          ),
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
  EmployerGigsDetailViewModel viewModelBuilder(BuildContext context) =>
      EmployerGigsDetailViewModel();
}
