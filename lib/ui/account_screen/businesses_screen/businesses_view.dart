import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import '../../../util/others/size_config.dart';
import 'businesses_view_model.dart';
import 'widget/businesses_view_widget.dart';

class BusinessesScreenView extends StatefulWidget {
  const BusinessesScreenView({Key? key}) : super(key: key);

  @override
  State<BusinessesScreenView> createState() => _BusinessesScreenViewState();
}

class _BusinessesScreenViewState extends State<BusinessesScreenView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchAllBusinessesApi(),
      viewModelBuilder: () => BusinessesViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "businesses",
          showBack: true,
          onBackPressed: viewModel.navigatorToBack,
        ),
        body: RefreshIndicator(
          key: businessRefreshKey,
          onRefresh: viewModel.refreshScreen,
          child: LoadingScreen(
            loading: viewModel.isBusy,
            child: _buildMyGigsList(viewModel),
          ),
        ),
      ),
    );
  }

  Widget _buildMyGigsList(BusinessesViewModel viewModel) {
    return Container(
      child: ListView(
        children: [
          Column(
            children: viewModel.businessesList
                .map(
                  (e) => BusinessesViewWidget(
                    businesses: e,
                    viewModel: viewModel,
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          )
        ],
      ),
    );
  }
}
