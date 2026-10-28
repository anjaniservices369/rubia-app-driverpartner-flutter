// ----------------------------------------------------------------------
// Account & login requests
//
// Requests about the driver's account: send/verify the SMS code, check the
// session, log out, notifications, location updates, odometer, push device
// token.
// ----------------------------------------------------------------------
import 'dart:io';
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class UserAPI
/// Account-level server calls: OTP login, session check, logout, notifications, location.
class UserAPI {
  // >>> START  UserAPI.sendOtp()  -  send otp
  //Send OTP
  sendOtp(BuildContext context, Map<String, String> param) async {
    var url = SEND_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }
  // <<< END    UserAPI.sendOtp()

  // >>> START  UserAPI.verifyOtp()  -  verify otp
  //Verify OTP
  verifyOtp(BuildContext context, Map<String, String> param) async {
    var url = VERIFY_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }
  // <<< END    UserAPI.verifyOtp()

  // >>> START  UserAPI.checkApi()  -  check api
  //Check API
  checkApi(String authCode) async {
    var client = http.Client();
    var url = apiBaseUrl + CHECK_API + authCode;
    var jsonMap;
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        jsonMap = json.decode(jsonString);
        return jsonMap;
      } else {
        print(response.statusCode);
      }
    } on SocketException {
      print("error");
    } catch (exception) {
      return jsonMap;
    }
  }
  // <<< END    UserAPI.checkApi()

  // >>> START  UserAPI.updateDeviceToken()  -  update device token
  /// Push provider id (OneSignal subscription id / ExponentPushToken) changed
  /// or became available after login. Same field names as before the backend
  /// moved to OneSignal; see `verifyOtp` for the login-time value.
  updateDeviceToken(BuildContext context, String deviceToken) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CHECK_API + headers['auth_code'];
    Map<String, String> params = {'AuthSession[device_token]': deviceToken};
    return await ApiHelper().getTypePost(context, url, params);
  }
  // <<< END    UserAPI.updateDeviceToken()

  // >>> START  UserAPI.getUpdateLatLong()  -  get update lat long
  getUpdateLatLong(BuildContext context, String latitude, String longitude, String locality) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_LAT_LONG + headers['auth_code'];
    Map<String, String> params = {'latitude': latitude, 'longitude': longitude, 'locality':locality};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    UserAPI.getUpdateLatLong()

  // >>> START  UserAPI.checkDelivery()  -  check delivery
  checkDelivery(BuildContext context, String pincode) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CHECK_DELIVERY_ADDRESS + headers['auth_code'];
    Map<String, String> params = {'pin_code': pincode};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    UserAPI.checkDelivery()

  // >>> START  UserAPI.addReferralCode()  -  add referral code
  addReferralCode(BuildContext context, String referalCode) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REFERAL + headers['auth_code'];
    Map<String, String> params = {'referal_code': referalCode};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    UserAPI.addReferralCode()

  // >>> START  UserAPI.Startodometer()
  Startodometer(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = STARTING_ODOMETER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }
  // <<< END    UserAPI.Startodometer()

  // >>> START  UserAPI.Endodometer()
  Endodometer(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ENDING_ODOMETER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }
  // <<< END    UserAPI.Endodometer()

  // >>> START  UserAPI.deleteAccount()  -  delete account
  deleteAccount(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    return await ApiHelper().getTypePost(context, DELETE_ACCOUNT + headers['auth_code'], {'reason': 'in-app'});
  }
  // <<< END    UserAPI.deleteAccount()

  // >>> START  UserAPI.logout()
  logout(BuildContext context) async {
    var response;
    var jsonMap;
    var url;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var authCode = sharedPreferences.getString('authCode');
    var headers = await ApiHelper().getHeader(context);
    url = LOGOUT + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    await sharedPreferences.clear();
    sharedPreferences.remove(authCode!);
    return response;
  }
  // <<< END    UserAPI.logout()

  // >>> START  UserAPI.getMyNotifaction()  -  get my notifaction
  Future<dynamic> getMyNotifaction(
    BuildContext context,
    String page,
  ) async {
    var headers = await ApiHelper().getHeader(context);
    var uri = NOTIFICATION + headers['auth_code'] + '&page=' + page;
    // Map<String, String> params = param;
    var response = await ApiHelper().getTypeGet(
      context,
      uri,
    );
    //print(response);
    return response;
  }
  // <<< END    UserAPI.getMyNotifaction()

  // >>> START  UserAPI.getClearNotifaction()  -  get clear notifaction
  getClearNotifaction(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = NOTIFICATION_CLEAR + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    var response = jsonMap;
    print(response);
    return response;
  }
  // <<< END    UserAPI.getClearNotifaction()

  // >>> START  UserAPI.sendLocation()  -  send location
  sendLocation(
      BuildContext context,
      Map<String, String> param,
      ) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CURRENT_CITY + headers['auth_code'];

    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    UserAPI.sendLocation()
}
// <<< END    class UserAPI
