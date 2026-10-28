// ----------------------------------------------------------------------
// Server request helper
//
// The single place every request to the Rubia server goes through. It also
// notices when the server says the driver's login has expired and sends them
// back to the login screen.
//
// Developer note: Session-expiry rule: HTTP 200 + status NOK +
// 'User/Session/Auth code not found'. See isSessionInvalid() /
// handleSessionExpired().
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:io';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base_project_flutter/api_services/offerService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class ApiHelper
/// Sends requests to the Rubia server and reacts when the driver's login has expired.
/// Use [getTypePost] / [getTypeGet]; never call `http` directly for authenticated endpoints.
class ApiHelper {
  /// How long to wait for the server before giving up (stops buttons spinning forever).
  static const Duration _requestTimeout = Duration(seconds: 30);

  /// How long a successful session check is trusted before `getHeader` asks again.
  static const Duration _sessionCheckEvery = Duration(seconds: 30);
  static DateTime? _lastSessionCheck;

  static bool _isNetworkProblem(Object e) =>
      e is SocketException ||
      e is TimeoutException ||
      e is HandshakeException ||
      e is http.ClientException;

  // >>> START  ApiHelper._networkError()  -  network error
  /// What callers receive when the phone cannot reach the server. It has the same shape as
  /// a server NOK, so every screen's existing `res['error']` handling just works and no
  /// loading button is left spinning.
  static Map<String, dynamic> _networkError(BuildContext context) {
    try {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Check Internet')));
    } catch (_) {}
    return {'status': 'NOK', 'error': 'Check Internet', 'network_error': true};
  }
  // <<< END    ApiHelper._networkError()

  /// The backend answers an invalid/expired/revoked `auth_code` with HTTP 200
  /// and `{status: NOK, error: <string | list of strings>}` (never 401).
  static const _sessionErrors = [
    'user not found',
    'session not found',
    'auth code not found',
  ];

  static bool _redirectingToLogin = false;

  /// True when [uri]/[params] carried an `auth_code` and [response] is one of
  /// the "session is gone" NOK answers.
  static bool isSessionInvalid(dynamic response,
      {String uri = '', Map<String, String>? params}) {
    final carriedAuth = uri.contains('auth_code') ||
        (params?.containsKey('auth_code') ?? false);
    if (!carriedAuth || response is! Map) return false;
    if (response['status'] != 'NOK') return false;

    final error = response['error'];
    final messages = error is List ? error : [error];
    return messages.any((m) =>
        m is String && _sessionErrors.contains(m.trim().toLowerCase()));
  }

  // >>> START  ApiHelper.handleSessionExpired()  -  handle session expired
  /// Drops the stored session and sends the driver to the phone + OTP login.
  static Future<void> handleSessionExpired() async {
    if (_redirectingToLogin) return;
    _redirectingToLogin = true;
    try {
      OfferService.stop(notifyOffline: false);
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code');
      await prefs.clear();
      if (languageCode != null) {
        await prefs.setString('language_code', languageCode);
      }
      Get.offAll(() => LoginPageView());
    } finally {
      _redirectingToLogin = false;
    }
  }
  // <<< END    ApiHelper.handleSessionExpired()

  // >>> START  ApiHelper.getTypePost()  -  get type post
  //All Post type request will handle here
  getTypePost(
      BuildContext context, String uri, Map<String, String> params) async {
    String jsonResponse;
    var url = apiBaseUrl + uri;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(params);
    try {
      http.StreamedResponse response =
          await request.send().timeout(_requestTimeout);

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();

        jsonResponse = value.toString();

        var jsonMap = json.decode(jsonResponse);

        if (isSessionInvalid(jsonMap, uri: uri, params: params)) {
          await handleSessionExpired();
        }
        return jsonMap;
      } else {
        Twl.errorHandler(context, response.statusCode);
        print(response.reasonPhrase);
      }
    } on Exception catch (e) {
      if (!_isNetworkProblem(e)) rethrow;
      return _networkError(context);
    }
  }
  // <<< END    ApiHelper.getTypePost()

  // >>> START  ApiHelper.getTypeGet()  -  get type get
  //All Get type request will handle here
  getTypeGet(BuildContext context, String uri) async {
    var client = http.Client();
    var jsonMap;
    try {
      var response =
          await client.get(Uri.parse(apiBaseUrl + uri)).timeout(_requestTimeout);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonMap = json.decode(jsonString);

        if (isSessionInvalid(jsonMap, uri: uri)) {
          await handleSessionExpired();
        }
        return jsonMap;
      } else {
        Twl.errorHandler(context, response.statusCode);
      }
    } on Exception catch (e) {
      if (_isNetworkProblem(e)) return _networkError(context);
      return jsonMap;
    }
  }
  // <<< END    ApiHelper.getTypeGet()

  // >>> START  ApiHelper.getHeader()  -  get header
  getHeader(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Opaque JWT-style string; stored and sent unchanged.
    final String authCode = sharedPreferences.getString('authCode') ?? '1';

    // Validate the session at most once per _sessionCheckEvery instead of before every
    // request (this used to be about six `check` calls per screen).
    final now = DateTime.now();
    if (_lastSessionCheck == null ||
        now.difference(_lastSessionCheck!) > _sessionCheckEvery) {
      _lastSessionCheck = now;
      var res = await UserAPI().checkApi(authCode);
      if (isSessionInvalid(res, uri: 'auth_code')) {
        _lastSessionCheck = null;
        await handleSessionExpired();
      }
    }

    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Connection': 'keep-alive',
      'Accept': ' application/json',
      'Accept-Encoding': 'gzip, deflate, br',
      'auth_code': authCode,
    };
  }
  // <<< END    ApiHelper.getHeader()

  // >>> START  ApiHelper.checkLogin()  -  check login
  static checkLogin(BuildContext context, authCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String storedAuthCode = sharedPreferences.getString('authCode') ?? '1';
    var res = await UserAPI().checkApi(storedAuthCode);

    if (res != null && res['status'] == "OK") {
      return 1;
    } else {
      Twl.navigateTo(context, LoginPageView());
      Twl.createAlert(context, 'message', 'session not found please login');
    }
  }
  // <<< END    ApiHelper.checkLogin()
}
// <<< END    class ApiHelper
