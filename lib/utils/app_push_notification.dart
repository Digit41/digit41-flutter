import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class AppFCMPushNotification {
  /// Instantiate Firebase Messaging
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  /// Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel? channel;

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  Future initializeFcm() async {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    if (GetPlatform.isAndroid) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        'This channel is used for important notifications.',
        importance: Importance.high,
      );
    }

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// Foreground message
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null && !GetPlatform.isWeb) {
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel!.id,
                  channel!.name,
                  channel!.description,
                  // icon: 'launch_background',
                ),
              ),
            );
          }
        },
      );
    } else {
      print('User declined or has not accepted permission');
    }
  }

  /// Get firebase cloud messaging token
  Future<String> getFCMToken() async {
    String? fcmToken = await _messaging.getToken();
    if (fcmToken != null)
      return fcmToken;
    else
      return ' ';
  }
}
