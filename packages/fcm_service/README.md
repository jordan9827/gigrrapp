# fcm_service

A flutter package for firebase cloud messaging.

## Installation

### Android
1. Follow all instruction from this [url](https://firebase.flutter.dev/docs/installation/android) to connect your app with firebase.
2. Add this in AndroidManifest.xml
`
<meta-data
           android:name="com.google.firebase.messaging.default_notification_channel_id"
           android:value="FCM_SERVICE_CLASS" />
`
the value "FCM_SERVICE_CLASS" is the default channel with default priority. If you are creating your own channel, change the value
of android:value to the id of your channel. For reference check this [link](https://firebase.flutter.dev/docs/messaging/notifications#android-configuration)

### iOS
1. Follow this [steps](https://firebase.flutter.dev/docs/installation/ios) to connect your app with firebase.
2. For FCM check this [url](https://firebase.flutter.dev/docs/messaging/apple-integration).
