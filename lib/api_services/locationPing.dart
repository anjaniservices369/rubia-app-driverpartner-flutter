import 'dart:async';
import 'dart:convert';

import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Posts the driver's position to `driver/update-lat-lng` so the admin live map
/// (which now reads from the backend DB, not Firebase) can show the driver.
///
/// The map needs the driver to be online (`driver-status`) AND to have posted a
/// position, so [start] is called while online and [stop] when going offline.
class LocationPing {
  static const Duration interval = Duration(seconds: 20);
  static const Duration _minGap = Duration(seconds: 10);

  static Timer? _timer;
  static DateTime? _lastSent;

  static void start() {
    stop();
    _pingCurrentPosition();
    _timer = Timer.periodic(interval, (_) => _pingCurrentPosition());
  }

  static void stop() {
    _timer?.cancel();
    _timer = null;
  }

  static Future<void> _pingCurrentPosition() async {
    try {
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }
      final position = await Geolocator.getCurrentPosition();
      final sent = await send(position.latitude, position.longitude);
      if (sent == _Result.noSession) stop();
    } catch (e) {
      print('LocationPing error: $e');
    }
  }

  /// Safe to call from the background-service isolate (no BuildContext/UI);
  /// [handleExpiredSession] must only be true on the main isolate.
  static Future<_Result> send(double latitude, double longitude,
      {bool handleExpiredSession = true}) async {
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

enum _Result { ok, failed, throttled, noSession }
