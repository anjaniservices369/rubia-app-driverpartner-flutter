import 'dart:io';
import 'package:base_project_flutter/Constants/apiConstants.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/logiPage/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  //All Post type request will handle here
  getTypePost(
      BuildContext context, String uri, Map<String, String> params) async {
    String jsonResponse;
    var url = apiBaseUrl + uri;
    print(url);
    print("params>>>>>"+params.toString());

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(params);
    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var value = await response.stream.bytesToString();
       
        jsonResponse = value.toString();

        var jsonMap = json.decode(jsonResponse);
        // print(jsonMap);

        return jsonMap;
      } else {
        Twl.errorHandler(context, response.statusCode);
        print(response.reasonPhrase);
      }
    } on SocketException {
      print("error");
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
    late String authCode;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    authCode = sharedPreferences.getString('authCode')!;
    if (authCode != null) {
      authCode = authCode;
    } else {
      authCode = '1';
    }
    try {
      var res = await UserAPI().checkApi(authCode);
      print('API Authcode');
      print(authCode);
      print(res);
      if (res != null || res['status'] == "OK") {
        // print(res);
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
    late String authCode;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    authCode = sharedPreferences.getString('authCode')!;
    if (authCode != null) {
      authCode = authCode;
    } else {
      authCode = '1';
    }
    var res = await UserAPI().checkApi(authCode);

    print(authCode);
    print(res);
    if (res != null && res['status'] == "OK") {
      return 1;
    } else {
      Twl.navigateTo(context, LoginPageView());
      Twl.createAlert(context, 'message', 'session not found please login');
    }
  }
}
