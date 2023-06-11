import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

import '../../others/text_field_widget.dart';
import '../../util/others/text_styles.dart';

class CVMTextFormField extends StatelessWidget {
  final String title;
  final String hintForm;
  final int maxLength;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? formWidget;
  final Function(String)? onChanged;
  final Function()? onTap;
  final TextCapitalization textCapitalization;
  final Widget? suffixIcon;
  final String errorMsgValidation;
  const CVMTextFormField({
    Key? key,
    required this.title,
    this.hintForm = "",
    this.errorMsgValidation = "",
    this.maxLength = 30,
    this.readOnly = false,
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.suffixIcon,
    this.formWidget,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.margin_padding_8),
            child: Text(
              title.tr(),
              style: TSB.regularSmall(),
            ),
          ),
        formWidget ??
            InputFieldWidget(
              onChanged: onChanged,
              textCapitalization: textCapitalization,
              errorMsgValidation: errorMsgValidation,
              maxLength: maxLength,
              keyboardType: keyboardType,
              suffixIcon: suffixIcon,
              hint: hintForm,
              onTap: onTap,
              readOnly: readOnly,
              controller: controller,
            ),
        SizedBox(
          height: SizeConfig.margin_padding_13,
        )
      ],
    );
  }
}
