import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:stacked/stacked.dart';
import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import '../../../util/others/size_config.dart';
import '../../widgets/empty_data_screen.dart';
import 'businesses_view_model.dart';
import 'widget/businesses_view_widget.dart';

class BusinessesScreenView extends StatelessWidget {
  const BusinessesScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      // onViewModelReady: (viewModel) => viewModel.fetchAllBusinessesApi(),
      viewModelBuilder: () => BusinessesViewModel(),
      builder: (_, viewModel, child) => Scaffold(
        backgroundColor: mainGrayColor,
        appBar: getAppBar(
          context,
          "businesses",
          showBack: true,
          onBackPressed: viewModel.navigatorToBack,
          actions: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                right: SizeConfig.margin_padding_10,
              ),
              child: InkWell(
                onTap: viewModel.navigationToAddBusinessView,
                child: Icon(
                  Icons.add,
                  size: SizeConfig.margin_padding_24,
                  color: mainWhiteColor,
                ),
              ),
            )
          ],
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
          if (viewModel.businessesList.isEmpty) EmptyDataScreenView(),
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
