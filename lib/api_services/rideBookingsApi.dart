// ----------------------------------------------------------------------
// Booking & ride requests
//
// Requests about rides: list bookings, booking details, accept / reject, go
// for pickup, start, complete, cancel, earnings, reviews, referral earnings.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/ApiHelper.dart';
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

// >>> START  class RideBookingsApi
/// Ride-level server calls: bookings, accept/reject, pickup, start, complete, earnings, reviews.
class RideBookingsApi {
  // >>> START  RideBookingsApi.fetchBookingsList()  -  fetch bookings list
  //Driver Booking Apis
  Future<dynamic> fetchBookingsList(BuildContext context, String page, String status) async {
    var jsonMap;
    var headers = await ApiHelper().getHeader(context);
    var uri = DRIVER_BOOKINGS + headers['auth_code'] + '&page=' + page;
    print(uri);
    Map<String, String> params = {'status': status};
    print(params);
    jsonMap = await ApiHelper().getTypePost(context, uri, params);
    var response = jsonMap;
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    print(response);
    print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy');
    return response;
  }
  // <<< END    RideBookingsApi.fetchBookingsList()
  // Driver Earnings Api

  // >>> START  RideBookingsApi.fetchEarningsList()  -  fetch earnings list
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
    var headers = await ApiHelper().getHeader(context);
    var url =

        DRIVER_EARNINGS + headers['auth_code'] + '&page=' + page;
    Map<String, String> params = {
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print("-----------------------------------------------------------");
    print(response);
    print("-----------------------------------------------------------");
    return response;
  }
  // <<< END    RideBookingsApi.fetchEarningsList()

  // >>> START  RideBookingsApi.fetchBookigDetails()  -  fetch bookig details
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
  // <<< END    RideBookingsApi.fetchBookigDetails()

  // >>> START  RideBookingsApi.fetchEarningsDashboard()  -  fetch earnings dashboard
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
    print(jsonMap);
    return jsonMap;
  }
  // <<< END    RideBookingsApi.fetchEarningsDashboard()

  // >>> START  RideBookingsApi.acceptRideApi()  -  accept ride api
  //Accept Ride
  acceptRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ACCEPT_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.acceptRideApi()

  // >>> START  RideBookingsApi.rejectRideApi()  -  reject ride api
  //reject ride
  rejectRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = REJECT_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.rejectRideApi()

  // >>> START  RideBookingsApi.fetchDriverRidePickUp()  -  fetch driver ride pick up
