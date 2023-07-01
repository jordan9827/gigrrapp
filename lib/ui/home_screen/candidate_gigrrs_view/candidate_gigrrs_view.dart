import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/empty_data_screen.dart';
import 'package:square_demo_architecture/ui/widgets/gigrr_card_widget.dart';
import 'package:stacked/stacked.dart';

import '../home_app_bar.dart';
import 'candidate_gigrrs_view_model.dart';

class CandidateGigrrsView extends StatelessWidget {
  const CandidateGigrrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: viewModel.pageController,
              children: viewModel.gigsData.map(
                (e) {
                  if (viewModel.gigsData.isEmpty) {
                    return EmptyDataScreenView();
                  } else {
                    String profile = "";
                    for (var i in e.business.businessesImage) {
                      profile = i.imageUrl;
                    }
                    return GiggrCardWidget(
                      title: e.gigName,
                      profile: profile,
                      price: viewModel.price(e),
                      gigrrName: 'apply_now',
                      isCandidate: true,
                      skillList:
                          e.skillsCategoryList.map((e) => e.name).toList(),
                      navigateToDetailScreen: () =>
                          viewModel.navigateToGigrrDetailScreen(e),
                      acceptedGigsRequest: () =>
                          viewModel.acceptedGigsRequest(e.id),
                    );
                  }
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
