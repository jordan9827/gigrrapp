import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

class GiggrCardWidget extends StatefulWidget {
  final Function navigateToDetailScreen;

  const GiggrCardWidget({
    Key? key,
    required this.navigateToDetailScreen,
  }) : super(key: key);

  @override
  State<GiggrCardWidget> createState() => _GiggrCardWidgetState();
}

class _GiggrCardWidgetState extends State<GiggrCardWidget> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  Widget _buildSpacing({double height = 0, double width = 0}) {
    return SizedBox(
      height: height > 0 ? height : SizeConfig.margin_padding_10 * 0.7,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      height: mediaQueryData.size.height,
      width: mediaQueryData.size.width,
      child: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            onPageChanged: (index) {
              print(index);
            },
            children: [
              Image.asset(
                "assets/images/home_slide_demo.png",
                fit: BoxFit.fill,
              ),
              Image.asset(
                "assets/images/home_slide_demo.png",
                fit: BoxFit.fill,
              ),
              Image.asset(
                "assets/images/home_slide_demo.png",
                fit: BoxFit.fill,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: mediaQueryData.size.height * 0.3,
              width: mediaQueryData.size.width,
              padding: EdgeInsets.only(
                left: SizeConfig.margin_padding_10,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    mainBlackColor,
                    mainBlackColor.withOpacity(0.8),
                    mainBlackColor.withOpacity(0.6),
                    mainBlackColor.withOpacity(0.4),
                    mainBlackColor.withOpacity(0.2),
                    mainBlackColor.withOpacity(0.0),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Suresh Kumar, 32",
                    style: TextStyle(
                      color: mainWhiteColor,
                      fontSize: SizeConfig.textSizeHeading,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _buildSpacing(),
                  Text(
                    "Civil Engineer, Superviser",
                    style: TextStyle(
                      color: mainWhiteColor,
                    ),
                  ),
                  _buildSpacing(),
                  Text(
                    "₹ 300-400/day",
                    style: TextStyle(
                      color: mainPinkColor,
                      fontSize: SizeConfig.textSizeMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  _buildSpacing(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "4 KM Away",
                        style: TextStyle(
                          color: mainWhiteColor,
                        ),
                      ),
                      _buildSpacing(
                        width: SizeConfig.margin_padding_5,
                      ),
                      ClipOval(
                        child: Container(
                          height: SizeConfig.margin_padding_5,
                          width: SizeConfig.margin_padding_5,
                          color: mainWhiteColor,
                        ),
                      ),
                      _buildSpacing(
                        width: SizeConfig.margin_padding_5,
                      ),
                      Text(
                        "8 Years Experience",
                        style: TextStyle(
                          color: mainWhiteColor,
                        ),
                      ),
                    ],
                  ),
                  _buildSpacing(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(SizeConfig.margin_padding_5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: mainWhiteColor,
                            width: SizeConfig.margin_padding_2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              SizeConfig.margin_padding_8,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "SHORTLIST GIGRR",
                            style: TextStyle(
                              color: mainWhiteColor,
                              fontSize: SizeConfig.textSizeSmall,
                            ),
                          ),
                        ),
                      ),
                      _buildSpacing(
                        width: SizeConfig.margin_padding_5,
                      ),
                      InkWell(
                        onTap: () => widget.navigateToDetailScreen(),
                        child: Container(
                          height: SizeConfig.margin_padding_29,
                          width: SizeConfig.margin_padding_29,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: mainWhiteColor,
                              width: SizeConfig.margin_padding_2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                SizeConfig.margin_padding_8,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "i",
                              style: TextStyle(
                                color: mainWhiteColor,
                                fontSize: SizeConfig.textSizeSmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildSpacing(
                    height: SizeConfig.margin_padding_40,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: SizeConfig.margin_padding_14,
          //   left: (mediaQueryData.size.width * 0.5) -
          //       (SizeConfig.margin_padding_65 * 0.5),
          //   child: Center(
          //     child: Container(
          //       height: SizeConfig.margin_padding_10,
          //       width: SizeConfig.margin_padding_65,
          //       decoration: BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular())),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
