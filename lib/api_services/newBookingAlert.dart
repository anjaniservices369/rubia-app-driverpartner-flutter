// ----------------------------------------------------------------------
// New booking alert
//
// While the driver is Online and the app is open (foreground or background),
// checks for new Available bookings every 10 seconds, rings noti6x once for
// each new booking and tells the Available Rides list to reload itself.
//
// Developer note: Started and stopped from HomePage.fetchCheckDetails(), next
// to LocationPing. When the app is closed the server push plays noti6x on the
// new_booking_alert channel instead (see PushService).
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class NewBookingAlert
/// Polls `driver/bookings` (status 1 = waiting for a driver) and rings
/// `noti6x` for every booking id it has not seen before.
class NewBookingAlert with WidgetsBindingObserver {
  static const Duration _interval = Duration(seconds: 10);
  static const int _maxRingsPerPoll = 5;

  static final NewBookingAlert _observer = NewBookingAlert._();
  NewBookingAlert._();

  static Timer? _timer;
  static bool _polling = false;
  static bool _seeded = false;
  static final Set<String> _alerted = {};
  static Set<String> _lastIds = {};
  static AudioPlayer? _player;

  /// Bumped whenever the list of available bookings may have changed; the
  /// Available Rides screen listens to this and reloads.
  static final ValueNotifier<int> changes = ValueNotifier<int>(0);

  static bool get isRunning => _timer != null;

  // >>> START  NewBookingAlert.start()
  static void start() {
    if (isRunning) return;
    _seeded = false;
    WidgetsBinding.instance.addObserver(_observer);
    _timer = Timer.periodic(_interval, (_) => pollNow());
    pollNow();
  }
  // <<< END    NewBookingAlert.start()

  // >>> START  NewBookingAlert.stop()
  static void stop() {
    _timer?.cancel();
    _timer = null;
    _seeded = false;
    _alerted.clear();
    _lastIds = {};
    WidgetsBinding.instance.removeObserver(_observer);
  }
  // <<< END    NewBookingAlert.stop()

  // >>> START  NewBookingAlert.didChangeAppLifecycleState()  -  did change app lifecycle state
  /// Checking when the app comes back to the front shows what arrived while
  /// the phone was locked or the app was in the background.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) pollNow();
  }
  // <<< END    NewBookingAlert.didChangeAppLifecycleState()

  /// True when this booking already rang, so a push for it stays silent.
  static bool alreadyAlerted(String? bookingId) =>
      bookingId != null && _alerted.contains(bookingId);

  // >>> START  NewBookingAlert.markAlerted()  -  mark alerted
  /// The push for [bookingId] plays its own sound; remember it so the next
  /// poll does not ring a second time.
  static void markAlerted(String? bookingId) {
    if (bookingId != null && bookingId.isNotEmpty) _alerted.add(bookingId);
  }
  // <<< END    NewBookingAlert.markAlerted()

  // >>> START  NewBookingAlert.pollNow()  -  poll now
  static Future<void> pollNow() async {
    if (!isRunning || _polling) return;
    _polling = true;
    try {
      final ids = await _availableIds();
      if (ids == null) return;

      // First look after going online: these were already waiting, no ring.
      if (!_seeded) {
        _alerted.addAll(ids);
        _lastIds = ids.toSet();
        _seeded = true;
        return;
      }

      final fresh = ids.where((id) => !_alerted.contains(id)).toList();
      _alerted.addAll(fresh);
      // New, taken or expired bookings: the list reloads. Unchanged: it is left alone.
      final current = ids.toSet();
      if (current.length != _lastIds.length || !current.containsAll(_lastIds)) {
        changes.value++;
      }
      _lastIds = current;
      for (final _ in fresh.take(_maxRingsPerPoll)) {
        await _ring();
      }
    } catch (e) {
      print('NewBookingAlert poll error: $e');
    } finally {
      _polling = false;
    }
  }
  // <<< END    NewBookingAlert.pollNow()

  // >>> START  NewBookingAlert._availableIds()  -  available ids
  /// Ids of the bookings waiting for this driver, or null when the server could
  /// not be asked (offline, logged out): nothing is rung or reloaded then.
  static Future<List<String>?> _availableIds() async {
    final prefs = await SharedPreferences.getInstance();
    final authCode = prefs.getString('authCode');
    if (authCode == null || authCode.isEmpty) return null;

    final uri = DRIVER_BOOKINGS + authCode + '&page=0';
    final request = http.MultipartRequest('POST', Uri.parse(apiBaseUrl + uri))
      ..fields['status'] = '1';
    try {
      final response = await request.send().timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return null;
      final json = jsonDecode(await response.stream.bytesToString());
      if (ApiHelper.isSessionInvalid(json, uri: uri)) return null;
      if (json is! Map) return null;
      // NOK = "No Bookings found": an empty list, not an error.
      if (json['status'] != 'OK') return <String>[];
      final details = json['details'];
      if (details is! List) return <String>[];
      return details
          .whereType<Map>()
          .map((b) => b['id']?.toString() ?? '')
          .where((id) => id.isNotEmpty)
          .toList();
    } catch (e) {
      print('NewBookingAlert fetch failed: $e');
      return null;
    }
  }
  // <<< END    NewBookingAlert._availableIds()

  // >>> START  NewBookingAlert._ring()
  /// Plays noti6x once and waits for it to finish, so several new bookings ring
  /// one after another instead of on top of each other.
  static Future<void> _ring() async {
    try {
      _player ??= AudioPlayer();
      await _player!.setReleaseMode(ReleaseMode.release);
      await _player!.play(AssetSource('tones/noti6x.mp3'));
      await _player!.onPlayerComplete.first
          .timeout(const Duration(seconds: 8), onTimeout: () {});
    } catch (e) {
      print('NewBookingAlert ring error: $e');
    }
  }
  // <<< END    NewBookingAlert._ring()
}
// <<< END    class NewBookingAlert
