// ----------------------------------------------------------------------
// Push notifications (OneSignal)
//
// Sets up push notifications so the driver is alerted about new bookings,
// and tells the server which phone to notify.
//
// Developer note: Needs oneSignalAppId; the Android FCM credentials live in
// the OneSignal dashboard. Subscription id = device_token.
// ----------------------------------------------------------------------
import 'dart:async';

import 'package:base_project_flutter/api_services/newBookingAlert.dart';
import 'package:base_project_flutter/api_services/offerService.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class PushService
/// Provider-neutral push entry point for the app. The backend sends through
/// OneSignal; the `device_token` it needs is the OneSignal *subscription id*.
///
/// Notification data keys sent by the server: `order_id`, `type`, and for
/// custom notifications `url`, `img_url` (all strings).
class PushService {
  // Channels are created in main.dart.
  static const String _newBookingChannelId = 'new_booking_alert';
  static const String _newBookingChannelName = 'New Booking Alert';
  static const String _otherChannelId = 'other_high_importance_channel';
  static const String _otherChannelName = 'Other High Importance Notifications';

  static final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  static bool _initialised = false;

  /// Current push id, or null if the SDK has not registered yet.
  static String? get subscriptionId =>
      _initialised ? OneSignal.User.pushSubscription.id : null;

  // >>> START  PushService.init()
  static Future<void> init() async {
    if (_initialised || kIsWeb) return;
    if (oneSignalAppId.isEmpty) {
      print('PushService: oneSignalAppId is empty, push disabled');
      return;
    }

    OneSignal.initialize(oneSignalAppId);
    _initialised = true;
    // Do not await: main() calls init() before runApp, so waiting for the
    // user's answer left a blank screen behind the permission dialog.
    OneSignal.Notifications.requestPermission(true);

    // App is open: show it ourselves so the booking alert keeps its sound.
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.preventDefault();
      final data = event.notification.additionalData;
      final bookingId = data?['order_id']?.toString();
      // A booking the poller already rang for stays silent here, so the driver
      // hears noti6x once per booking, not twice.
      final silent = NewBookingAlert.alreadyAlerted(bookingId);
      _showLocal(event.notification, silent: silent);
      if (_isNewBooking(event.notification)) {
        NewBookingAlert.markAlerted(bookingId);
        // Load it into Available Rides right away, without a refresh.
        NewBookingAlert.pollNow();
      }
      // Ride offer: show the accept/reject dialog right away.
      if (data?['type']?.toString() == 'newOrder') {
        OfferService.pollNow();
      }
    });

    // The id appears after registration and can change; keep the server current.
    OneSignal.User.pushSubscription.addObserver((state) {
      final id = state.current.id;
      if (id != null && id.isNotEmpty) _syncToken(id);
    });
  }
  // <<< END    PushService.init()

  /// Used at login (`verify-otp`), where the id may not exist yet.
  static Future<String?> waitForSubscriptionId(
      {Duration timeout = const Duration(seconds: 5)}) async {
    final deadline = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(deadline)) {
      final id = subscriptionId;
      if (id != null && id.isNotEmpty) return id;
      await Future.delayed(const Duration(milliseconds: 250));
    }
    return subscriptionId;
  }

  // >>> START  PushService._syncToken()  -  sync token
  static Future<void> _syncToken(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final context = Get.context;
      // Not logged in yet: verify-otp will send the id instead.
      if (context == null || (prefs.getString('authCode') ?? '').isEmpty) {
        return;
      }
      await UserAPI().updateDeviceToken(context, id);
    } catch (e) {
      print('PushService: token sync failed: $e');
    }
  }
  // <<< END    PushService._syncToken()

  /// Server sends data `type=newOrder` (+ `order_id`) for ride offers; the
  /// Driver service sends the title 'New Booking'.
  static bool _isNewBooking(OSNotification n) =>
      n.additionalData?['type']?.toString() == 'newOrder' ||
      n.title == 'New Booking';

  static Future<void> _showLocal(OSNotification n,
      {bool silent = false}) async {
    final isNewBooking = _isNewBooking(n);
    final details = AndroidNotificationDetails(
      isNewBooking ? _newBookingChannelId : _otherChannelId,
      isNewBooking ? _newBookingChannelName : _otherChannelName,
      channelDescription: 'your other channel description',
      icon: '@mipmap/ic_launcher',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      playSound: !silent,
      sound: RawResourceAndroidNotificationSound(
          isNewBooking ? 'noti6x' : 'music'),
    );
    await _local.show(
      n.notificationId.hashCode,
      n.title,
      n.body,
      NotificationDetails(android: details),
    );
  }
}
// <<< END    class PushService
