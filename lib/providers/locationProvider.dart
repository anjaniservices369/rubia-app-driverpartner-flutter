// ----------------------------------------------------------------------
// Ride route tracker
//
// Collects the driver's GPS points during a ride so the route can be drawn
// on the map and sent with the bill.
// ----------------------------------------------------------------------
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

// >>> START  class LocationProvider
/// Collects GPS points during a ride so the route can be drawn and sent with the bill.
class LocationProvider with ChangeNotifier {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;

  double currentLatitude = 0.0;

  double currentLongitude = 0.0;

  Position? previousPosition;
  List<LatLng> locationUpdates = [];
  Map<String, List<LatLng>> rideData = {};
  StreamSubscription<Position>? _positionStreamSubscription;
  // >>> START  LocationProvider.startLocationUpdates()  -  start location updates
  Future<void> startLocationUpdates(var bookingDetails) async {
    try {
      print('entered here');

      final status = await _geolocator.checkPermission();
      if (status == LocationPermission.denied) {
        final permission = await _geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          print('here its therree');
          // Handle permission not granted case
          return;
        }
      }

      final serviceEnabled = await _geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('entered here2');
        // Handle location services disabled case
        return;
      }

      final positionStream = _geolocator.getPositionStream();

      _positionStreamSubscription = positionStream.listen((currentPosition) async {
        if (previousPosition == null) {
          previousPosition = currentPosition;
        }
        // print('listening started<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<');
        // print(previousPosition.toString());
        // print('listening started>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
        // print(distance.toString());
        // print(currentPosition.latitude.toString());
        // print(currentPosition.longitude.toString());
        currentLatitude = currentPosition.latitude;
        currentLongitude = currentPosition.longitude;
        final intermediateLocation = LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        );
        // print(intermediateLocation.toString());
        locationUpdates.add(intermediateLocation);
        if (!rideData.containsKey(bookingDetails['id'].toString())) {
          rideData[bookingDetails['id'].toString()] = [];
        }
        rideData[bookingDetails['id'].toString()]!.add(intermediateLocation);

        previousPosition = currentPosition;
        // } else {
        //   print('distance');
        //   print(distance.toString());
        //   print('distance');
        // }
      });
    } catch (e) {
      // Handle location error
    }
  }
  // <<< END    LocationProvider.startLocationUpdates()

  // >>> START  LocationProvider.calculateDistance()  -  calculate distance
  double calculateDistance(Position? previousPosition, Position currentPosition) {
    if (previousPosition == null) {
      return 0.0;
    }

    final distance = Geolocator.distanceBetween(
      previousPosition.latitude,
      previousPosition.longitude,
      currentPosition.latitude,
      currentPosition.longitude,
    );

    return distance;
  }
  // <<< END    LocationProvider.calculateDistance()

  // >>> START  LocationProvider.stopLocationUpdates()  -  stop location updates
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }
  // <<< END    LocationProvider.stopLocationUpdates()

  // >>> START  LocationProvider.getRideData()  -  get ride data
  List<LatLng>? getRideData(String rideId) {
    if (rideData.containsKey(rideId)) {
      return rideData[rideId];
    }
    return null;
  }
  // <<< END    LocationProvider.getRideData()
}
// <<< END    class LocationProvider
