import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/widgets/gigrr_card_widget.dart';
import 'package:stacked/stacked.dart';
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
            child: HomeGigrrsAppBarView(),
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: viewModel.pageController,
              children: viewModel.gigsData.map(
                (e) {
                  return GiggrCardWidget(
                    title: e.firstName,
                    profile: "",
                    price: viewModel.price(e),
                    gigrrName: 'apply_now',
                    skillList: e.employeeSkills.map((e) => e.name).toList(),
                    navigateToDetailScreen: () =>
                        viewModel.navigateToGigrrDetailScreen(e),
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
