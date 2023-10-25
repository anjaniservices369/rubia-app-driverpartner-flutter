// import 'package:easygo_skipper_flutter/apiServices/userApi.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageProvider with ChangeNotifier {
  List rideDetailImagesList = [];
  List get _rideDetailImagesList => rideDetailImagesList;
  List rideEndedImagesList = [];
  List get _rideEndedImagesList => rideEndedImagesList;

  var riderDetails;

  String status = '0';
  String get _status => status;

  String carPictureStatus = '0';
  String get _carPictureStatus => carPictureStatus;

  var checkDetals;

  storeRideDetailImages(BuildContext context, String status) async {
    rideDetailImagesList = [];
    notifyListeners();
    return _rideDetailImagesList;
  }

  storeRideEndDetailImages(BuildContext context, String status) async {
    rideEndedImagesList = [];
    notifyListeners();
    return _rideEndedImagesList;
  }

  fetchAcceptRideApi(BuildContext context, param) async {
    var res = await RideBookingsApi().acceptRideApi(context, param);
    if (res['status'] != 'OK') {
      notifyListeners();
      return res['details'];
    } else {
      String errorMessage = res['error'];
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Something went wrong'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      notifyListeners();
      return res['error'];
    }
  }

  fetchCheckDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checkRes = await UserAPI().checkApi(pref.getString('authCode')!);
    if (checkRes != null && checkRes['status'] == 'OK') {
      checkDetals = checkRes['detail'];
    } else {}
  }

  fetchRejectRideApi(BuildContext context, param) async {
    var res = await RideBookingsApi().rejectRideApi(context, param);
    if (res['status'] == 'OK') {
      riderDetails = res['details'];
      notifyListeners();
      return res['details'];
    } else {
      notifyListeners();
      return res['error'];
    }
  }

  storeDriverPickupStatus() {
    status = '0';
    notifyListeners();
    return status;
  }

  fetchDriverPickupDetails(BuildContext context, param) async {
    var res = await RideBookingsApi().fetchDriverRidePickUp(context, param);
    if (res['status'] == 'OK') {
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return res;
    }
  }

  getDriverArrivedLocation(BuildContext context, param) async {
    var res = await RideBookingsApi().getDriverArrivedLocation(context, param);
    if (res['status'] == 'OK') {
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return res;
    }
  }

  getDriverCompleteRide(BuildContext context, param) async {
    var res = await RideBookingsApi().completeRideApi(context, param);
    if (res['status'] == 'OK') {
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return res;
    }
  }

  getVehicleVerficationDetails(BuildContext context, param) async {
    var res =
        await RideBookingsApi().getVehicleVerficationDetails(context, param);
    if (res['status'] == 'OK') {
      notifyListeners();
      return res;
    } else {
      notifyListeners();
      return res;
    }
  }

  getDriverReviwDetails(BuildContext context, param) async {
    var res = await RideBookingsApi().fetchDriverReviws(context, '');
    if (res['status'] == 'OK') {
      notifyListeners();
      return res['rating'];
    } else {
      notifyListeners();
      return res['status'];
    }
  }

  storeCarImageStatus(BuildContext context, String status) async {
    carPictureStatus = '0';
    notifyListeners();
    return _carPictureStatus;
  }
}
