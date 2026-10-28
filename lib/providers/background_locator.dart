// ----------------------------------------------------------------------
// Background locator state
//
// Starts/stops the background location plugin and checks permission.
// ----------------------------------------------------------------------
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart' as locPermission;
import '../views/ride_info/location_callback_handler.dart';

// >>> START  class BackgroundLocationProvider
class BackgroundLocationProvider with ChangeNotifier {
  bool isRunning = false;
  // LocationPermissionStatus permissionStatus = LocationPermissionStatus.denied;
  PermissionStatus permissionStatus = PermissionStatus.denied;

  // >>> START  BackgroundLocationProvider.onStop()  -  on stop
  Future<void> onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    isRunning = _isRunning;
    notifyListeners();
  }
  // <<< END    BackgroundLocationProvider.onStop()

  // >>> START  BackgroundLocationProvider.onStart()  -  on start
  Future<bool> onStart() async {
    permissionStatus = (await checkLocationPermission()) as PermissionStatus;

    if (permissionStatus == PermissionStatus.granted) {
      await startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();
      isRunning = _isRunning;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
  // <<< END    BackgroundLocationProvider.onStart()

  // >>> START  BackgroundLocationProvider.checkLocationPermission()  -  check location permission
  Future<bool> checkLocationPermission() async {
    // final access = await LocationPermissions().checkPermissionStatus();
    var access = await Permission.locationAlways.status;
    print("status");
    print(access);
    if (access == PermissionStatus.denied ||
        access == PermissionStatus.limited ||
        access == PermissionStatus.permanentlyDenied ||
        access == PermissionStatus.restricted) {
      final permission = await locPermission.LocationPermissions().requestPermissions(
        permissionLevel: locPermission.LocationPermissionLevel.locationAlways,
      );
      if (permission == PermissionStatus.granted) {
        return true;
        // Permission was granted as locationAlways
      } else {
        return false;
        // Permission was not granted
      }
    } else if (access == PermissionStatus.granted) {
      return true;
    } else {
      final permission = await locPermission.LocationPermissions().requestPermissions(
        permissionLevel: locPermission.LocationPermissionLevel.locationAlways,
      );
      if (permission == PermissionStatus.granted) {
        return true;
        // Permission was granted as locationAlways
      } else {
        return false;
        // Permission was not granted
      }
    }
  }
  // <<< END    BackgroundLocationProvider.checkLocationPermission()
}
// <<< END    class BackgroundLocationProvider

// >>> START  startLocator()  -  start locator
Future<void> startLocator() async {
  Map<String, dynamic> data = {'countInit': 1};
  await BackgroundLocator.registerLocationUpdate(
    LocationCallbackHandler.callback,
    initCallback: LocationCallbackHandler.initCallback,
    initDataCallback: data,
    disposeCallback: LocationCallbackHandler.disposeCallback,
    iosSettings: IOSSettings(
      accuracy: LocationAccuracy.NAVIGATION,
      distanceFilter: 5,
      stopWithTerminate: false,
      showsBackgroundLocationIndicator: true,
    ),
    autoStop: false,
    androidSettings: AndroidSettings(
      accuracy: LocationAccuracy.NAVIGATION,
      interval: 5,
      wakeLockTime: 60 * 60 * 60,
      distanceFilter: 0,
      client: LocationClient.google,
      androidNotificationSettings: AndroidNotificationSettings(
        notificationChannelName: 'Location tracking',
        notificationTitle: 'Start Location Tracking',
        notificationMsg: 'Track location in the background',
        notificationBigMsg:
            'Background location is on to keep the app up-to-date with your location. This is required for main features to work properly when the app is not running.',
        notificationIconColor: Colors.grey,
        notificationTapCallback: LocationCallbackHandler.notificationCallback,
      ),
    ),
  );
}
// <<< END    startLocator()
