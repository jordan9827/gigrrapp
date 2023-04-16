import 'dart:io' show Platform;

import 'package:flutter/material.dart';

const String devBaseURL = "https://ummys-staging.codiantdev.com";
const String qaBaseURL = "";
const String stagingBaseURL = "";
const String localBaseURL = "";

String androidDeviceType = "android_customer";
String iOSDeviceType = "ios_customer";

const int paginatedDataPerPage = 5;
const int textFieldMaximumCharacter = 50;
const int textFieldNumberMaximumCharacter = 10;
const int textFieldPasswordMaximumCharacter = 20;
const int aadhaarMaxCharacter = 12;
const int panMaxCharacter = 10;
const String commonNetworkMsg =
    "Unable to process, please check your internet connection and retry again.";
const String commonLoginSignupMessage = "Please Login / Register to see your";

const FCM_ADMIN_TOPIC = "admin_notifications";

const FCM_MODULE_ADMIN_SCHEDULED_NOTIFICATION = "admin_scheduled_notification";
const FCM_MODULE_SQUARE_PLUS = "";

const NOTIFICATION_CHANNEL_ID = "BASE_CHANNEL";
const NOTIFICATION_CHANNEL_DESCRIPTION = "Base channel for notification";

const RECENT_COIN_SEARCHED = "RECENT_ITEM";

const List<String> emailDomain = [
  "com",
  "in",
  "org",
];

//Nested navigation keys
const KYC_NAVIGATOR = 1;
const SQUARE_PLAN_NAVIGATOR = 2;
const WITHDRAW_NAVIGATOR = 3;
const ADD_FUNDS_NAVIGATOR = 4;

const kBNBBottomIconHeight = 36.0;
const kBottomDottedDesignHeight = 28.0;

//IntroScreenView
const kIntroScreenBNBIconWidth = 64.0;

//ReferralCodeView
const kTopPadding = 18.0;

//BottomNavBar
const kIndicatorWidth = 24.0;
const kIndicatorHeight = 4.0;
const kBottomContainerHeight = 56.0;
const kExpandableFabVerticalPadding = 25.0;

// ActionButton
const kActionButtonFontSize = 11.0;

// HomeViewAppBar
const kHomeViewAppBarHeight = 56.0;

//icon size
const double kIconSize = 20;

//dynamic font family

String? getFontFamily() {
  return Platform.isAndroid ? "Inter" : null;
}

const greenBlueColor = Color(0xff18181C);

const fieldsBackGroundColor = Color(0xff18181C);
Color mainColor = Colors.blueAccent.shade400;

const fieldsActiveElementColor = Color(0xff303239);
const fieldsRegularColor = Color(0xff878787);
const fieldsInActiveColor = Color(0xff6E6E6E);

//text
const textRegularColor = Color(0xff575656);
const textNoticeColor = Color(0xff8E8F90);
const textUnAvailable = Color(0xff565656);

//light theme color
const lightThemeBackRoundColor = Color(0xffFCF3EA);
const lightThemeAccentColor = Color(0xffFCC188);
const lightThemeBlackColor = Color(0xff333333);
const lightThemeGreenColor = Color(0xff54B64F);
const lightThemeRedColor = Color(0xffFF625E);
const lightThemeGreyColor = Color(0xff808080);
const lightThemeLightCreamWhiteColor = Color(0xffF5F5F5);
const lightThemeMenuColor = Color(0xffCEBFB1);
const lightThemeDividerColor = Color(0xffF9E1CA);
const lightThemeNoticeColor = Color(0xffD7A575);

bool validatePassword(String password) => RegExp(
        r"(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[!@#$%^&])^[a-zA-Z0-9!@#$%^&]{6,12}$")
    .hasMatch(password);

bool validateEmail(String email) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  return RegExp(pattern.toString()).hasMatch(email);
}
