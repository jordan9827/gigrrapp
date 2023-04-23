import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class InputFieldWidget extends StatelessWidget {
  final IconData? icon;
  final ImageProvider? imageProvider;
  final String hint;
  final String errorMsgValidation;
  final bool isMobileNumber;
  final Color? fillColor;
  final double borderRadius;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final bool isPassword;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? isDense;
  final String? helperText;
  final bool enabled;
  final double horizontalPadding;
  final bool hideIconTextDivider;
  final TextInputType? keyboardType;
  final EdgeInsets contentPadding;
  final Function(String)? onFieldSubmitted;
  final int? maxInputLength;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final String? labelText;
  final int maxLength;
  final int maxLines;
  const InputFieldWidget({
    Key? key,
    this.icon,
    this.hintStyle,
    this.maxLength = 30,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.errorStyle,
    this.imageProvider,
    this.labelText,
    this.errorMsgValidation = "",
    this.readOnly = false,
    required this.hint,
    this.isMobileNumber = false,
    this.controller,
    this.borderRadius = 10,
    this.helperText,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines = 1,
    this.textStyle,
    this.focusNode,
    this.isDense,
    this.contentPadding = EdgeInsets.zero,
    this.enabled = true,
    this.isPassword = false,
    this.suffix,
    this.suffixIcon,
    this.prefixIcon,
    this.horizontalPadding = 6.5,
    this.hideIconTextDivider = false,
    this.keyboardType,
    this.fillColor,
    this.maxInputLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          maxLength: maxLength,
          maxLines: maxLines,
          keyboardType: keyboardType ?? TextInputType.text,
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: TextStyle(
              color: Colors.blueAccent.shade400,
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hint.tr(),
            filled: true,
            fillColor: mainGrayColor,
            hintStyle: TextStyle(
              color: textRegularColor,
            ),
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: independenceColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: mainGrayColor,
              ),
            ),
          ),
        ),
        if (errorMsgValidation.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(
              errorMsgValidation,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          )
      ],
    );
  }
}
