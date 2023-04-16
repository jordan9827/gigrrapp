import 'package:flutter/material.dart';
import 'package:square_demo_architecture/util/others/size_config.dart';

import '../../others/constants.dart';

const FontWeight Regular = FontWeight.w400;
const FontWeight SemiBold = FontWeight.w600;
const FontWeight Bold = FontWeight.w700;

//acronym of TextStyleBuilder
class TSB {
  static TextStyle regular({
    Color? textColor,
    required double textSize,
    bool? underLineText,
  }) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? mainBlackColor,
        fontWeight: Regular,
        decoration: (underLineText != null && underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle regularVSmall({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeVerySmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle regularSmall({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeSmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle regularMedium({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeMedium,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle regularLarge({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeMedium,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle regularXLarge({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeXLarge,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle regularHeading({Color? textColor, bool? underLineText}) {
    return TSB.regular(
        textSize: SizeConfig.textSizeHeading,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBold(
      {Color? textColor, required double textSize, bool? underLineText}) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? mainBlackColor,
        fontWeight: SemiBold,
        decoration: (underLineText != null && underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle semiBoldVSmall({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeVerySmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBoldSmall({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeSmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBoldMedium({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeMedium,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBoldLarge({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeLarge,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBoldXLarge({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeXLarge,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle semiBoldHeading({Color? textColor, bool? underLineText}) {
    return TSB.semiBold(
        textSize: SizeConfig.textSizeHeading,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle bold(
      {Color? textColor, @required double? textSize, bool? underLineText}) {
    return TextStyle(
        fontFamily: FONT_FAMILY,
        color: textColor ?? mainBlackColor,
        fontWeight: Bold,
        decoration: (underLineText != null && underLineText == true)
            ? TextDecoration.underline
            : TextDecoration.none,
        fontSize: textSize);
  }

  static TextStyle boldVSmall({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeVerySmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle boldSmall({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeSmall,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle boldMedium({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeMedium,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle boldLarge({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeLarge,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle boldXLarge({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeXLarge,
        textColor: textColor,
        underLineText: underLineText);
  }

  static TextStyle boldHeading({Color? textColor, bool? underLineText}) {
    return TSB.bold(
        textSize: SizeConfig.textSizeHeading,
        textColor: textColor,
        underLineText: underLineText);
  }
}
