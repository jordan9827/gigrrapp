import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/gigrr_card_widget.dart';
import 'package:stacked/stacked.dart';
import '../../widgets/empty_data_screen.dart';
import '../home_app_bar.dart';
import 'employer_gigrr_view_model.dart';

class EmployerGigrrsView extends StatelessWidget {
  const EmployerGigrrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmployerGigrrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: HomeGigrrsAppBarView(
              address: viewModel.user.address,
              addressType: "Shop",
              actionToAddress: viewModel.navigateToBusiness,
            ),
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: (viewModel.gigsData.isEmpty && !viewModel.isBusy)
                ? _buildEmptyView(viewModel)
                : PageView(
                    scrollDirection: Axis.vertical,
                    controller: viewModel.pageController,
                    children: viewModel.gigsData
                        .map(
                          (e) => GiggrCardWidget(
                            title: e.firstName,
                            distance: e.distance.toInt(),
                            price: viewModel.price(e),
                            experience: e.employerProfile.experience,
                            gigrrActionName: 'offer_send',
                            skillList:
                                e.employeeSkills.map((e) => e.name).toList(),
                            gigrrActionButton: () => viewModel
                                .navigationToSendOfferDetailView(gigs: e),
                            acceptedGigsRequest: () =>
                                viewModel.navigationToCandidateOfferRequest(e),
                            profileList: e.employerImageList
                                .map((e) => e.imageUrl)
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyView(EmployerGigrrsViewModel viewModel) {
    bool isBusiness = viewModel.gigrrsPref.businessId.isNotEmpty;
    bool isEmptyData = isBusiness && viewModel.gigsData.isEmpty;
    return EmptyDataScreenView(
      title: isEmptyData ? "txt_no_data" : "txt_no_data_for_gigrrs",
      enableBackButton: !isEmptyData,
      actionText: "find_gigrrs",
      action: viewModel.navigateToEmployerPrefView,
    );
  }
}
