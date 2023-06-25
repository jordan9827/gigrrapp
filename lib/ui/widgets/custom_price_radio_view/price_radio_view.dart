import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../others/constants.dart';
import '../../../util/others/size_config.dart';
import '../../../util/others/text_styles.dart';
import 'price_radio_view_model.dart';

class CustomPriceRadioButtonView extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  const CustomPriceRadioButtonView({
    Key? key,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => CustomPriceRadioButtonViewModel(controller),
      builder: (_, viewModel, child) => Row(
        children: viewModel.priceList
            .map(
              (e) => Container(
                margin: EdgeInsets.only(
                  right: SizeConfig.margin_padding_15,
                ),
                child: Row(
                  children: [
                    Radio<String>(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      activeColor: mainPinkColor,
                      value: e,
                      groupValue: viewModel.initialPrice,
                      onChanged: (ele) => viewModel.setPrice(ele, controller),
                    ),
                    Text(
                      e.tr(),
                      style: TSB.regularSmall(
                        textColor: viewModel.initialPrice != e
                            ? textRegularColor
                            : mainBlackColor,
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