//ridePickup APis
  fetchDriverRidePickUp(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = RIDE_PICK_UP + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.fetchDriverRidePickUp()

  // >>> START  RideBookingsApi.notifyArrivedLocation()  -  notify arrived location
//Arrived Location
  notifyArrivedLocation(
      BuildContext context, String bookingId) async {
    var headers = await ApiHelper().getHeader(context);
    var url = NOTIFY_ARRIVED_LOCATION + headers['auth_code'];
    print(url);
    Map<String, String> params = {'booking_id': bookingId};
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.notifyArrivedLocation()


  // >>> START  RideBookingsApi.getDriverArrivedLocation()  -  get driver arrived location
  getDriverArrivedLocation(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DRIVER_ARRIVED_LOCATION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getDriverArrivedLocation()
//Vehicle Verification

  // >>> START  RideBookingsApi.getVehicleVerficationDetails()  -  get vehicle verfication details
  getVehicleVerficationDetails(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = VEHICLE_VERIRIFICATION + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getVehicleVerficationDetails()

  // >>> START  RideBookingsApi.fetchDriverReviws()  -  fetch driver reviws
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
  // <<< END    RideBookingsApi.fetchDriverReviws()

  // >>> START  RideBookingsApi.getAddReviewsAndRatings()  -  get add reviews and ratings
  //Add Rating and Reviews APi
  getAddReviewsAndRatings(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_RATINGS_REVIEWS + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    return response;
  }
  // <<< END    RideBookingsApi.getAddReviewsAndRatings()

  // >>> START  RideBookingsApi.getStartRideAPi()  -  get start ride api
//Start Ride
  getStartRideAPi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = START_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getStartRideAPi()

  // >>> START  RideBookingsApi.completeRideApi()  -  complete ride api
  //complete ride
  completeRideApi(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = COMPLETE_RIDE + headers['auth_code'];
    Map<String, String> params = param;
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    print(param);
    print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.completeRideApi()

  //Booking history Api

  fetchBookingHistory(
    BuildContext context,
    String page,
    String status, {
    // true = every date (the Completed tab on Bookings); false = the date range chosen in Ride History (today by default)
    bool allDates = false,
  }) async {
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
    if (allDates) {
      startDate = '2000-01-01 00:00:00';
      endDate = endFormatter.format(now);
    }
    var headers = await ApiHelper().getHeader(context);
    var url = BOOKING_HISTORY + headers['auth_code'] + '&page=' + page;
    Map<String, String> params = {
      'status': status,
      'start_date': startDate.toString(),
      'end_date': endFormatter.format(DateTime.parse(endDate)).toString(),
    };
    var response = await ApiHelper().getTypePost(context, url, params);
    print('<<<<<<<<<<<<<<<<<<<<<<<<ride booking history>>>>>>>>>>>>>>>>>>>>>>');
    print('&page=' + page);
    print(headers['auth_code']);
    print(response);
    return response;
  }

  //Wallet apis

  // >>> START  RideBookingsApi.getAddMoneyWallet()  -  get add money wallet
  getAddMoneyWallet(BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = ADD_BALANCE + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getAddMoneyWallet()

//TRANSACTION LIST

  // >>> START  RideBookingsApi.walletTransactionWithoutModel()  -  wallet transaction without model
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
  // <<< END    RideBookingsApi.walletTransactionWithoutModel()

  // >>> START  RideBookingsApi.getWithdrawInfo()  -  get withdraw info
  getWithdrawInfo(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = WITHDRAW_INFO + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getWithdrawInfo()

  // >>> START  RideBookingsApi.getAvailableBalance()  -  get available balance
  getAvailableBalance(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = AVAILABLE_BALANCE + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getAvailableBalance()

  // >>> START  RideBookingsApi.fetchMyReferalEarnings()  -  fetch my referal earnings
  fetchMyReferalEarnings(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = MY_REFERAL_EARNINGS + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.fetchMyReferalEarnings()


  /// Sends a withdrawal request (param: amount). The server pays it to the bank details the driver registered.
  withdrawAmount(BuildContext context, Map<String, String> param) => getWithdrawMoneyWallet(context, param);

  // >>> START  RideBookingsApi.getWithdrawMoneyWallet()  -  get withdraw money wallet
  getWithdrawMoneyWallet(
      BuildContext context, Map<String, String> param) async {
    var headers = await ApiHelper().getHeader(context);
    var url = WITHDRAW_AMOUNT + headers['auth_code'];
    Map<String, String> params = param;
    var response = await ApiHelper().getTypePost(context, url, params);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getWithdrawMoneyWallet()

  // >>> START  RideBookingsApi.getDashBoardDetails()  -  get dash board details
  getDashBoardDetails(BuildContext context) async {
    var headers = await ApiHelper().getHeader(context);
    var url = DASHBOARD_EARNINGS + headers['auth_code'];
    var response = await ApiHelper().getTypeGet(context, url);
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.getDashBoardDetails()

  // >>> START  RideBookingsApi.cancelRide()  -  cancel ride
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
  // <<< END    RideBookingsApi.cancelRide()

  // >>> START  RideBookingsApi.fetchCollectCashApi()  -  fetch collect cash api
  fetchCollectCashApi(BuildContext context, String bookingId, String userId) async {
    var headers = await ApiHelper().getHeader(context);
    var url = COLLECT_CASH + headers['auth_code'];
    Map<String, String> params = {'booking_id': bookingId,'user_id':userId};
    var response = await ApiHelper().getTypePost(context, url, params);
    print("response");
    print(response);
    return response;
  }
  // <<< END    RideBookingsApi.fetchCollectCashApi()
}
// <<< END    class RideBookingsApi
