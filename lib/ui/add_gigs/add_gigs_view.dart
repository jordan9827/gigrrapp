import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../widgets/toggle_app_bar_widget.dart';
import 'add_gigs_view_model.dart';
import 'widget/add_gigs_info_view.dart';
import 'widget/add_operational_info_view.dart';

class AddGigsScreenView extends StatefulWidget {
  const AddGigsScreenView({Key? key}) : super(key: key);

  @override
  State<AddGigsScreenView> createState() => _AddGigsScreenViewState();
}

class _AddGigsScreenViewState extends State<AddGigsScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => AddGigsViewModel(),
      onViewModelReady: (v) {},
      builder: (_, viewModel, child) => WillPopScope(
        onWillPop: () => Future.sync(viewModel.onWillPop),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(viewModel),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: viewModel.setPageIndex,
                  controller: viewModel.controller,
                  children: [
                    AddGigsInfoScreenView(viewModel: viewModel),
                    AddGigsOperationalInfoScreenView(viewModel: viewModel)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AddGigsViewModel viewModel) {
    var isCheckIndex = viewModel.pageIndex == 0 ? true : false;
    return ToggleAppBarWidgetView(
      appBarTitle: "add_gig",
      firstTitle: "gig_info",
      secondTitle: "operational_info",
      isCheck: isCheckIndex,
      backAction: viewModel.navigatorToBack,
      showBack: true,
    );
  }
}
