// ----------------------------------------------------------------------
// Local notification helper
//
// Helper for creating Android notification channels and showing on-device
// notifications (e.g. the tracking notification).
// ----------------------------------------------------------------------
// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// >>> START  class NotificationService
/// Creates notification channels and shows on-device notifications.
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(
    this.flutterLocalNotificationsPlugin,
  );

  // >>> START  NotificationService.createChannel()  -  create channel
  Future<void> createChannel(
      AndroidNotificationChannel notificationChannel) async {
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(notificationChannel);
  }
  // <<< END    NotificationService.createChannel()

  // >>> START  NotificationService.foregroundNotificationTap()  -  foreground notification tap
  void foregroundNotificationTap(NotificationResponse details) {
    print("*******************LOCAL FOREGROUND RECEIVED 1********************");
  }
  // <<< END    NotificationService.foregroundNotificationTap()

  // >>> START  NotificationService.pragma()
  @pragma('vm:entry-point')
  static void backgroundNotificationTap(NotificationResponse details) {
    print("*******************LOCAL BACKGROUND RECEIVED 2********************");
  }
  // <<< END    NotificationService.pragma()

  // >>> START  NotificationService.initialize()
  Future initialize(BuildContext context) async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings(
            "@mipmap/ic_launcher"); //'@mipmap/ic_launcher'

    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: foregroundNotificationTap,
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationTap,
    );
  }
  // <<< END    NotificationService.initialize()

  Future showNotification({
    int showNotificationId = 0,
    required AndroidNotificationDetails androidNotificationDetails,
    //
    String? title,
    String? body,
    String? payload,

  }) async {
    //Demo
    //  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    //   channelId,
    //   channelName,
    //   channelDescription: channelDescription,
    //   playSound: false,
    //   importance: Importance.max,
    //   priority: Priority.high,
    // );

    var platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);



    await flutterLocalNotificationsPlugin.show(
      showNotificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }
}
// <<< END    class NotificationService
