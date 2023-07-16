import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:square_demo_architecture/ui/widgets/gigrr_card_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../home_app_bar.dart';
import 'candidate_gigrrs_view_model.dart';

class CandidateGigrrsView extends StatelessWidget {
  const CandidateGigrrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchGigsRequest(),
      viewModelBuilder: () => CandidateGigrrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: HomeGigrrsAppBarView(),
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: viewModel.gigsData.isNotEmpty
                ? PageView(
                    scrollDirection: Axis.vertical,
                    controller: viewModel.pageController,
                    children: viewModel.gigsData.map((e) {
                      return GiggrCardWidget(
                        title: e.gigName,
                        profile: viewModel.profileImage(e.business),
                        price: viewModel.price(e),
                        gigrrActionName: 'apply_now',
                        isCandidate: true,
                        skillList:
                            e.skillsCategoryList.map((e) => e.name).toList(),
                        gigrrActionButton: () =>
                            viewModel.navigateToGigrrDetailScreen(e),
                        acceptedGigsRequest: () =>
                            viewModel.acceptedGigsRequest(
                          e.id,
                          viewModel.gigsData.indexOf(e),
                        ),
                      );
                    }).toList(),
                  )
                : EmptyDataScreenView(),
          ),
        );
      },
    );
  }
}
