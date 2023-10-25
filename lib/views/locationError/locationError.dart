// ignore_for_file: deprecated_member_use

import 'package:android_intent_plus/android_intent.dart';
import 'package:app_settings/app_settings.dart';
import 'package:base_project_flutter/api_services/userApi.dart';

import 'package:base_project_flutter/constants/constants.dart';
import 'package:location_permissions/location_permissions.dart' as locPermission;
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalFuctions/googleMaps.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart' as locater;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:location/location.dart' as loct;

class LocationErrorScreen extends StatefulWidget {
  LocationErrorScreen({Key? key, this.authCode}) : super(key: key);
  final authCode;
  @override
  _LocationErrorScreenState createState() => _LocationErrorScreenState();
}

class _LocationErrorScreenState extends State<LocationErrorScreen> {
  locater.Position? currentLocation;
  String? _currentAddress;
  bool isLoading = false;
  bool deliveryAddress = true;
  SharedPreferences? sharedPreferences;
  bool isLocationEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('....Object');
    getUserLocation();
  }

  Future _checkGps() async {
    if (!(await locater.Geolocator.isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("canot get current location"),
              content: Text('please make sure you enable gps and try again'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    intent.launch();

                    Navigator.of(context).pop();
                    getUserLocation();
                  },
                  child: Text('ok'),
                )
              ],
            );
          },
        );
      }
    }
  }

  //changed code on 22 -2-23
  late locater.Position _currentPosition;

  _getCurrentLocation() {
    locater.Geolocator.getCurrentPosition(desiredAccuracy: locater.LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((locater.Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
        print('_currentAddress');
        print(_currentAddress);
        print('_currentAddress');
      });
    } catch (e) {
      print(e);
    }
  }

  Future locateUser() async {
    print('addresses;;;');
    setState(() {
      isLoading = true;
    });
    // if ((await locater.Geolocator.isLocationServiceEnabled())) {
    // locater.Position position = await locater.Geolocator.getCurrentPosition(
    //     desiredAccuracy: locater.LocationAccuracy.high);
    loct.Location location = new loct.Location();
    print('addresses;;dsfdf;');
    loct.LocationData _locationData = await location.getLocation();
    print('addresses;;sdfdsf;');
    final coordinates = new Coordinates(_locationData.latitude, _locationData.longitude);
    print(coordinates.toString());
    try {
      // var addresses = await Geocoder.google(mapKey)
      //     .findAddressesFromCoordinates(coordinates);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      print('addresses');
      print(addresses);
      print('addresses');
      var first = addresses.first;
      setState(() {
        _currentAddress = "${first.locality}, ${first.featureName},${first.postalCode}, ${first.addressLine}";
        // ${first.subLocality}";
      });
      //check delivery
      print('first');
      print(first);
      print('first');
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setDouble('lattitude', double.parse(_locationData.latitude.toString()));
      var lat = sharedPreferences.getDouble('lattitude');
      sharedPreferences.setDouble('longitude', double.parse(_locationData.longitude.toString()));
      var long = sharedPreferences.getDouble('longitude');
      sharedPreferences.setString('FeatureName', first.featureName);
      var featureName = sharedPreferences.getString('FeatureName');
      sharedPreferences.setString('AddressLine', first.addressLine);
      var addressLine = sharedPreferences.getString('AddressLine');
      sharedPreferences.setString('Locality', first.locality);
      var locality = sharedPreferences.getString('Locality');
      // sharedPreferences.setString('subLocality', first.subLocality);
      // var subLocality = sharedPreferences.getString('subLocality');
      // sharedPreferences.setString('adminArea', first.adminArea);
      // var adminArea = sharedPreferences.getString('adminArea');
      // sharedPreferences.setString('subAdminArea', first.subAdminArea);
      // var subAdminArea = sharedPreferences.getString('subAdminArea');
      print('lat');
      print(lat);
      print('long');
      print(long);
      print('featureName');
      print(featureName);
      print('addressLine');
      print(addressLine);
      print('locality');
      print(locality);
      // print('sublocality${subLocality}');
      setState(() {
        isLoading = true;
      });
      var res = await UserAPI().getUpdateLatLong(context, lat.toString(), long.toString());
      if (res != null && res['status'] == 'OK') {
        print('helloDude');
        Twl.navigateTo(context, BottomNavigation());
      } else {
        Twl.createAlert(context, 'OOps', res['error']);
      }
    } catch (e) {
      print(e);
      // Twl.createAlert(context, 'error', e.toString());
    }
    // } else {
    //    _checkGps();
    // }
    //  await _checkGps();
  }

  getUserLocation() async {
    print('getUserLocation');
    setState(() {
      isLoading = false;
    });

    currentLocation = await locateUser();
    print('locateUser');
    // print('center $_center');
  }

