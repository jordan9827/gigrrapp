import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/constants.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

import '../../data/network/dtos/candidate_gigs_request.dart';
import '../../util/others/text_styles.dart';

class GiggrCardWidget extends StatefulWidget {
  final String title;
  final String profile;
  final List<String> skillList;
  final String price;
  final int distance;
  final String experience;
  final String gigrrActionName;
  final bool isCandidate;
  final Function() gigrrActionButton;
  final Function()? navigateToGigrr;
  final Function()? acceptedGigsRequest;

  const GiggrCardWidget({
    Key? key,
    required this.gigrrActionButton,
    required this.title,
    required this.profile,
    required this.skillList,
    required this.price,
    this.distance = 0,
    this.experience = "",
    this.isCandidate = false,
    required this.gigrrActionName,
    this.navigateToGigrr,
    this.acceptedGigsRequest,
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
    SizeConfig.init(context);
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
              Image.network(
                widget.profile,
                fit: BoxFit.fill,
              )
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: mediaQueryData.size.height * 0.4,
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
                    widget.title,
                    style: TextStyle(
                      color: mainWhiteColor,
                      fontSize: SizeConfig.textSizeHeading,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _buildSpacing(height: 2),
                  Wrap(
                    children: widget.skillList
                        .map(
                          (e) => Text(
                            "$e, ",
                            style: TextStyle(
                              color: mainWhiteColor,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  _buildSpacing(),
                  Text(
                    widget.price,
                    style: TSB.semiBoldMedium(textColor: mainPinkColor),
                  ),
                  _buildSpacing(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.distance} " + "km_away".tr(),
                        style: TextStyle(
                          color: mainWhiteColor,
                        ),
                      ),
                      _buildSpacing(
                        width: SizeConfig.margin_padding_5,
                      ),
                      if (!widget.isCandidate) _buildExperience()
                    ],
                  ),
                  _buildSpacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: widget.acceptedGigsRequest,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.margin_padding_5,
                                horizontal: SizeConfig.margin_padding_15,
                              ),
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
                                  widget.gigrrActionName.tr(),
                                  style: TextStyle(
                                    color: mainWhiteColor,
                                    fontSize: SizeConfig.textSizeSmall,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          _buildSpacing(
                            width: SizeConfig.margin_padding_5,
                          ),
                          InkWell(
                            onTap: widget.gigrrActionButton,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.margin_padding_5,
                                horizontal: SizeConfig.margin_padding_10,
                              ),
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
                      if (widget.isCandidate)
                        InkWell(
                          onTap: widget.acceptedGigsRequest,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding:
                                EdgeInsets.all(SizeConfig.margin_padding_5),
                            height: SizeConfig.margin_padding_35,
                            width: SizeConfig.margin_padding_35,
                            decoration: BoxDecoration(
                              color: mainWhiteColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  SizeConfig.margin_padding_8,
                                ),
                              ),
                            ),
                            child: Icon(
                              Icons.send,
                              color: mainPinkColor,
                            ),
                          ),
                        )
                    ],
                  ),
                  _buildSpacing(
                    height: SizeConfig.margin_padding_40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperience() {
    return Row(
      children: [
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
        if (widget.experience.isNotEmpty)
          Text(
            "${widget.experience} " "experience".tr(),
            style: TextStyle(
              color: mainWhiteColor,
            ),
          ),
      ],
    );
  }
}
