import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/ui/home_screen/gigrr_detail_view/gigrr_detail_view_model.dart';
import 'package:square_demo_architecture/util/extensions/build_context_extension.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';
import 'package:stacked/stacked.dart';

class GigrrDetailView extends StatelessWidget {
  const GigrrDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    MediaQueryData mediaQueryData = context.mediaQueryData;
    double outerPadding = SizeConfig.margin_padding_24;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => GigrrDetailViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          body: Stack(
            children: [
              SizedBox(
                height: mediaQueryData.size.height,
                width: mediaQueryData.size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: mediaQueryData.size.height * 0.5,
                        width: mediaQueryData.size.width,
                        child: Stack(
                          children: [
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image.asset(
                                "assets/images/home_slide_demo.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: kToolbarHeight,
                              child: Container(
                                height: kToolbarHeight,
                                width: mediaQueryData.size.width,
                                padding: EdgeInsets.only(
                                  right: outerPadding,
                                  left: outerPadding,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildAppBarButtons(
                                      icon: Icons.arrow_back_outlined,
                                      onTap: viewModel.navigateBack,
                                    ),
                                    _buildAppBarButtons(
                                      icon: Icons.menu,
                                      onTap: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaQueryData.size.width,
                        padding: EdgeInsets.all(outerPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nikhil Rathore",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: SizeConfig.textSizeXLarge,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  size: SizeConfig.margin_padding_20,
                                ),
                                Text(
                                  "My address to my location with pin code",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: SizeConfig.textSizeSmall,
                                  ),
                                ),
                              ],
                            ),
                            _buildSpacing(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildExPriceWidget(
                                  outerPadding: outerPadding,
                                  valueText: "1000-2000/day",
                                  titleText: "Normal Price",
                                ),
                                _buildExPriceWidget(
                                  outerPadding: outerPadding,
                                  valueText: "2000-3000/day",
                                  titleText: "Normal Price",
                                ),
                              ],
                            ),
                            _buildSpacing(),
                            _buildOtherDetailView(
                              title: "Availibility",
                              infoList: [
                                "Weekends",
                                "Day Shift",
                                "Night Shift",
                              ],
                            ),
                            _buildSpacing(),
                            _buildOtherDetailView(
                              title: "He can be",
                              infoList: [
                                "Civil Engineer",
                                "Superviser",
                                "Computer Operator",
                                "Workforce Management",
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: kToolbarHeight * 2,
                      width: SizeConfig.screenWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            mainWhiteColor,
                            mainWhiteColor.withOpacity(0.75),
                            mainWhiteColor.withOpacity(0.50),
                            mainWhiteColor.withOpacity(0.25),
                            mainWhiteColor.withOpacity(0.0),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      color: mainWhiteColor,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.margin_padding_14,
                      ),
                      child: Container(
                        width: SizeConfig.screenWidth * 0.5,
                        height: kToolbarHeight * 0.85,
                        decoration: BoxDecoration(
                          color: mainPinkColor,
                          borderRadius: BorderRadius.circular(
                            SizeConfig.margin_padding_15,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "SHORTLIST GIGRR",
                            style: TextStyle(
                              color: mainWhiteColor,
                              fontSize: SizeConfig.textSizeMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpacing({
    double? height,
  }) {
    return SizedBox(
      height: height ?? SizeConfig.margin_padding_14,
    );
  }

  Widget _buildExPriceWidget({
    required double outerPadding,
    required String valueText,
    required String titleText,
  }) {
    double width = (SizeConfig.screenWidth - (outerPadding * 2.5)) * 0.5;
    double padding = SizeConfig.margin_padding_20 * 0.5;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(
          SizeConfig.margin_padding_14,
        ),
      ),
      padding: EdgeInsets.all(
        padding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            valueText,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w800,
              fontSize: SizeConfig.textSizeMedium,
            ),
          ),
          _buildSpacing(
            height: padding * 0.5,
          ),
          Text(
            titleText,
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.textSizeMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherDetailView({
    required String title,
    required List<String> infoList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
        ),
        _buildSpacing(),
        Wrap(
          spacing: SizeConfig.margin_padding_5,
          runSpacing: SizeConfig.margin_padding_5,
          children:
              infoList.map((e) => _buildOtherDetailViewInfo(text: e)).toList(),
        ),
      ],
    );
  }

  Widget _buildOtherDetailViewInfo({
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        right: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.margin_padding_17,
          ),
        ),
        padding: EdgeInsets.all(
          SizeConfig.margin_padding_8,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }

  Widget _buildAppBarButtons({
    required IconData icon,
    required Function onTap,
  }) {
    double size = SizeConfig.margin_padding_40;
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        height: size,
        width: size,
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}
