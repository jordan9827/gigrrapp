import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//This class is used to provide dimensions (eg. margins, padding, width & height) to our app, which are sized as
//per different screen resolutions
class SizeConfig {
  static double screenWidth = 0;

  static double screenWidthActual = 0;

  static double screenHeight = 0;

  static double screenHeightActual = 0;

  static double blockSizeHorizontal = 0;

  static double blockSizeVertical = 0;

  static double _safeAreaHorizontal = 0;

  static double _safeAreaVertical = 0;

  static double safeBlockHorizontal = 0;

  static double safeBlockVertical = 0;
  static double textSizeVerySmall = 0,
      textSizeSmall = 0,
      textSizeMedium = 0,
      textSizeLarge = 0,
      textSizeHeading = 0,
      textSizeXLarge = 0;
  static double margin_padding_20 = 0,
      margin_padding_10 = 0,
      margin_padding_5 = 0,
      margin_padding_2 = 0,
      margin_padding_3 = 0,
      margin_padding_37 = 0,
      margin_padding_35 = 0,
      margin_padding_15 = 0,
      margin_padding_29 = 0,
      margin_padding_40 = 0,
      devicePixelRatio = 0,
      margin_padding_16 = 0,
      margin_padding_17 = 0,
      margin_padding_18 = 0,
      margin_padding_70 = 0,
      separatorWidth = 0,
      strokeWidth = 0,
      inputBorderRadius = 0,
      margin_padding_85 = 0,
      margin_padding_50 = 0,
      margin_padding_65 = 0,
      margin_padding_28 = 0,
      margin_padding_4 = 0,
      margin_padding_24 = 0,
      margin_padding_13 = 0,
      margin_padding_100 = 0,
      margin_padding_8 = 0,
      margin_padding_14 = 0;
  static double mapMarkerSize = 0,
      googleMapPaddingTop = 0,
      googleMapPaddingLeft = 0;

  static void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    devicePixelRatio = _mediaQueryData.devicePixelRatio;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    screenHeightActual = screenHeight - _safeAreaVertical;
    screenWidthActual = screenWidth - _safeAreaHorizontal;

    textSizeVerySmall = safeBlockHorizontal * 3.25; //for 12 pixel text-size
    textSizeSmall = safeBlockHorizontal * 4; //for 14 pixel text-size
    textSizeMedium = safeBlockHorizontal * 4.5; //for 16 pixel text-size
    textSizeLarge = safeBlockHorizontal * 5; //for 18 pixel text-size
    textSizeXLarge = safeBlockHorizontal * 6; //for 20 pixel text-size
    textSizeHeading = safeBlockHorizontal * 6.5; //for 24 pixel text-size

    separatorWidth = safeBlockHorizontal * 0.25; //approx 1 pixel
    strokeWidth = safeBlockHorizontal * 0.5; //approx 1.5 pixel
    inputBorderRadius = safeBlockHorizontal * 1.5; //approx 5 pixel
    margin_padding_4 = safeBlockHorizontal * 1; //approx 5 pixel
    margin_padding_8 = safeBlockHorizontal * 2; //approx 8 pixel
    margin_padding_5 = safeBlockHorizontal * 1.5; //approx 5 pixel
    margin_padding_10 = safeBlockHorizontal * 3; //approx 10 pixel
    margin_padding_13 = safeBlockHorizontal * 3.5; //approx 13 pixel
    margin_padding_14 = safeBlockHorizontal * 3.75; //approx 13 pixel
    margin_padding_15 = safeBlockHorizontal * 4; //approx 15 pixel
    margin_padding_16 = safeBlockHorizontal * 4.5; //approx 16 pixel
    margin_padding_17 = safeBlockHorizontal * 4.8; //approx 17 pixel
    margin_padding_18 = safeBlockHorizontal * 5; //approx 18 pixel
    margin_padding_20 = safeBlockHorizontal * 6; //approx 20 pixel
    margin_padding_24 = safeBlockHorizontal * 6.5; //approx 24 pixel
    margin_padding_29 = safeBlockHorizontal * 8; //approx 29 pixel
    margin_padding_35 = safeBlockHorizontal * 10; //approx 35 pixel
    margin_padding_40 = safeBlockHorizontal * 11; //approx 40 pixel
    margin_padding_70 = safeBlockHorizontal * 19.5; //approx 70 pixel
    margin_padding_85 = safeBlockHorizontal * 23.5; //approx 85 pixel
    margin_padding_50 = safeBlockHorizontal * 14; //approx 50 pixel
    margin_padding_65 = safeBlockHorizontal * 18; //approx 65 pixel
    margin_padding_28 = safeBlockHorizontal * 8; //approx 28 pixel
    margin_padding_2 = safeBlockHorizontal * 0.5; //approx 2 pixel
    margin_padding_37 = safeBlockHorizontal * 9;
    margin_padding_3 = margin_padding_2 + safeBlockHorizontal * 0.25;
    margin_padding_100 = margin_padding_50 + margin_padding_50;

    mapMarkerSize = safeBlockHorizontal * 7; //approx 25 pixel

    googleMapPaddingTop = safeBlockVertical * 37;
    googleMapPaddingLeft = margin_padding_10;
  }

  double get(double val) => safeBlockHorizontal * val;
}
