import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/widget/my_gigs_view_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:square_demo_architecture/util/others/text_styles.dart';
import 'package:stacked/stacked.dart';

import '../../../others/loading_screen.dart';
import '../../widgets/notification_icon.dart';
import 'my_gigs_view_model.dart';

class MyGigss extends StatelessWidget {
  const MyGigss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      onViewModelReady: (viewModel) => viewModel.fetchMyGigsList(),
      viewModelBuilder: () => MyGigsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: mainGrayColor,
          appBar: AppBar(
            backgroundColor: mainWhiteColor,
            elevation: 0,
            title: Text(
              "my_gigs".tr(),
              style: TSB.semiBoldMedium(textColor: independenceColor),
            ),
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: _buildMyGigsList(viewModel),
          ),
        );
      },
    );
  }

  Widget _buildMyGigsList(MyGigsViewModel viewModel) {
    return Container(
      child: ListView(
        children: [
          Column(
            children: viewModel.myGigsList
                .map(
                  (gigs) => MyGigsViewWidget(
                    myGigs: gigs,
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
