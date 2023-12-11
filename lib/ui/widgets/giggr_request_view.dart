import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:square_demo_architecture/others/loading_button.dart';
import 'package:square_demo_architecture/others/text_field_widget.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

import '../../others/constants.dart';
import '../../util/others/text_styles.dart';
import 'custom_price_radio_view/price_radio_view.dart';

class GigrrCustomRequestView extends StatelessWidget {
  final String giggrName;
  final String profileImage;
  final TextEditingController priceController;
  final TextEditingController selectPriceTypeController;
  final bool isEmployer;
  const GigrrCustomRequestView({
    Key? key,
    required this.giggrName,
    this.profileImage = "",
    this.isEmployer = false,
    required this.priceController,
    required this.selectPriceTypeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subTitle = isEmployer ? "requestGigrr_1" : "requestGigrr_2";
    var offer = isEmployer ? "offer_request_1" : "offer_request_2";
    // var buttonText = isEmployer ? "submit_application" : "offer_daily_price";
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: SizeConfig.margin_padding_50 * 8,
                width: SizeConfig.screenWidth,
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
                child: Image.network(
                  profileImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                children: [
                  Text(
                    giggrName,
                    style: TSB.semiBoldXLarge(
                      textColor: mainWhiteColor,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.margin_padding_5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.margin_padding_20,
                    ),
                    child: Text(
                      subTitle.tr(),
                      textAlign: TextAlign.center,
                      style: TSB.regularMedium(
                        textColor: mainWhiteColor,
                      ),
                    ),
                  ),
                  _buildSpace()
                ],
              ),
            )
          ],
        ),
        _buildSpace(),
        Text(
          offer.tr(),
          style: TSB.semiBoldLarge(),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_5,
        ),
        _buildSpace(),
        InputFieldWidget(
          hint: "i.e. ₹ 400",
          controller: priceController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        _buildSpace(size: SizeConfig.margin_padding_20),
      ],
    );
  }

  Widget _buildSpace({double? size}) {
    return SizedBox(
      height: size ?? SizeConfig.margin_padding_10,
    );
  }

  Widget _buildSetPriceView() {
    return CustomPriceRadioButtonView(
      controller: selectPriceTypeController,
    );
  }
}
