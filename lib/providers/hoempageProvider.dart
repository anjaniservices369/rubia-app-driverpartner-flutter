// ----------------------------------------------------------------------
// Home / ride photo state
//
// Holds temporary state while a ride is being set up (the before/after ride
// photos).
//
// Developer note: File name typo is historical.
// ----------------------------------------------------------------------
// import 'package:easygo_skipper_flutter/apiServices/userApi.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class HomePageProvider
class HomePageProvider with ChangeNotifier {
  List rideDetailImagesList = [];
  List get _rideDetailImagesList => rideDetailImagesList;
  List rideEndedImagesList = [];
  List get _rideEndedImagesList => rideEndedImagesList;

  var riderDetails;

  String status = '0';

  String carPictureStatus = '0';
  String get _carPictureStatus => carPictureStatus;

  var checkDetals;

  // >>> START  HomePageProvider.storeRideDetailImages()  -  store ride detail images
  storeRideDetailImages(BuildContext context, String status) async {
    rideDetailImagesList = [];
    notifyListeners();
    return _rideDetailImagesList;
  }
  // <<< END    HomePageProvider.storeRideDetailImages()

  // >>> START  HomePageProvider.storeRideEndDetailImages()  -  store ride end detail images
  storeRideEndDetailImages(BuildContext context, String status) async {
    rideEndedImagesList = [];
    notifyListeners();
    return _rideEndedImagesList;
  }
  // <<< END    HomePageProvider.storeRideEndDetailImages()

  // >>> START  HomePageProvider.fetchAcceptRideApi()  -  fetch accept ride api
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
  // <<< END    HomePageProvider.fetchAcceptRideApi()

  // >>> START  HomePageProvider.fetchCheckDetails()  -  fetch check details
  fetchCheckDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checkRes = await UserAPI().checkApi(pref.getString('authCode')!);
    if (checkRes != null && checkRes['status'] == 'OK') {
      checkDetals = checkRes['detail'];
    } else {}
  }
  // <<< END    HomePageProvider.fetchCheckDetails()

  // >>> START  HomePageProvider.fetchRejectRideApi()  -  fetch reject ride api
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
  // <<< END    HomePageProvider.fetchRejectRideApi()

  // >>> START  HomePageProvider.storeDriverPickupStatus()  -  store driver pickup status
  storeDriverPickupStatus() {
    status = '0';
    notifyListeners();
    return status;
  }
  // <<< END    HomePageProvider.storeDriverPickupStatus()

  // >>> START  HomePageProvider.fetchDriverPickupDetails()  -  fetch driver pickup details
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
  // <<< END    HomePageProvider.fetchDriverPickupDetails()

  // >>> START  HomePageProvider.getDriverArrivedLocation()  -  get driver arrived location
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
  // <<< END    HomePageProvider.getDriverArrivedLocation()

  // >>> START  HomePageProvider.getDriverCompleteRide()  -  get driver complete ride
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
  // <<< END    HomePageProvider.getDriverCompleteRide()

  // >>> START  HomePageProvider.getVehicleVerficationDetails()  -  get vehicle verfication details
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
  // <<< END    HomePageProvider.getVehicleVerficationDetails()

  // >>> START  HomePageProvider.getDriverReviwDetails()  -  get driver reviw details
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
  // <<< END    HomePageProvider.getDriverReviwDetails()

  // >>> START  HomePageProvider.storeCarImageStatus()  -  store car image status
  storeCarImageStatus(BuildContext context, String status) async {
    carPictureStatus = '0';
    notifyListeners();
    return _carPictureStatus;
  }
  // <<< END    HomePageProvider.storeCarImageStatus()
}
// <<< END    class HomePageProvider
