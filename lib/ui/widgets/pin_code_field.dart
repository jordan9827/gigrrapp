import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../others/constants.dart';
import '../../util/others/size_config.dart';

class CVPinCodeTextField extends StatelessWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  const CVPinCodeTextField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return PinCodeTextField(
      obscureText: true,
      length: 4,
      autoDisposeControllers: false,
      scrollPadding: EdgeInsets.zero,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      animationType: AnimationType.fade,
      enableActiveFill: true,
      cursorColor: mainBlackColor,
      obscuringCharacter: '*',
      controller: controller,
      pinTheme: PinTheme(
        activeFillColor: mainGrayColor,
        inactiveFillColor: mainGrayColor,
        fieldHeight: SizeConfig.margin_padding_50,
        fieldWidth: SizeConfig.margin_padding_24 * 1.8,
        activeColor: mainGrayColor,
        inactiveColor: mainGrayColor,
        selectedColor: mainGrayColor,
        selectedFillColor: mainGrayColor,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      keyboardType: TextInputType.number,
      animationDuration: const Duration(milliseconds: 300),
      onChanged: onChanged,
      textStyle: const TextStyle(color: Colors.black),
      appContext: context,
    );
  }
}
