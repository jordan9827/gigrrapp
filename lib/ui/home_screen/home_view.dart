import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view.dart';
import 'package:square_demo_architecture/ui/gigrrs_view/gigrrs_view.dart';
import 'package:square_demo_architecture/ui/my_gigrrs/my_gigrrs_view.dart';
import 'package:square_demo_architecture/ui/my_gigs/my_gigs_view.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<Widget> screens = [
    GigrrsView(),
    MyGigss(),
    MyGirrsView(),
    AccountView(),
  ];

  Widget _buildAddBottomBarTab({
    required Function onTap,
  }) {
    return Container(
      height: kToolbarHeight * 1.5,
      width: kToolbarHeight * 1.5,
      child: Column(
        children: [
          Container(
            height: SizeConfig.margin_padding_50 * 1.01,
            width: SizeConfig.margin_padding_50,
            decoration: BoxDecoration(
              color: mainPinkColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  SizeConfig.margin_padding_20,
                ),
              ),
            ),
            child: Center(
              child: SizedBox(
                height: SizeConfig.margin_padding_20,
                width: SizeConfig.margin_padding_20,
                child: Image.asset(
                  ic_plus,
                ),
              ),
            ),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_5,
          ),
          Text(
            "Create Gig",
            style: TextStyle(
              color: mainPinkColor,
              fontSize: SizeConfig.textSizeVerySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarTab({
    required Function onTap,
    required String title,
    required String image,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        height: kToolbarHeight,
        width: kToolbarHeight,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.margin_padding_20,
                  width: SizeConfig.margin_padding_20,
                  child: Image.asset(
                    image,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.margin_padding_3,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: mainWhiteColor,
                    fontSize: SizeConfig.textSizeVerySmall,
                  ),
                ),
              ],
            ),
            if (!isSelected)
              Container(
                height: kToolbarHeight,
                width: kToolbarHeight,
                color: Colors.black.withOpacity(0.5),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final ThemeData themeData = Theme.of(context);
    SizeConfig.init(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: mainWhiteColor,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                height: mediaQueryData.size.height - (kToolbarHeight),
                width: mediaQueryData.size.width,
                child: screens[viewModel.bottomNavBarService.currentIndex],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: kToolbarHeight,
                width: mediaQueryData.size.width,
                color: mainBlackColor,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: kToolbarHeight * 1.5,
                width: mediaQueryData.size.width,
                alignment: Alignment.bottomCenter,
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBottomBarTab(
                      onTap: () => viewModel.changeScreenIndex(0),
                      image: ic_home,
                      title: "Gigrrs",
                      isSelected:
                          0 == viewModel.bottomNavBarService.currentIndex,
                    ),
                    _buildBottomBarTab(
                      onTap: () => viewModel.changeScreenIndex(1),
                      image: ic_my_gigs,
                      title: "My Gigs",
                      isSelected:
                          1 == viewModel.bottomNavBarService.currentIndex,
                    ),
                    _buildAddBottomBarTab(onTap: () {}),
                    _buildBottomBarTab(
                      onTap: () => viewModel.changeScreenIndex(2),
                      image: ic_my_gigrr,
                      title: "My Gigrrs",
                      isSelected:
                          2 == viewModel.bottomNavBarService.currentIndex,
                    ),
                    _buildBottomBarTab(
                      onTap: () => viewModel.changeScreenIndex(3),
                      image: ic_account,
                      title: "Account",
                      isSelected:
                          3 == viewModel.bottomNavBarService.currentIndex,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
