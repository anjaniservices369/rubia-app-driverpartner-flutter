import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  final GeolocatorPlatform _geolocator = GeolocatorPlatform.instance;
  final databaseReference = FirebaseDatabase.instance.ref();

  double currentLatitude = 0.0;
  double get _currentLatitude => currentLatitude;

  double currentLongitude = 0.0;
  double get _currentLongitude => currentLongitude;

  Position? previousPosition;
  List<LatLng> locationUpdates = [];
  Map<String, List<LatLng>> rideData = {};
  StreamSubscription<Position>? _positionStreamSubscription;
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
        final distance = calculateDistance(previousPosition, currentPosition);
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

        // Save intermediate locations to Firebase
        // ...

        // Save intermediate locations to Firebase Firestore
        final locationData = {
          'latitude': intermediateLocation.latitude,
          'longitude': intermediateLocation.longitude,
          'timestamp': DateTime.now(),
        };

        final CollectionReference ridesCollection = FirebaseFirestore.instance.collection('Rides');

        // Retrieve or create the ride ID document
        final DocumentReference rideDocumentRef = ridesCollection.doc(bookingDetails['id'].toString());
        final DocumentSnapshot rideSnapshot = await rideDocumentRef.get();

        if (rideSnapshot.exists) {
          // If the ride ID document exists, update the rideHistory array
          await rideDocumentRef.update({
            'rideHistory': FieldValue.arrayUnion([locationData])
          });
        } else {
          // If the ride ID document doesn't exist, create it with the rideHistory array
          await rideDocumentRef.set({
            'rideHistory': [locationData]
          });
        }

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

  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  List<LatLng>? getRideData(String rideId) {
    if (rideData.containsKey(rideId)) {
      return rideData[rideId];
    }
    return null;
  }
}
