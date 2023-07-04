import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../others/constants.dart';
import '../../util/others/size_config.dart';
import '../../util/others/text_styles.dart';

class PriceRangeFilterView extends StatelessWidget {
  final RangeValues rangeValues;
  final String rangeText;
  final Function(RangeValues)? onChanged;
  const PriceRangeFilterView({
    Key? key,
    required this.rangeValues,
    this.onChanged,
    this.rangeText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle("Select Cost"),
            Text(
              rangeText,
              style: TSB.regularVSmall(textColor: textRegularColor),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.margin_padding_5,
          ),
          padding: EdgeInsets.only(
            bottom: SizeConfig.margin_padding_8,
            top: SizeConfig.margin_padding_3,
          ),
          child: SliderTheme(
            data: SliderThemeData(
              rangeTickMarkShape: const RoundRangeSliderTickMarkShape(
                tickMarkRadius: 0,
              ),
              valueIndicatorColor: Colors.pink,
              overlayShape: SliderComponentShape.noThumb,
            ),
            child: RangeSlider(
              activeColor: mainPinkColor,
              inactiveColor: mainGrayColor,
              values: rangeValues,
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                rangeValues.start.round().toString(),
                rangeValues.end.round().toString(),
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_10,
        ),
      ],
    );
  }

  Widget _buildTitle(String val) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
      child: Text(
        val.tr(),
        style: TSB.regularSmall(),
      ),
    );
  }
}
