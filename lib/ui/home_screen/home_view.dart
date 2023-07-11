import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/account_screen/account_view.dart';
import 'package:square_demo_architecture/ui/home_screen/employer_gigrr_view/employer_gigrr_view.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigrrs/my_gigrrs_view.dart';
import 'package:square_demo_architecture/ui/home_screen/my_gigs/my_gigs_view.dart';
import 'package:square_demo_architecture/util/others/image_constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';
import '../../util/others/text_styles.dart';
import 'candidate_gigrrs_view/candidate_gigrrs_view.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  final int initialIndex;
  const HomeView({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> employerScreens = [
    EmployerGigrrsView(),
    MyGigs(),
    MyGirrsView(),
    AccountView(),
  ];
  List<Widget> candidateScreens = [
    MyGigs(),
    CandidateGigrrsView(),
    AccountView(),
  ];

  Widget _buildAddBottomBarTab({
    required Function() onTap,
    required String icon,
    required String title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                    icon,
                    color: mainWhiteColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.margin_padding_5,
            ),
            Text(
              title.tr(),
              style: TextStyle(
                color: mainPinkColor,
                fontSize: SizeConfig.textSizeVerySmall,
              ),
            ),
          ],
        ),
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
                  title.tr(),
                  style: TSB.regular(
                    textSize: SizeConfig.safeBlockHorizontal * 2.8,
                    textColor: mainWhiteColor,
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
      onViewModelReady: (viewModel) => viewModel.setInitialIndex(),
      viewModelBuilder: () => HomeViewModel(widget.initialIndex),
      builder: (context, viewModel, child) {
        var isEmployer = viewModel.user.isEmployer;
        return Scaffold(
          backgroundColor: mainWhiteColor,
          body: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  height: mediaQueryData.size.height - (kToolbarHeight),
                  width: mediaQueryData.size.width,
                  child: isEmployer
                      ? employerScreens[
                          viewModel.bottomNavBarService.currentIndex]
                      : candidateScreens[
                          viewModel.bottomNavBarService.currentIndex],
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
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  height: kToolbarHeight * 1.5,
                  width: mediaQueryData.size.width,
                  alignment: Alignment.bottomCenter,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (isEmployer) ..._buildEmployerList(viewModel),
                      if (!isEmployer) ..._buildCandidateList(viewModel),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildEmployerList(HomeViewModel viewModel) {
    return [
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(0),
        image: ic_home,
        title: "gigrrs",
        isSelected: 0 == viewModel.bottomNavBarService.currentIndex,
      ),
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(1),
        image: ic_my_gigs,
        title: "my_gigs",
        isSelected: 1 == viewModel.bottomNavBarService.currentIndex,
      ),
      _buildAddBottomBarTab(
        title: "create_gig",
        icon: ic_plus,
        onTap: viewModel.navigatorToAddGigsView,
      ),
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(2),
        image: ic_my_gigrr,
        title: "my_gigrrs",
        isSelected: 2 == viewModel.bottomNavBarService.currentIndex,
      ),
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(3),
        image: ic_account,
        title: "account",
        isSelected: 3 == viewModel.bottomNavBarService.currentIndex,
      ),
    ];
  }

  List<Widget> _buildCandidateList(HomeViewModel viewModel) {
    return [
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(0),
        image: ic_my_gigs,
        title: "my_gigs",
        isSelected: 0 == viewModel.bottomNavBarService.currentIndex,
      ),
      _buildAddBottomBarTab(
        title: "find_gig",
        icon: ic_search_blck,
        onTap: () => viewModel.changeScreenIndex(1),
      ),
      _buildBottomBarTab(
        onTap: () => viewModel.changeScreenIndex(2),
        image: ic_account,
        title: "account",
        isSelected: 1 == viewModel.bottomNavBarService.currentIndex,
      ),
    ];
  }
}
