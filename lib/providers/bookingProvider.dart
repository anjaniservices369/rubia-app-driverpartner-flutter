import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GlobalFunctionProvider with ChangeNotifier {
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

  double calculateDistance(Position position1, Position position2) {
    final distance = Geolocator.distanceBetween(
      position1.latitude,
      position1.longitude,
      position2.latitude,
      position2.longitude,
    );
    return distance;
  }
}
