import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';
import '../../../data/network/dtos/find_gigrr_profile_response.dart';
import '../../../others/loading_button.dart';
import '../../widgets/detail_app_bar.dart';
import '../../widgets/giggr_request_view.dart';
import 'employer_gigrr_view_model.dart';

class CandidateOfferToCreateGigrrView
    extends StackedView<EmployerGigrrsViewModel> {
  final FindGigrrsProfileData data;

  CandidateOfferToCreateGigrrView({
    required this.data,
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
                giggrName: data.firstName,
                profileImage: data.imageUrl,
                priceController: viewModel.offerPriceController,
                selectPriceTypeController: viewModel.priceTypeController,
              ),
              LoadingButton(
                loading: viewModel.isBusy,
                action: () => viewModel.loadGigsCandidateOffer(
                  candidateId: data.employerProfile.userId,
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
  EmployerGigrrsViewModel viewModelBuilder(BuildContext context) =>
      EmployerGigrrsViewModel();
}
