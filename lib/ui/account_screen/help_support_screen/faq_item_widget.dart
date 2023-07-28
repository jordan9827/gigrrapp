import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:square_demo_architecture/ui/account_screen/help_support_screen/help_support_view_model.dart';
import 'package:stacked/stacked.dart';

import '../../../data/network/dtos/faq_response.dart';
import '../../../others/constants.dart';
import '../../../util/others/image_constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';

class FAQItemWidget extends ViewModelWidget<HelpSupportScreenViewModel> {
  final FAQResponseData faq;

  FAQItemWidget({required this.faq});

  @override
  Widget build(BuildContext context, HelpSupportScreenViewModel viewModel) {
    var radius = SizeConfig.margin_padding_15;
    var sizeOfExpanded =
        viewModel.isVisible ? SizeConfig.margin_padding_5 : radius;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.margin_padding_5,
      ),
      decoration: BoxDecoration(
        color: mainWhiteColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: radius, bottom: sizeOfExpanded),
            margin: EdgeInsets.symmetric(horizontal: radius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  faq.question,
                  style: TSB.boldSmall(),
                ),
                InkWell(
                  onTap: viewModel.onActionVisible,
                  child: Image.asset(
                    viewModel.isVisible ? arrow_drop_up : arrow_drop_down,
                    scale: 2.8,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: viewModel.isVisible,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: radius,
              ),
              child: Divider(
                thickness: 2,
                color: Color(0xff707070),
              ),
            ),
          ),
          Visibility(
            visible: viewModel.isVisible,
            child: AnimatedContainer(
              margin: EdgeInsets.only(
                bottom: SizeConfig.margin_padding_5,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: radius,
              ),
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: mainWhiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Html(
                style: {
                  'p': Style(fontSize: FontSize.large),
                },
                data: faq.answer,
                shrinkWrap: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
