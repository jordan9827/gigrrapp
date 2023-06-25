import 'dart:io';
import 'package:fcm_service/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const ID = "FCM_SERVICE_CLASS";
const TITLE = "Default Notification";
const DESCRIPTION = "This channel is used for all default notifications";
const NOTIFICATION_CHANNEL_ID = "BASE_CHANNEL";
const NOTIFICATION_CHANNEL_DESCRIPTION = "Base channel for notification";

class FCMService {
  bool isOpenFromNotification = false;
  final _messaging = FirebaseMessaging.instance;
  static final _flutterNotificationPlugin = FlutterLocalNotificationsPlugin();

  static Future<FCMService> getInstance() async {
    await Firebase.initializeApp();
    tz.initializeTimeZones();
    tz.setLocalLocation(
        tz.getLocation(await FlutterNativeTimezone.getLocalTimezone()));
    return Future.value(FCMService());
  }

  /// Call this method in main, if Firebase.initializeApp() is called in main, call this after that statement.
  /// Pass [onBackgroundHandler] to handle splash messages. If [AndroidNotificationChannel] is passed, make sure to include
  /// it in [AndroidManifest.xml]. The default channel id is "FCM_SERVICE_CLASS" . Other arguments are to set up for iOS notification.
  ///
  /// For web, iOS and macOS, if permission is not granted then [PlatformException] is thrown.
  Future<void> setFCMService({
    required Future<void> Function(RemoteMessage message) onBackgroundHandler,
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      ID,
      TITLE,
      description: DESCRIPTION,
    ),
    alert = true,
    announcement = false,
    badge = true,
    carPlay = false,
    criticalAlert = false,
    provisional = false,
    sound = true,
  }) async {
    // Request permission of web, iOS and macOS
    if (kIsWeb || Platform.isIOS || Platform.isMacOS) {
      final authorized = await _requestPermission(
        alert: alert,
        announcement: announcement,
        badge: badge,
        carPlay: carPlay,
        criticalAlert: criticalAlert,
        provisional: provisional,
        sound: sound,
      );
      if (!authorized) {
        throw PlatformException(
            code: "Permission not granted for notification");
      }
    }
    // _flutterNotificationPlugin.initialize(
    //   InitializationSettings(
    //     android: AndroidInitializationSettings("app_icon"),
    //   ),
    //   onSelectNotification: (string) {
    //     print("$string local notifcation data");
    //   },
    // );
    // await _flutterNotificationPlugin
    //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(androidNotificationChannel);

    FirebaseMessaging.onBackgroundMessage(onBackgroundHandler);
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: alert,
      badge: badge,
      sound: sound,
    );
  }

  Future<void> setUpLocalNotification({
    required Function(String?)? onSelectNotificationAction,
  }) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      ID,
      TITLE,
      description: DESCRIPTION,
    );
    _flutterNotificationPlugin.initialize(
      const InitializationSettings(
        iOS: IOSInitializationSettings(),
        android: AndroidInitializationSettings("app_icon"),
      ),
      onSelectNotification: onSelectNotificationAction,
    );
    await _flutterNotificationPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Stream<RemoteMessage> onMessageOpenedAppStream() {
    return FirebaseMessaging.onMessageOpenedApp;
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    required String payload,
    tz.Location? local,
    NotificationDetails? notificationDetails,
    UILocalNotificationDateInterpretation uiLocalNotificationDateInterpretation =
        UILocalNotificationDateInterpretation.absoluteTime,
    bool androidAllowWhileIdle = true,
  }) async {
    await _flutterNotificationPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(dateTime, local ?? tz.local),
      notificationDetails ??
          NotificationDetails(
            android: AndroidNotificationDetails(
              NOTIFICATION_CHANNEL_ID,
              NOTIFICATION_CHANNEL_DESCRIPTION,
              styleInformation: BigTextStyleInformation(''),
            ),
          ),
      uiLocalNotificationDateInterpretation:
          uiLocalNotificationDateInterpretation,
      androidAllowWhileIdle: androidAllowWhileIdle,
      payload: payload,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required NotificationDetails notificationDetails,
    required String payload,
  }) async {
    print("payload : $payload");
    await _flutterNotificationPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void listenForegroundMessage(Function(RemoteMessage) listener) =>
      FirebaseMessaging.onMessage.listen(listener);

  /// If the application has been opened from a terminated state via a [RemoteMessage]
  /// (containing a [Notification]), it will be returned, otherwise it will be `null`.
  ///
  /// Once the [RemoteMessage] has been consumed, it will be removed and further
  /// calls to [getInitialMessage] will be `null`.
  ///
  /// This should be used to determine whether specific notification interaction
  /// should open the app with a specific purpose (e.g. opening a chat message,
  /// specific screen etc).
  Future<RemoteMessage?> initialMessage() => _messaging.getInitialMessage();

  /// Returns the default FCM token for this device.
  Future<String?> token({String? vapidKey}) =>
      _messaging.getToken(vapidKey: vapidKey);

  Future<void> deleteToken() async {
    await _messaging.deleteToken();
  }

  /// Returns a Stream that is called when an incoming FCM payload is received whilst
  /// the Flutter instance is in the foreground.
  ///
  /// The Stream contains the [RemoteMessage].
  ///
  /// To handle messages whilst the app is in the splash or terminated,
  /// see [onBackgroundMessage].
  Stream<RemoteMessage> get listenNewMessages => FirebaseMessaging.onMessage;

  /// Subscribe to topic in splash.
  ///
  /// [topic] must match the following regular expression:
  /// `[a-zA-Z0-9-_.~%]{1,900}`.
  Future<void> subscribeToTopic(String topic) =>
      _messaging.subscribeToTopic(topic);

  /// Unsubscribe from topic in splash.
  Future<void> unSubscribeToTopic(String topic) =>
      _messaging.unsubscribeFromTopic(topic);

  /// Send a [RemoteMessage] to FCM server. Android Only
  Future<void> sendMessage({
    String? to,
    Map<String, String>? data,
    String? collapseKey,
    String? messageId,
    String? messageType,
    int? ttl,
  }) =>
      _messaging.sendMessage(
        to: to,
        data: data,
        collapseKey: collapseKey,
        messageId: messageId,
        messageType: messageType,
        ttl: ttl,
      );

  /// This is only required when app is running on web, iOS or macOS.
  Future<bool> _requestPermission({
    required bool alert,
    required bool announcement,
    required bool badge,
    required bool carPlay,
    required bool criticalAlert,
    required bool provisional,
    required bool sound,
  }) async {
    // TODO: set provisional to true and handle it, check this url https://firebase.flutter.dev/docs/messaging/permissions/#provisional-authorization, this is for iOS devices only
    NotificationSettings settings = await _messaging.requestPermission(
      alert: alert,
      announcement: announcement,
      badge: badge,
      carPlay: carPlay,
      criticalAlert: criticalAlert,
      provisional: provisional,
      sound: sound,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
