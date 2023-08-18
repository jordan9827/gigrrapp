import 'package:cached_network_image/cached_network_image.dart';
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
  final String profileUrl;
  final String candidateName;

  const GiggrOTPStartStopView({
    this.otp = "",
    this.title = "",
    this.candidateName = "",
    this.profileUrl = "",
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
        height: SizeConfig.screenHeight * 0.48,
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
            Container(
              height: SizeConfig.margin_padding_40 * 2.3,
              width: SizeConfig.margin_padding_40 * 2.3,
              padding: EdgeInsets.all(
                SizeConfig.margin_padding_5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  SizeConfig.margin_padding_40 * 2.3,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffCD3E8A),
                    Color(0xff585DE9),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  SizeConfig.margin_padding_40 * 2,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.profileUrl,
                  alignment: Alignment.center,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  placeholder: (_, url) => Image.asset(upload_image),
                ),
              ),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_10,
            ),
            Text(
              widget.candidateName,
              textAlign: TextAlign.center,
              style: TSB.semiBoldHeading(),
            ),
            _buildSpacer(),
            Text(
              "Your OTP is",
              textAlign: TextAlign.center,
              style: TSB.regularMedium(
                textColor: textRegularColor,
              ),
            ),
            _buildSpacer(
              size: SizeConfig.margin_padding_5,
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
