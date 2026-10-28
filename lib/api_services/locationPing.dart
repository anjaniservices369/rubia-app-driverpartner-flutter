// ----------------------------------------------------------------------
// Live location reporting
//
// While the driver is Online, reports their position to the server about
// every 20 seconds so the admin map can show them.
//
// Developer note: Posts driver/update-lat-lng; started and stopped from
// HomePage.fetchCheckDetails().
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:convert';

import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class LocationPing
/// Posts the driver's position to `driver/update-lat-lng` so the admin live map
/// (which reads from the backend database) can show the driver.
///
/// The map needs the driver to be online (`driver-status`) AND to have posted a
/// position, so [start] is called while online and [stop] when going offline.
class LocationPing {
  static const Duration interval = Duration(seconds: 20);
  static const Duration _minGap = Duration(seconds: 10);

  static Timer? _timer;
  static DateTime? _lastSent;

  // >>> START  LocationPing.start()
  static void start() {
    stop();
    _pingCurrentPosition();
    _timer = Timer.periodic(interval, (_) => _pingCurrentPosition());
  }
  // <<< END    LocationPing.start()

  // >>> START  LocationPing.stop()
  static void stop() {
    _timer?.cancel();
    _timer = null;
  }
  // <<< END    LocationPing.stop()

  // >>> START  LocationPing._pingCurrentPosition()  -  ping current position
  static Future<void> _pingCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      final sent = await send(position.latitude, position.longitude,
          accuracy: position.accuracy, speedKmh: position.speed * 3.6, recordedAt: position.timestamp);
      if (sent == _Result.noSession) stop();
    } catch (e) {
      print('LocationPing error: $e');
    }
  }
  // <<< END    LocationPing._pingCurrentPosition()

  /// Safe to call from the background-service isolate (no BuildContext/UI);
  /// [handleExpiredSession] must only be true on the main isolate.
  ///
  /// [accuracy] (metres), [speedKmh] and [recordedAt] (when the phone took the reading) let the server's real-time distance tracking
  /// ignore poor or repeated readings and measure the ride correctly; they are optional.
  static Future<_Result> send(double latitude, double longitude,
      {bool handleExpiredSession = true,
      double? accuracy,
      double? speedKmh,
      DateTime? recordedAt}) async {
    final now = DateTime.now();
    if (_lastSent != null && now.difference(_lastSent!) < _minGap) {
      return _Result.throttled;
    }

    final prefs = await SharedPreferences.getInstance();
    final authCode = prefs.getString('authCode');
    if (authCode == null || authCode.isEmpty) return _Result.noSession;

    _lastSent = now;
    final uri = UPDATE_LAT_LONG + authCode;
    final request =
        http.MultipartRequest('POST', Uri.parse(apiBaseUrl + uri))
          ..fields.addAll({
            'latitude': latitude.toString(),
            'longitude': longitude.toString(),
            'locality': prefs.getString('Locality') ?? '',
            if (accuracy != null && accuracy >= 0) 'accuracy': accuracy.toStringAsFixed(1),
            if (speedKmh != null && speedKmh >= 0) 'speed_kmh': speedKmh.toStringAsFixed(1),
            if (recordedAt != null) 'recorded_at': recordedAt.millisecondsSinceEpoch.toString(),
          });
    try {
      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode != 200) return _Result.failed;

      final json = jsonDecode(body);
      if (ApiHelper.isSessionInvalid(json, uri: uri)) {
        if (handleExpiredSession) await ApiHelper.handleSessionExpired();
        return _Result.noSession;
      }
      return json is Map && json['status'] == 'OK'
          ? _Result.ok
          : _Result.failed;
    } catch (e) {
      print('LocationPing send failed: $e');
      return _Result.failed;
    }
  }
}
// <<< END    class LocationPing

// >>> START  class _Result
enum _Result { ok, failed, throttled, noSession }
// <<< END    class _Result
