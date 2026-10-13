import 'dart:convert';

import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Client for the `/api/skipper/...` ride endpoints (contract C2).
///
/// Deliberately does NOT use the central session-expired handler: a partner
/// registered with the `Driver` role gets NOK ("User Not Found") from these
/// endpoints even though their session is valid, and must not be logged out.
class SkipperApi {
  static Future<Map<String, dynamic>?> _post(
      String path, Map<String, String> body,
      {Map<String, String>? query}) async {
    final prefs = await SharedPreferences.getInstance();
    final authCode = prefs.getString('authCode');
    if (authCode == null || authCode.isEmpty) return null;
    try {
      final response = await http
          .post(Uri.parse(apiBaseUrl + path).replace(queryParameters: query),
              headers: {'auth_code': authCode}, body: body)
          .timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return null;
      final json = jsonDecode(response.body);
      return json is Map ? Map<String, dynamic>.from(json) : null;
    } catch (e) {
      print('SkipperApi $path failed: $e');
      return null;
    }
  }

  static bool isOk(Map<String, dynamic>? res) => res?['status'] == 'OK';

  /// Server `error` can be a string or a list of strings.
  static String errorOf(Map<String, dynamic>? res,
      {String fallback = 'Something went wrong. Please try again.'}) {
    final error = res?['error'];
    if (error is List && error.isNotEmpty) return error.join('\n');
    if (error is String && error.isNotEmpty) return error;
    return fallback;
  }

  static Future<Map<String, dynamic>?> updateOnlineStatus(bool online) =>
      // This endpoint reads `status` from the query string, not the body.
      _post(SKIPPER_ONLINE_STATUS, {}, query: {'status': online ? '1' : '0'});

  static Future<Map<String, dynamic>?> updateLatLng(double lat, double lng) =>
      _post(SKIPPER_UPDATE_LAT_LNG,
          {'latitude': lat.toString(), 'longitude': lng.toString()});

  /// `details[]` of open offers; NOK ("No new request Found") when empty.
  static Future<Map<String, dynamic>?> newRequests() =>
      _post(SKIPPER_NEW_REQUEST, {});

  static Future<Map<String, dynamic>?> acceptOrReject(
          String rideRequestId, bool accept) =>
      _post(SKIPPER_ACCEPT_OR_REJECT, {
        'rideRequestId': rideRequestId,
        'status': (accept ? RIDE_ACCEPTED : RIDE_REJECTED).toString(),
      });

  static Future<Map<String, dynamic>?> changeStatus(
      String rideRequestId, int status,
      {double? finalLat, double? finalLng}) {
    return _post(SKIPPER_CHANGE_STATUS, {
      'rideRequestId': rideRequestId,
      'status': status.toString(),
      if (finalLat != null) 'final_lat': finalLat.toString(),
      if (finalLng != null) 'final_lng': finalLng.toString(),
    });
  }

  static Future<Map<String, dynamic>?> verifyRideOtp(
          String rideRequestId, String otp) =>
      _post(SKIPPER_VERIFY_RIDE_OTP, {
        'rideRequestId': rideRequestId,
        'status': RIDE_STARTED.toString(),
        'otp': otp,
      });
}
