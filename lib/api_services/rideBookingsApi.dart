import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/models/TransactionListModel.dart';
import 'package:base_project_flutter/views/bookings/bookings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class RideBookingsApi {
  //Driver Booking Apis
  Future<dynamic> fetchBookingsList(
      BuildContext context, String page, String status) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = DRIVER_BOOKINGS + headers['auth_code'] + '&page=' + page;
    print(uri);
    Map<String, String> params = {'status': status};
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    var response = jsonMap;
    print(response);
    return response;
  }
  // Driver Earnings Api

  fetchEarningsList(
    BuildContext context,
    String page,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    endDate = DateTime.now().add(Duration(days: 1));
    startDate = formatter.format(now);
    startDate = sharedPreferences.getString('startDate') != null
        ? sharedPreferences.getString('startDate')
        : startDate;
    endDate = sharedPreferences.getString('endDate') != null
        ? sharedPreferences.getString('endDate')
        : endDate;
    var endFormatter = new DateFormat('yyyy-MM-dd 23:59:59');
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_EARNINGS + headers['auth_code'] + '&page=' + page;
    Map<String, String> params = {
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//DriverBookingDetails
  Future<dynamic> fetchBookigDetails(
      BuildContext context, String bookingId) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = BOOKING_DETAILS + headers['auth_code'];
    print(uri);
    Map<String, String> params = {'booking_id': bookingId};
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    return jsonMap;
  }

  // Earnings dashboard
  Future<dynamic> fetchEarningsDashboard(
    BuildContext context,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    endDate = DateTime.now().add(Duration(days: 1));
    startDate = formatter.format(now);
    startDate = sharedPreferences.getString('startDate') != null
        ? sharedPreferences.getString('startDate')
        : startDate;
    endDate = sharedPreferences.getString('endDate') != null
        ? sharedPreferences.getString('endDate')
        : endDate;
    var endFormatter = new DateFormat('yyyy-MM-dd 23:59:59');
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = MY_EARNINGS_DASHBOARD + headers['auth_code'];
    print(uri);
    Map<String, String> params = {
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    return jsonMap;
  }

  //Accept Ride
  acceptRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ACCEPT_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //reject ride
  rejectRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REJECT_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//ridePickup APis
  fetchDriverRidePickUp(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = RIDE_PICK_UP + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//Arrived Location
  getDriverArrivedLocation(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_ARRIVED_LOCATION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
//Vehicle Verification

  getVehicleVerficationDetails(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = VEHICLE_VERIRIFICATION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Rating and Reviews APis
  Future<dynamic> fetchDriverReviws(BuildContext context, String page) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = DRIVER_RATINGS_REVIEWS + headers['auth_code'];
    print(uri);
    Map<String, String> params = {'page': page};
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    var response = jsonMap;
    print(response);
    return response;
  }

  //Add Rating and Reviews APi
  getAddReviewsAndRatings(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_RATINGS_REVIEWS + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }

//Start Ride
  getStartRideAPi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = START_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //complete ride
  completeRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = COMPLETE_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Booking history Api

  fetchBookingHistory(
    BuildContext context,
    String page,
    String status,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    var endFormatter = new DateFormat('yyyy-MM-dd 23:59:59');
    endDate = endFormatter.format(now);
    startDate = formatter.format(now);
    startDate = sharedPreferences.getString('startDate') != null
        ? sharedPreferences.getString('startDate')
        : startDate;
    endDate = sharedPreferences.getString('endDate') != null
        ? sharedPreferences.getString('endDate')
        : endDate;
    var headers = await ApiHelper().getHeader(context);
    var url = BOOKING_HISTORY + headers['auth_code'] + '&page=' + page;
    Map<String, String> params = {
      'status': status,
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  //Wallet apis

  getAddMoneyWallet(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_BALANCE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

//TRANSACTION LIST

  walletTransactionWithoutModel(
    BuildContext context,
    String page,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var startDate;
    var endDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd 00:00:00');
    endDate = DateTime.now().add(Duration(days: 1));

    startDate = formatter.format(now);

    startDate = sharedPreferences.getString('startDate') != null
        ? sharedPreferences.getString('startDate')
        : startDate.toString();
    endDate = sharedPreferences.getString('endDate') != null
        ? sharedPreferences.getString('endDate')
        : endDate.toString();
    var endFormatter = new DateFormat('yyyy-MM-dd 23:59:59');
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var url = TRANSACTION_LIST + headers['auth_code'];
    Map<String, String> params = {
      'page': page,
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  getAvailableBalance(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = AVAILABLE_BALANCE + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }

  fetchMyReferalEarnings(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = MY_REFERAL_EARNINGS + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }

  getWithdrawMoneyWallet(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = WITHDRAW_AMOUNT + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }

  getDashBoardDetails(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DASHBOARD_EARNINGS + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }

  cancelRide(
      BuildContext context, String bookingId, String cancelReason) async {
    var headers = await ApiHelper().getHeader(context);
    var url = CANCEL_RIDE + headers['auth_code'];
    Map<String, String> params = {
      'booking_id': bookingId,
      'cancel_reason': cancelReason
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print("response");
    print(response);
    return response;
  }

  fetchCollectCashApi(BuildContext context, String bookingId) async {
    var headers = await ApiHelper().getHeader(context);
    var url = COLLECT_CASH + headers['auth_code'];
    Map<String, String> params = {'booking_id': bookingId};
    var response = await ApiHelper().getTypePost(context, url, params);
    print("response");
    print(response);
    return response;
  }
}