//   determinePosition() async {
//     print('determinePosition');
//     locater.LocationPermission permission;
//     // permission = await locater.Geolocator.checkPermission();
//     permission = await locater.Geolocator.requestPermission();
// // dsxfv
//     // Map<Permission, PermissionStatus> statuses = await [
//     //   Permission.location,
//     //   Permission.storage,
//     // ].request();
//     // print(statuses);
//     // if (await Permission.location.serviceStatus.isEnabled ||
//     //     await Permission.locationAlways.serviceStatus.isEnabled ||
//     //     await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//     //   print("Ssdvsdvs>>>>>>>>>>>..");
//     //   return getUserLocation();
//     //   // Either the permission was already granted before or the user just granted it.
//     // } else {
//     //   Map<Permission, PermissionStatus> statuses = await [
//     //     Permission.location,
//     //     Permission.storage,
//     //   ].request();
//     // }
//     if (permission == locater.LocationPermission.denied) {
//       permission = await locater.Geolocator.requestPermission();
//       if (permission == locater.LocationPermission.deniedForever) {
//         print('LocationPermission');
//         //  locater.LocationPermission permission = await locater.Geolocator.requestPermission();
//         await openAppSettings();
//         print('openAppSettings');
//         return Future.error('Location Not Available');
//       }
//     } else {
//       print('getUserLocation..............');
//       return getUserLocation();
//     }
//     print('getUserLocation...');
//     return await getUserLocation();
//   }

  Future<bool> determinePosition() async {
    print('determinePosition');

    // Check if the permission status is stored in shared preferences
    final prefs = await SharedPreferences.getInstance();
    final storedStatus = prefs.getString('locationPermissionStatus');

    // If the status is stored and is "granted," return true
    if (storedStatus == 'granted') {
      print('getUserLocation..............');
      await getUserLocation();
      return true;
    } else {
      // Permission status is not stored or is not granted
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
          print('getUserLocation..............');
          await getUserLocation();
          await prefs.setString('locationPermissionStatus', 'granted');

          return true;
        } else {
          // Permission was not granted
          print('LocationPermission');
          // await openAppSettings();
          await locater.Geolocator.openAppSettings();
          print('openAppSettings');
          return false;
        }
      } else if (access == PermissionStatus.granted) {
        print('getUserLocation..............');
        await getUserLocation();
        return true;
      } else {
        final permission = await locPermission.LocationPermissions().requestPermissions(
          permissionLevel: locPermission.LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          print('getUserLocation..............');
          await getUserLocation();
          await prefs.setString('locationPermissionStatus', 'granted');

          return true;
        } else {
          // Permission was not granted
          print('LocationPermission');
          // await openAppSettings();
          await locater.Geolocator.openAppSettings();
          print('openAppSettings');
          return false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.willpopAlert(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: isLoading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (currentLocation != null)
                          //Text(currentLocation.toString()),
                          Center(child: Container(height: 30.h, width: 60.w, child: Lottie.asset('assets/lottie/LocationLottie.json'))),
                        if (_currentAddress != null)
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: tDefaultPadding * 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: tDefaultPadding * 2),
                                decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    // Image.asset(
                                    //   'Images.LocationenableIcon',
                                    //   width: 30.w,
                                    // ),
                                    Center(child: Container(height: 30.h, width: 60.w, child: Lottie.asset('assets/lottie/LocationLottie.json'))),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Text(
                                      deliveryAddress ? "We Got Your Location" : "Unable to fetch this address",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: isDesktop(context) ? 3.sp : 14.sp, fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(height: tDefaultPadding),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: tDefaultPadding * 2),
                                      child: Text(
                                        _currentAddress!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: isDesktop(context) ? 3.sp : 10.sp, color: tSecondaryColor, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    deliveryAddress
                                        ? Container()
                                        : GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: tDefaultPadding * 2, vertical: tDefaultPadding / 2),
                                              decoration: BoxDecoration(
                                                  // gradient: tPrimaryGradientColor,
                                                  borderRadius: BorderRadius.circular(50)),
                                              child: Text(
                                                'Change Location',
                                                style: TextStyle(
                                                  color: tWhite,
                                                ),
                                              ),
                                            ),
                                            onTap: () async {
                                              // Twl.navigateTo(
                                              //     context, GoogleMapPage());
                                            },
                                          )
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: tDefaultPadding * 2),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: tDefaultPadding * 2),
                                decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    // Image.asset(
                                    //   'Images.LocationenableIcon',
                                    //   width: 30.w,
                                    // ),
                                    Center(child: Container(height: 30.h, width: 60.w, child: Lottie.asset('assets/lottie/LocationLottie.json'))),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Text(
                                      "Enable your location to ",
                                      style:
                                          TextStyle(fontSize: isDesktop(context) ? 3.sp : 14.sp, color: tSecondaryColor, fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: tDefaultPadding * 2),
                                      child: Text(
                                        "Please allow to use your location to see nearby store on the map.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: isDesktop(context) ? 3.sp : 10.sp, color: tSecondaryColor, fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    SizedBox(
                                      height: tDefaultPadding,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: tDefaultPadding * 2, vertical: tDefaultPadding / 1.5),
                                        decoration: BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(5)),
                                        child: Text(
                                          'Enable Location',
                                          style: TextStyle(
                                            color: tWhite,
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        print('location enable >>>>');
                                        await determinePosition();
                                        //  await  _getCurrentLocation();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        isLocationEnabled != null
                            ? Container()
                            : TextButton(
                                style: TextButton.styleFrom(
                                  primary: tPrimaryColor,
                                ),
                                onPressed: AppSettings.openLocationSettings,
                                child: Text('app_settings'),
                              )
                      ],
                    )
                  : CircularProgressIndicator(),
            ),
            if (kIsWeb)
              Positioned(
                top: 20,
                right: 15,
                child: Container(
                  alignment: Alignment.centerRight,
                  // width: 30.w,
                  child: GestureDetector(
                    onTap: () {
                      Twl.navigateTo(context, BottomNavigation());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: isTab(context) ? 100 : 60,
                      height: isTab(context) ? 40 : 25,
                      decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "skip",
                        style: TextStyle(color: tPrimaryColor, fontSize: 12.sp),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
