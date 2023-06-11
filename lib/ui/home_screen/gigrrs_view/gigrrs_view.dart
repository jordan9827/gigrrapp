import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/others/loading_screen.dart';
import 'package:square_demo_architecture/ui/home_screen/gigrrs_view/gigrrs_view_model.dart';
import 'package:square_demo_architecture/ui/widgets/gigrr_card_widget.dart';
import 'package:square_demo_architecture/ui/widgets/notification_icon.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

class GigrrsView extends StatelessWidget {
  const GigrrsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => GigrrsViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: mainWhiteColor,
            leadingWidth: 0,
            title: Row(
              children: [
                SizedBox(
                  height: SizeConfig.margin_padding_20,
                  width: SizeConfig.margin_padding_20,
                  child: Image.asset(
                    ic_location_filled,
                  ),
                ),
                SizedBox(
                  width: SizeConfig.margin_padding_10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Shop",
                          style: TextStyle(
                            color: mainBlackColor,
                            fontWeight: FontWeight.w900,
                            fontSize: SizeConfig.textSizeSmall,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: mainBlackColor,
                        )
                      ],
                    ),
                    Text(
                      viewModel.user.address,
                      style: TextStyle(
                        color: mainBlackColor,
                        fontSize: SizeConfig.textSizeVerySmall * 0.95,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              NotificationIcon(),
            ],
          ),
          body: LoadingScreen(
            loading: viewModel.isBusy,
            child: PageView(
              scrollDirection: Axis.vertical,
              controller: viewModel.pageController,
              children: viewModel.gigsData
                  .map(
                    (e) => GiggrCardWidget(
                      data: e,
                      navigateToDetailScreen: () =>
                          viewModel.navigateToGigrrDetailScreen(e),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
