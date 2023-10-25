import 'dart:io';
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  //Send OTP
  sendOtp(BuildContext context, Map<String, String> param) async {
    var url = SEND_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

  //Verify OTP
  verifyOtp(BuildContext context, Map<String, String> param) async {
    var url = VERIFY_OTP;
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

  //Check API
  checkApi(String authCode) async {
    var client = http.Client();
    var url = apiBaseUrl + CHECK_API + authCode;
    var jsonMap;
    try {
      var response = await client.get(Uri.parse(url));
      print(response);
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

  getUpdateLatLong(BuildContext context, String latitude, String longitude) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_LAT_LONG + headers['auth_code'];
    Map<String, String> params = {'latitude': latitude, 'longitude': longitude};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  checkDelivery(BuildContext context, String pincode) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CHECK_DELIVERY_ADDRESS + headers['auth_code'];
    Map<String, String> params = {'pin_code': pincode};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  addReferralCode(BuildContext context, String referalCode) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REFERAL + headers['auth_code'];
    Map<String, String> params = {'referal_code': referalCode};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  Startodometer(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = STARTING_ODOMETER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

  Endodometer(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ENDING_ODOMETER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

  logout(BuildContext context) async {
    var response;
    var jsonMap;
    var url;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var authCode = sharedPreferences.getString('authCode');
    var headers = await ApiHelper().getHeader(context);
    url = LOGOUT + headers['auth_code'];
    print(url);
    jsonMap = await ApiHelper().getTypeGet(context, url);
    response = jsonMap;
    await sharedPreferences.clear();
    sharedPreferences.remove(authCode!);
    return response;
  }

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
    print(response);
    return response;
  }

  getClearNotifaction(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = NOTIFICATION_CLEAR + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    var response = jsonMap;
    print(response);
    return response;
  }
}
