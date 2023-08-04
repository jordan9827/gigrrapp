import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';

class ToggleAppBarWidgetView extends StatelessWidget {
  final String appBarTitle;
  final String firstTitle;
  final String secondTitle;
  final bool isCheck;
  final bool showBack;
  final Function()? backAction;
  ToggleAppBarWidgetView({
    Key? key,
    this.isCheck = false,
    this.showBack = false,
    required this.appBarTitle,
    required this.firstTitle,
    this.backAction,
    required this.secondTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      padding: edgeInsetsMargin,
      height: SizeConfig.margin_padding_85 * 1.2,
      width: MediaQuery.of(context).size.width,
      color: independenceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (showBack)
                InkWell(
                  onTap: backAction,
                  child: Image.asset(
                    arrow_back,
                    height: SizeConfig.margin_padding_10,
                  ),
                ),
              if (showBack)
                SizedBox(
                  width: SizeConfig.margin_padding_10,
                ),
              Text(
                appBarTitle.tr(),
                style: TSB.regularLarge(
                  textColor: mainWhiteColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLog(
                title: firstTitle,
                isCheck: isCheck,
              ),
              SizedBox(width: 5),
              Image.asset(
                ic_rectangleLine,
                width: SizeConfig.margin_padding_50 * 1.5,
              ),
              SizedBox(width: 5),
              _buildLog(
                title: secondTitle,
                isCheck: !isCheck,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLog({
    required bool isCheck,
    required String title,
  }) {
    return Row(
      children: [
        Image.asset(
          isCheck ? ic_dotSelect : ic_dotUnSelect,
          scale: 2.8,
        ),
        SizedBox(width: 3),
        Text(
          title.tr(),
          style: TSB.regularSmall(
            textColor:
                isCheck ? mainWhiteColor : mainWhiteColor.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
