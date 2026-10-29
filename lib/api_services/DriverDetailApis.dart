// ----------------------------------------------------------------------
// Driver profile, documents & money requests
//
// Requests about the driver's profile: registration steps, vehicle types,
// documents, bank details, online/offline status, joining fee, wallet and
// subscription plans.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/cupertino.dart';

// >>> START  class DriverDetailsApi
/// Driver profile & money server calls: registration data, documents, online status, wallet, plans.
class DriverDetailsApi {
  // >>> START  DriverDetailsApi.getDriverVehicleTypes()  -  get driver vehicle types
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
  // <<< END    DriverDetailsApi.getDriverVehicleTypes()

  // >>> START  DriverDetailsApi.addVehicleType()  -  add vehicle type
  //vehicle type add
  addVehicleType(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = VEHICLE_TYPE_ADD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.addVehicleType()

  // >>> START  DriverDetailsApi.updateProfileAPi()  -  update profile api
  //Add personal details
  updateProfileAPi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPDATE_PROFILE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.updateProfileAPi()

  // >>> START  DriverDetailsApi.uploadProfileImageApi()  -  upload profile image api
  //Add profile image
  uploadProfileImageApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_PROFILE_IMAGE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.uploadProfileImageApi()

  // >>> START  DriverDetailsApi.uploadDrivingLicenceApi()  -  upload driving licence api
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
  // <<< END    DriverDetailsApi.uploadDrivingLicenceApi()

  // >>> START  DriverDetailsApi.uploadAadharCardApi()  -  upload aadhar card api
  //Add aadhar card
  uploadAadharCardApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_AADHAR_CARD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.uploadAadharCardApi()

  // >>> START  DriverDetailsApi.uploadPanCardApi()  -  upload pan card api
  //Add pan card
  uploadPanCardApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = UPLOAD_PAN_CARD + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.uploadPanCardApi()

  // >>> START  DriverDetailsApi.policeVerificationAPi()  -  police verification api
  //police verification
  policeVerificationAPi(BuildContext context) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = POLICE_VERIFICATION + headers['auth_code'];
    jsonMap = await ApiHelper().getTypeGet(context, uri);
    print(jsonMap);
    return jsonMap;
  }
  // <<< END    DriverDetailsApi.policeVerificationAPi()

  // >>> START  DriverDetailsApi.addEmergencyContactAPi()  -  add emergency contact api
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
  // <<< END    DriverDetailsApi.addEmergencyContactAPi()

  // >>> START  DriverDetailsApi.addDriverBankDetails()  -  add driver bank details
  //Add Driver BankDetails
  addDriverBankDetails(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_DRIVER_BANK_DETAILS + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.addDriverBankDetails()

  // >>> START  DriverDetailsApi.fetchOnlineStatusDriver()  -  fetch online status driver
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
  // <<< END    DriverDetailsApi.fetchOnlineStatusDriver()

  // >>> START  DriverDetailsApi.fetchJoiningFeeStatus()  -  fetch joining fee status
  //Pay Joining fee
  fetchJoiningFeeStatus(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = PAY_JOINING_FEE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.fetchJoiningFeeStatus()

  // >>> START  DriverDetailsApi.createOrderApi()  -  create order api
  // Paymentgate way Apis
  createOrderApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CREATE_ORDER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.createOrderApi()

  // >>> START  DriverDetailsApi.createRazorpayOrderApi()  -  create razorpay order api
  // purpose is joining_fee | subscription | wallet_topup; the server fixes the price except for a top-up (amount).
  createRazorpayOrderApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = RAZORPAY_CREATE_ORDER + headers['auth_code'];
    var response = await ApiHelper().getTypePost(context, url, param);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.createRazorpayOrderApi()

  // >>> START  DriverDetailsApi.createCashfreeOrderApi()  -  create cashfree order api
  // OK: details = order_id, payment_session_id, mode (sandbox | production), amount.
  createCashfreeOrderApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CASHFREE_CREATE_ORDER + headers['auth_code'];
    var response = await ApiHelper().getTypePost(context, url, param);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.createCashfreeOrderApi()

  // >>> START  DriverDetailsApi.createSubscriptionOrderApi()  -  create subscription order api
  createSubscriptionOrderApi(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CREATE_ORDER + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.createSubscriptionOrderApi()

  // >>> START  DriverDetailsApi.getDriverSubscription()  -  get driver subscription
  //Subscription Apis
  getDriverSubscription(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_SUSCRIPTION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.getDriverSubscription()

  // >>> START  DriverDetailsApi.getDriverPlans()  -  get driver plans
  getDriverPlans(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_PLAN_DETAILS + headers['auth_code'];
    print(url);
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
  // <<< END    DriverDetailsApi.getDriverPlans()
}
// <<< END    class DriverDetailsApi
