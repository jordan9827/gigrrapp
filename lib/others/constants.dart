import 'dart:developer';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fcm_service/fcm_service.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app/app.locator.dart';
import '../data/local/preference_keys.dart';
import '../util/others/size_config.dart';

const String devBaseURL = "https://gigrr.in/development";
const String qaBaseURL = "";
const String stagingBaseURL = "https://gigrr.in/admin";
const String localBaseURL = "";

String languageCode =
    locator<SharedPreferences>().getString(PreferenceKeys.APP_LANGUAGE.text) ??
        "hi";

const String countryType = "in";

const String FONT_FAMILY = "Figtree";
const String MAPBOX_TOKEN =
    "pk.eyJ1IjoidGFyY2gwNyIsImEiOiJja3luczY0cGwxemd3Mm9xb213Mnp3aW4zIn0.X0dvxOdFnXbdjX97wgM7Ig";

String androidDeviceType = "android";
String iOSDeviceType = "ios";

String countryCode = "+91";
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

String? getFontFamily() {
  return FONT_FAMILY;
}

const greenBlueColor = Color(0xff18181C);
const mainBlackColor = Colors.black;
const mainWhiteColor = Colors.white;
const mainPinkColor = Color(0xffEE356F);
const mainGreenColor = Color(0xff38BB64);
const lightPinkColor = Color(0xffFEEAF0);
const mainGrayColor = Color(0xffF2F2F2);
const mainBlueColor = Color(0xff4263FB);
const independenceColor = Color(0xff48466D);
const fieldsBackGroundColor = Color(0xff18181C);
Color mainColor = Colors.blueAccent.shade400;

const fieldsActiveElementColor = Color(0xff303239);
const fieldsRegularColor = Color(0xff878787);
const fieldsInActiveColor = Color(0xff6E6E6E);
const fieldsActiveElementColor2 = Color(0xffB3B3B3);

//text
const textRegularColor = Color(0xff676767);
const textRegularColor1 = Color(0xff1E1B1B);
const textNoticeColor = Color(0xff656565);
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

bool validateIFSC(String ifsc) =>
    RegExp(r"^[A-Z]{4}0[A-Z0-9]{6}$").hasMatch(ifsc);

bool validateAadhaarCard(String aadhaar) =>
    RegExp(r'^[2-9]{1}[0-9]{3}\\s[0-9]{4}\\s[0-9]{4}$').hasMatch(aadhaar);

bool validatePhone(String phone) => RegExp(
        r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
    .hasMatch(phone);

bool validateOtp(int otp) =>
    RegExp(r"[a-z0-9]*\\d[a-z0-9]*").hasMatch(otp.toString());

bool validateEmail(String email) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  return RegExp(pattern.toString()).hasMatch(email);
}

EdgeInsets edgeInsetsMargin = EdgeInsets.symmetric(
  horizontal: SizeConfig.margin_padding_15,
);

String getDeviceType() {
  if (Platform.isAndroid) {
    return androidDeviceType;
  } else {
    return iOSDeviceType;
  }
}

var deviceInfo = DeviceInfoPlugin();

Future<String> deviceToken() async {
  if (Platform.isAndroid) {
    return (await deviceInfo.androidInfo).id;
  }
  return (await deviceInfo.iosInfo).identifierForVendor ?? "";
}

Future<String> fcmToken() async {
  return await locator<FCMService>().token() ?? "";
}

Future<String> appVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

double setHeightOfDrop(int length) {
  log("setHeightOfDrop $length");
  double size = SizeConfig.margin_padding_50 * 5;
  if (length <= 2) {
    return SizeConfig.margin_padding_50 * 1.5;
  } else if (length <= 3) {
    return SizeConfig.margin_padding_50 * 2.5;
  } else if (length <= 4) {
    return SizeConfig.margin_padding_50 * 3.5;
  }
  return size;
}
