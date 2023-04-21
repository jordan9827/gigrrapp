import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../others/constants.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';

class FormAppBarWidgetView extends StatelessWidget {
  bool isCheck;
  FormAppBarWidgetView({Key? key, this.isCheck = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsetsMargin,
      height: SizeConfig.margin_padding_85 * 1.2,
      width: MediaQuery.of(context).size.width,
      color: independenceColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.margin_padding_29,
          ),
          Text(
            "create_your_profile".tr(),
            style: TSB.regularLarge(textColor: mainWhiteColor),
          ),
          SizedBox(
            height: SizeConfig.margin_padding_10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLog(isCheck: isCheck, title: "personal_info"),
              SizedBox(width: 5),
              Image.asset(ic_rectangleLine,
                  width: SizeConfig.margin_padding_50 * 1.5),
              SizedBox(width: 5),
              _buildLog(title: "business_info", isCheck: !isCheck),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLog({required bool isCheck, required String title}) {
    return Row(
      children: [
        Image.asset(isCheck ? ic_dotSelect : ic_dotUnSelect, scale: 2.8),
        SizedBox(width: 3),
        Text(
          title.tr(),
          style: TSB.regularSmall(
              textColor:
                  isCheck ? mainWhiteColor : mainWhiteColor.withOpacity(0.5)),
        ),
      ],
    );
  }
}
