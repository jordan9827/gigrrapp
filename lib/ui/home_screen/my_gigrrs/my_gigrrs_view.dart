import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/my_gigrrs_view_model.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/widget/my_giggrrs_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import '../../../others/common_app_bar.dart';
import '../../../others/loading_screen.dart';
import '../../widgets/notification_icon.dart';

class MyGirrsView extends StatelessWidget {
  const MyGirrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MyGirrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: mainGrayColor,
          appBar: getAppBar(
            context,
            "my_gigs",
            backgroundColor: mainWhiteColor,
            textColor: mainBlackColor,
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: RefreshIndicator(
              onRefresh: viewModel.refreshScreen,
              child: _buildMyGigrrs(viewModel),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyGigrrs(MyGirrsViewModel viewModel) {
    return ListView(
      padding: EdgeInsets.all(SizeConfig.margin_padding_15),
      children: List.generate(
        3,
        (index) => MyGiggrrsWidget(),
      ),
    );
  }
}
