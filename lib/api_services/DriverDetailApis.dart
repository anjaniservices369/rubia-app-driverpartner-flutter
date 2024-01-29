import 'dart:io';
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverDetailsApi {
  //driver/vehicle-types
  Future<dynamic> getDriverVehicleTypes(BuildContext context, String type) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = VEHICLE_TYPES + headers['auth_code'];
    print(uri);
    Map<String, String> params = {'type': type};
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    var response = jsonMap;
    print(response);
    return response;
  }

  //vehicle type add
  addVehicleType(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = VEHICLE_TYPE_ADD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add personal details
  updateProfileAPi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_PROFILE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add profile image
  uploadProfileImageApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_PROFILE_IMAGE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add driving liciense
  uploadDrivingLicenceApi(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_DRIVING_LICENSE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add aadhar card
  uploadAadharCardApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_AADHAR_CARD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add pan card
  uploadPanCardApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_PAN_CARD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //police verification
  policeVerificationAPi(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = POLICE_VERIFICATION + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    print(jsonMap);
    return jsonMap;
  }

  //Add emergency contacts
  addEmergencyContactAPi(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_DRIVER_EMERGENCY_CONTACT + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Add Driver BankDetails
  addDriverBankDetails(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_DRIVER_BANK_DETAILS + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Driver online status Update
  fetchOnlineStatusDriver(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DIRVER_ONLINE_STATUS + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Pay Joining fee
  fetchJoiningFeeStatus(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = PAY_JOINING_FEE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  // Paymentgate way Apis
  createOrderApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CREATE_ORDER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  createSubscriptionOrderApi(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CREATE_ORDER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Subscription Apis
  getDriverSubscription(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_SUSCRIPTION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  getDriverPlans(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_PLAN_DETAILS + headers['auth_code'];
    print(url);
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
}
