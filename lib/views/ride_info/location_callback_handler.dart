// ----------------------------------------------------------------------
// Background locator callbacks
//
// Callbacks used by the background location plugin.
// ----------------------------------------------------------------------
import 'dart:async';

import 'package:background_locator_2/location_dto.dart';

import 'location_service_repository.dart';

// >>> START  class LocationCallbackHandler
@pragma('vm:entry-point')
class LocationCallbackHandler {
  // >>> START  LocationCallbackHandler.pragma()
  @pragma('vm:entry-point')
  static Future<void> initCallback(Map<dynamic, dynamic> params) async {
    LocationServiceRepository myLocationCallbackRepository = LocationServiceRepository();
    await myLocationCallbackRepository.init(params);
  }
  // <<< END    LocationCallbackHandler.pragma()

  // >>> START  LocationCallbackHandler.pragma()
  @pragma('vm:entry-point')
  static Future<void> disposeCallback() async {
    LocationServiceRepository myLocationCallbackRepository = LocationServiceRepository();
    await myLocationCallbackRepository.dispose();
  }
  // <<< END    LocationCallbackHandler.pragma()

  // >>> START  LocationCallbackHandler.pragma()
  @pragma('vm:entry-point')
  static Future<void> callback(LocationDto locationDto) async {
    LocationServiceRepository myLocationCallbackRepository = LocationServiceRepository();
    await myLocationCallbackRepository.callback(locationDto);
  }
  // <<< END    LocationCallbackHandler.pragma()

  // >>> START  LocationCallbackHandler.pragma()
  @pragma('vm:entry-point')
  static Future<void> notificationCallback() async {
    print('***notificationCallback');
  }
  // <<< END    LocationCallbackHandler.pragma()
}
// <<< END    class LocationCallbackHandler
