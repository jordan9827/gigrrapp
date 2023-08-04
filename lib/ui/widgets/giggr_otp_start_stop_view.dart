import 'package:flutter/material.dart';
import '../../../../../others/constants.dart';
import '../../../../../others/loading_button.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';

import 'package:easy_localization/easy_localization.dart';

class GiggrOTPStartStopView extends StatefulWidget {
  final String otp;
  final String title;

  const GiggrOTPStartStopView({
    this.otp = "",
    this.title = "",
    Key? key,
  }) : super(key: key);

  @override
  State<GiggrOTPStartStopView> createState() => GiggrOTPStartStopViewState();
}

class GiggrOTPStartStopViewState extends State<GiggrOTPStartStopView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Dialog(
      insetPadding: EdgeInsets.all(30),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2555555,
        margin: EdgeInsets.all(
          SizeConfig.margin_padding_13,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Align(
                alignment: Alignment.topRight,
                child: SizedBox(
                  height: SizeConfig.margin_padding_15,
                  width: SizeConfig.margin_padding_15,
                  child: Image.asset(
                    ic_close_blck,
                    color: textRegularColor,
                  ),
                ),
              ),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_10,
            ),
            Text(
              widget.title.tr(),
              style: TSB.semiBoldHeading(),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_10,
            ),
            Text(
              "Your OTP is",
              textAlign: TextAlign.center,
              style: TSB.regularMedium(
                textColor: textRegularColor,
              ),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_10,
            ),
            Text(
              widget.otp,
              textAlign: TextAlign.center,
              style: TSB.bold(
                textSize: SizeConfig.margin_padding_40,
                textColor: mainPinkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacer({double? size}) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_24,
    );
  }
}
