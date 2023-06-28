import 'package:flutter/material.dart';
import '../../../../../others/constants.dart';
import '../../../../../others/loading_button.dart';
import '../../../../../util/others/image_constants.dart';
import '../../../../../util/others/size_config.dart';
import '../../../../../util/others/text_styles.dart';

import 'package:easy_localization/easy_localization.dart';

class CustomOfferDialog extends StatefulWidget {
  final Function onTap;
  final bool isLoading;
  final String title;
  final String buttonText;
  final String subTitle;
  final String cancel;
  const CustomOfferDialog({
    required this.onTap,
    this.title = "",
    this.subTitle = "",
    this.buttonText = "",
    this.cancel = "",
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomOfferDialog> createState() => CustomOfferDialogState();
}

class CustomOfferDialogState extends State<CustomOfferDialog> {
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
        height: MediaQuery.of(context).size.height * 0.58,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.margin_padding_20,
          vertical: SizeConfig.margin_padding_15,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _buildSpacer(size: SizeConfig.margin_padding_15),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.margin_padding_15,
              ),
              child: Image.asset(ic_congratutation),
            ),
            _buildSpacer(),
            Text(
              "Super Enterprise",
              style: TSB.semiBoldHeading(),
            ),
            _buildSpacer(size: SizeConfig.margin_padding_5),
            Text(
              widget.subTitle.tr(),
              textAlign: TextAlign.center,
              style: TSB.regularMedium(),
            ),
            _buildSpacer(),
            LoadingButton(
              title: widget.buttonText,
              action: widget.onTap,
            ),
            _buildSpacer(),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Text(
                "cancel".tr(),
                style: TSB.regularMedium(
                  textColor: independenceColor,
                ),
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
