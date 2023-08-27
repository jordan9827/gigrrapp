import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import '../../../../others/constants.dart';
import '../../../../util/others/size_config.dart';
import '../../../../util/others/text_styles.dart';

class EmployerPreferenceCustomUIWidget extends StatelessWidget {
  final String title;
  final Widget child;
  final double? padding;
  const EmployerPreferenceCustomUIWidget({
    Key? key,
    required this.title,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.margin_padding_15,
        ),
        Text(
          title.tr(),
          style: TSB.semiBoldMedium(
            textColor: independenceColor,
          ),
        ),
        SizedBox(
          height: SizeConfig.margin_padding_8,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            padding ?? SizeConfig.margin_padding_15,
          ),
          decoration: BoxDecoration(
            color: mainWhiteColor,
            borderRadius: BorderRadius.circular(
              SizeConfig.margin_padding_15,
            ),
          ),
          child: child,
        )
      ],
    );
  }
}
