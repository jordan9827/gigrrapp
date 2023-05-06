import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/my_gigs/my_gigs_view_model.dart';
import 'package:square_demo_architecture/ui/my_gigs/widget/my_gigs_view_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../others/loading_screen.dart';
import '../../util/others/text_styles.dart';
import '../widgets/notification_icon.dart';

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

  Widget _buildLoading() {
    return Center(
      heightFactor: 10,
      child: SpinKitCircle(
        size: SizeConfig.margin_padding_40,
        color: independenceColor,
      ),
    );
  }
}
