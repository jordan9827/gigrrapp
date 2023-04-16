import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          keyboardType: keyboardType ?? TextInputType.text,
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            counterText: '',
            labelStyle: TextStyle(
              color: Colors.blueAccent.shade400,
            ),
            contentPadding: const EdgeInsets.all(10),
            hintText: hint,
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.2),
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
