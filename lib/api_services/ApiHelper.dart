import 'dart:io';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
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

  /// Drops the stored session and sends the driver to the phone + OTP login.
  static Future<void> handleSessionExpired() async {
    if (_redirectingToLogin) return;
    _redirectingToLogin = true;
    try {
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

  //All Post type request will handle here
  getTypePost(
      BuildContext context, String uri, Map<String, String> params) async {
    String jsonResponse;
    var url = apiBaseUrl + uri;
    print(url);
    print("params>>>>>" + params.toString());

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(params);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();

        jsonResponse = value.toString();

        var jsonMap = json.decode(jsonResponse);
         print(jsonMap);

        if (isSessionInvalid(jsonMap, uri: uri, params: params)) {
          await handleSessionExpired();
        }
        return jsonMap;
      } else {
        Twl.errorHandler(context, response.statusCode);
        print(response.reasonPhrase);
      }
    } on SocketException {
      //print("error");
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Check Internet'),
      ));
      // Twl.createAlert(context,'dfd','dfdfd');
    }
  }

  //All Get type request will handle here
  getTypeGet(BuildContext context, String uri) async {
    var client = http.Client();
    var jsonMap;
    try {
      var response = await client.get(Uri.parse(apiBaseUrl + uri));
      print(apiBaseUrl + uri);
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
    } on SocketException {
      print("error");
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Check Internet'),
      ));
    } catch (Exception) {
      return jsonMap;
    }
  }

  getHeader(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Opaque JWT-style string; stored and sent unchanged.
    final String authCode = sharedPreferences.getString('authCode') ?? '1';
    try {
      var res = await UserAPI().checkApi(authCode);
      if (isSessionInvalid(res, uri: 'auth_code')) {
        await handleSessionExpired();
      }
      //print('API Authcode');
      //print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      //print(authCode);
      //print(res);
      if (res != null || res['status'] == "OK") {
        // //print(res);
        return {
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Accept': ' application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'auth_code': authCode,
        };
      } else {
        return {
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Accept': ' application/json',
          'Accept-Encoding': 'gzip, deflate, br',
          'auth_code': '1',
        };
      }
    } on SocketException {
      throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Check Internet'),
      ));
      // Twl.createAlert(context,'dfd','dfdfd');
    }
  }

  static checkLogin(BuildContext context, authCode) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final String storedAuthCode = sharedPreferences.getString('authCode') ?? '1';
    var res = await UserAPI().checkApi(storedAuthCode);

    //print(authCode);
    //print(res);
    if (res != null && res['status'] == "OK") {
      return 1;
    } else {
      Twl.navigateTo(context, LoginPageView());
      Twl.createAlert(context, 'message', 'session not found please login');
    }
  }
}
