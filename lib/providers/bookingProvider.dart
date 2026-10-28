// ----------------------------------------------------------------------
// Accept-ride & distance helper
//
// Helper for accepting a ride and for measuring the distance between two GPS
// points.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../api_services/userApi.dart';

// >>> START  class GlobalFunctionProvider
class GlobalFunctionProvider with ChangeNotifier {
  // >>> START  GlobalFunctionProvider.accpetRideProvider()  -  accpet ride provider
  accpetRideProvider(
    context,
  ) async {
    Map<String, String> param = {
      'booking_id': '',
    };
    var res = await RideBookingsApi().acceptRideApi(context, param);
    if (res != null && res['status'] == 'OK') {}
    notifyListeners();
    return res;
  }
  // <<< END    GlobalFunctionProvider.accpetRideProvider()

  // >>> START  GlobalFunctionProvider.calculateDistance()  -  calculate distance
  double calculateDistance(Position position1, Position position2) {
    final distance = Geolocator.distanceBetween(
      position1.latitude,
      position1.longitude,
      position2.latitude,
      position2.longitude,
    );
    return distance;
  }
  // <<< END    GlobalFunctionProvider.calculateDistance()

  // >>> START  GlobalFunctionProvider.sendCurrentLocation()  -  send current location
  sendCurrentLocation(BuildContext context) async {
    print("Getting current Location");
    LocationPermission permission;
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle the case when the user denies the location permission permanently
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks.first;
      String address =
          "${placemark.name}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
      print("Getting current Location " + address);

      Map<String, String> param = {
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
      };
      var res = await UserAPI().sendLocation(context, param);
      if (res['status'] == "OK") {
        print('CheckBoundary is hitting here >>>>>>>>');
        print("sent successfully");
      }
    }
  }
  // <<< END    GlobalFunctionProvider.sendCurrentLocation()
}
// <<< END    class GlobalFunctionProvider
