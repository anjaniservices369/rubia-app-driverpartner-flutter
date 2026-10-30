// Checks GPS and submits the current position before opening the home screen.
import 'dart:async';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

// >>> START  class LocationErrorScreen
class LocationErrorScreen extends StatefulWidget {
  const LocationErrorScreen({super.key, this.authCode});
  final String? authCode;

  @override
  State<LocationErrorScreen> createState() => _LocationErrorScreenState();
}
// <<< END    class LocationErrorScreen

// >>> START  class _LocationErrorScreenState
class _LocationErrorScreenState extends State<LocationErrorScreen> {
  bool _loading = true;
  bool _gpsDisabled = false;
  String _message = 'Getting your current location...';
  String? _error;

  // >>> START  _LocationErrorScreenState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _locateUser());
  }
  // <<< END    _LocationErrorScreenState.initState()

  // >>> START  _LocationErrorScreenState._locateUser()  -  locate user
  Future<void> _locateUser() async {
    setState(() {
      _loading = true;
      _error = null;
      _gpsDisabled = false;
      _message = 'Getting your current location...';
    });
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!mounted) return;
      if (!enabled) {
        setState(() {
          _gpsDisabled = true;
          _error = 'GPS is turned off. Enable location services, then try again.';
          _loading = false;
        });
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 30),
      );
      if (!position.latitude.isFinite || !position.longitude.isFinite) {
        throw const FormatException('The phone returned an invalid location.');
      }
      if (!mounted) return;
      setState(() => _message = 'Looking up your pickup area...');
      final address = await Geocoder2.getDataFromCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
        googleMapApiKey: mapKey,
      ).timeout(const Duration(seconds: 15));
      if (!mounted) return;
      setState(() => _message = 'Updating your location on Rubia...');
      final result = await UserAPI().getUpdateLatLong(
        context, position.latitude.toString(), position.longitude.toString(), address.address,
      ).timeout(const Duration(seconds: 20));
      if (!mounted) return;
      if (result == null || result['status'] != 'OK') {
        throw StateError(result?['error']?.toString() ?? 'Rubia could not save your location. Please try again.');
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('lattitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);
      await prefs.setString('FeatureName', address.city);
      await prefs.setString('AddressLine', address.streetNumber);
      await prefs.setString('Locality', address.address);
      if (mounted) Twl.forceNavigateTo(context, BottomNavigation());
    } catch (error, stack) {
      debugPrint('Location setup failed: $error\n$stack');
      if (!mounted) return;
      setState(() {
        _error = error is TimeoutException
            ? 'Location setup timed out. Check GPS and internet, then try again.'
            : 'Could not set up your location: $error';
        _loading = false;
      });
    }
  }
  // <<< END    _LocationErrorScreenState._locateUser()

  // >>> START  _LocationErrorScreenState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) Twl.willpopAlert(context);
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              if (_loading) const CircularProgressIndicator(),
              const SizedBox(height: 24),
              Text(_error ?? _message, textAlign: TextAlign.center),
              if (!_loading) ...[
                const SizedBox(height: 16),
                if (_gpsDisabled)
                  TextButton(
                    onPressed: Geolocator.openLocationSettings,
                    child: const Text('Open location settings'),
                  ),
                ElevatedButton(onPressed: _locateUser, child: const Text('Try again')),
              ],
            ]),
          ),
        ),
      ),
    );
  }
  // <<< END    _LocationErrorScreenState.build()
}
// <<< END    class _LocationErrorScreenState
