import 'package:fcm_service/fcm_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../app/app.logger.dart';
import '../../others/constants.dart';

final log = getLogger('fcm_notification_handler');

Future<void> handleNotification(
  RemoteMessage message,
  bool fromBackground,
) async {
  log.i("FCM data ---> ${message.data}");
  if (message.data['gigs_id'] != null) {
    await scheduleNotification(
        message: message, module: message.data['gigs_id']);
  } else {
    await scheduleNotification(message: message, module: "");
  }
}

Future<void> scheduleNotification(
    {required RemoteMessage message, required String module}) async {
  print("FCM Module ::: $module");
  final fcmService = await FCMService.getInstance();

  final data = message.data;
  try {
    await fcmService.showNotification(
      id: DateTime.now().hashCode,
      title: data["title"],
      body: data["message"],
      payload: module,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          priority: Priority.high,
          importance: Importance.high,
          NOTIFICATION_CHANNEL_ID,
          NOTIFICATION_CHANNEL_DESCRIPTION,
          groupKey: module,
          styleInformation: BigTextStyleInformation(data['message']),
        ),
        iOS: IOSNotificationDetails(
          threadIdentifier: module,
        ),
      ),
    );
  } catch (e, stackTrace) {
    await FirebaseCrashlytics.instance.recordError(e, stackTrace);
  }
}
