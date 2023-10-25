// import 'dart:async';
// import 'package:location/location.dart' as device_location;
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'dart:math' as math;

// class LocationServiceProvider extends ChangeNotifier {
//   final LocationService _locationService = LocationService();

//   var locationEntries;
//   bool get isListeningForLocation => _locationService._isListeningForLocation;

//   addlocationEntries(val) {
//     // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     // SharedPreferences pref = await SharedPreferences.getInstance();
//     // var location = sharedPreferences.('authCode');
//     locationEntries = val;
//     print('locationEntries...>>>>>');
//     print(locationEntries);
//     print('locationEntries...>>>>>');
//     notifyListeners();
//   }
// }

// class LocationService {
//   var _locationData;
//   var startLocation;
//   var lat;
//   var lng;
//   List LatLngList = [];
//   StreamSubscription<device_location.LocationData>? _locationSubscription;
//   bool _isListeningForLocation = false;
//   device_location.LocationData? lastLocation;

//   device_location.Location location = device_location.Location();
//   void startListeningForLocation(
//     BuildContext context,
//   ) {
//     final locationProvider =
//         Provider.of<LocationServiceProvider>(context, listen: false);
//     if (!_isListeningForLocation) {
//       // Start location updates
//       location.enableBackgroundMode(enable: true);
//       _locationSubscription =
//           location.onLocationChanged.listen((currentLocation) {
//         if (lastLocation != null) {
//           // Calculate the distance between the last recorded location and the current location
//           double distance = calculateDistance(
//             lastLocation!.latitude!,
//             lastLocation!.longitude!,
//             currentLocation.latitude!,
//             currentLocation.longitude!,
//           );

//           // If the distance is greater than or equal to 500 meters, update the last location
//           if (distance >= 20.0) {
//             lastLocation = currentLocation;

//             // Rest of your code to update Firestore with the current location
//             // ...

//             // Handle location data
//             print('changing data');
//             // Use current location
//             // print(currentLocation.toString());

//             _locationData = currentLocation;
//             currentLocation = currentLocation;
//             lat = currentLocation.latitude!;
//             lng = currentLocation.longitude!;
//             startLocation = {
//               'lat': currentLocation.latitude!.toString(),
//               'lng': currentLocation.longitude!.toString(),
//             };
//             LatLngList.add(startLocation);
//             locationProvider.addlocationEntries(LatLngList);
//             // print(LatLngList);
//           }
//         } else {
//           // If lastLocation is null, set it to the current location
//           lastLocation = currentLocation;

//           // Rest of your code to update Firestore with the current location
//           // ...
//         }
//       });

//       _isListeningForLocation = true;
//     }
//   }

//   void stopListeningForLocation() {
//     if (_isListeningForLocation) {
//       // Stop location updates
//       _locationSubscription!.cancel();
//       _isListeningForLocation = false;
//     }
//   }

//   double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
//     const int earthRadius = 6371000; // in meters
//     double dLat = degreesToRadians(lat2 - lat1);
//     double dLon = degreesToRadians(lon2 - lon1);
//     double a = math.pow(math.sin(dLat / 2), 2) +
//         math.cos(degreesToRadians(lat1)) *
//             math.cos(degreesToRadians(lat2)) *
//             math.pow(math.sin(dLon / 2), 2);
//     double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
//     return earthRadius * c;
//   }

//   double degreesToRadians(double degrees) {
//     return degrees * (math.pi / 180);
//   }
// }
