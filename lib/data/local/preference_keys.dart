class PreferenceKeys{
  static const PreferenceKeys ACCESS_TOKEN = const PreferenceKeys._("ACCESS_TOKEN");
  static const PreferenceKeys DEVICE_ID = const PreferenceKeys._("DEVICE_ID");
  static const PreferenceKeys MENU_ITEM_SELECTED_INDEX = const PreferenceKeys._("MENU_ITEM_SELECTED_INDEX");
  static const PreferenceKeys PROCESS_ID = const PreferenceKeys._("PROCESS_ID");
  static const PreferenceKeys NOTIFICATION_COUNT = const PreferenceKeys._("NOTIFICATION_COUNT");

  /*SIGN IN KEYS*/
  static const PreferenceKeys USER_EMAIL = const PreferenceKeys._("USER_EMAIL");
  static const PreferenceKeys USER_PASSWORD = const PreferenceKeys._("USER_PASSWORD");
  static const PreferenceKeys REMEMBER_ME = const PreferenceKeys._("REMEMBER_ME");
  static const PreferenceKeys PHONE_NUMBER = const PreferenceKeys._("PHONE_NUMBER");
  static const PreferenceKeys USER_NAME = const PreferenceKeys._("USER_NAME");
  static const PreferenceKeys USER_IMAGE_URL = const PreferenceKeys._("USER_IMAGE_URL");
  static const PreferenceKeys USER_ID = const PreferenceKeys._("USER_ID");
  static const PreferenceKeys USER_DATA = const PreferenceKeys._("USER_DATA");
  static const PreferenceKeys USER_ADDRESS_DATA = const PreferenceKeys._("USER_ADDRESS_DATA");
  static const PreferenceKeys STATE_LIST = const PreferenceKeys._("STATE_LIST");
  static const PreferenceKeys APP_LANGUAGE = const PreferenceKeys._("APP_LANGUAGE");
  static const PreferenceKeys FIRST_TIME = const PreferenceKeys._("FIRST_TIME");
  static const PreferenceKeys FIRST_TIME_ACCESS_LOCATION = const PreferenceKeys._("FIRST_TIME_ACCESS_LOCATION");
  static const PreferenceKeys GUEST_USER = const PreferenceKeys._("GUEST_USER");
  final String text;
  const PreferenceKeys._(this.text);

  String getKey() => text;
}