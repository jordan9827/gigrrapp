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
            child: viewModel.gigsData.isEmpty
                ? _buildEmptyView(viewModel)
                : PageView.builder(
                    scrollDirection: Axis.vertical,
                    controller: viewModel.pageController,
                    itemBuilder: (BuildContext context, int index) {
                      var e = viewModel.gigsData[index];
                      return GiggrCardWidget(
                        title: e.firstName,
                        price: viewModel.price(e),
                        gigrrActionName: 'apply_now',
                        skillList: e.employeeSkills.map((e) => e.name).toList(),
                        gigrrActionButton: () =>
                            viewModel.navigateToGigrrDetailScreen(e),
                        profileList:
                            e.employerImageList.map((e) => e.imageUrl).toList(),
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyView(EmployerGigrrsViewModel viewModel) {
    bool isBusiness = viewModel.employerGigrrsPref.businessId.isNotEmpty;
    bool isEmptyData = isBusiness && viewModel.gigsData.isEmpty;
    return EmptyDataScreenView(
      title: isEmptyData ? "txt_no_data" : "txt_no_data_for_gigrrs",
      enableBackButton: !isEmptyData,
      actionText: "find_gigrrs",
      action: viewModel.navigateToEmployerPrefView,
    );
  }
}
