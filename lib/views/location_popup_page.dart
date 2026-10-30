// ----------------------------------------------------------------------
// Always-allow location explainer
//
// Explains why 'Allow all the time' location is needed and sends the driver
// to the phone's settings.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/constants.dart';
import '../../../../globalWidgets/button.dart';
import '../../../../responsive.dart';
import 'locationError/locationError.dart';
import 'location_error_page/location_error_page.dart';

// >>> START  class LocationPopUpPage
class LocationPopUpPage extends StatefulWidget {
  const LocationPopUpPage({Key? key, this.details}) : super(key: key);
  final details;

  @override
  State<LocationPopUpPage> createState() => _LocationPopUpPageState();
}
// <<< END    class LocationPopUpPage

// >>> START  class _LocationPopUpPageState
class _LocationPopUpPageState extends State<LocationPopUpPage> with WidgetsBindingObserver {
  bool _permissionsGranted = false;
  bool _checkingPermissions = true;

  // >>> START  _LocationPopUpPageState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshPermissions();
  }
  // <<< END    _LocationPopUpPageState.initState()

  // >>> START  _LocationPopUpPageState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  // <<< END    _LocationPopUpPageState.dispose()

  // >>> START  _LocationPopUpPageState.didChangeAppLifecycleState()  -  did change app lifecycle state
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshPermissions();
  }
  // <<< END    _LocationPopUpPageState.didChangeAppLifecycleState()

  // >>> START  _LocationPopUpPageState._refreshPermissions()  -  refresh permissions
  Future<void> _refreshPermissions() async {
    final foreground = await Permission.locationWhenInUse.status;
    final background = await Permission.locationAlways.status;
    final notifications = await Permission.notification.status;
    if (!mounted) return;
    setState(() {
      _permissionsGranted = foreground.isGranted && background.isGranted && notifications.isGranted;
      _checkingPermissions = false;
    });
  }
  // <<< END    _LocationPopUpPageState._refreshPermissions()

  // void initState() {
  //   super.initState();
  //   new Future.delayed(const Duration(seconds: 3), () async {}).then((value) {
  //     // Twl.forceNavigateTo(context, BottomNavigation());
  //     //here it should navigateto location page
  //     Twl.forceNavigateTo(context, LocationErrorScreen());
  //   });
  // }

  // >>> START  _LocationPopUpPageState._checkLocationPermission()  -  check location permission
  Future<bool> _checkLocationPermission() async {
    var foregroundLocation = await Permission.locationWhenInUse.status;
    if (!foregroundLocation.isGranted) {
      foregroundLocation = await Permission.locationWhenInUse.request();
    }
    if (!foregroundLocation.isGranted) {
      await _openLocationPermissionSettings();
      return false;
    }

    // Android requires foreground location to be granted before requesting
    // background ("Allow all the time") access.
    var backgroundLocation = await Permission.locationAlways.status;
    if (!backgroundLocation.isGranted) {
      backgroundLocation = await Permission.locationAlways.request();
    }

    var notifications = await Permission.notification.status;
    if (!notifications.isGranted) {
      notifications = await Permission.notification.request();
    }

    if (backgroundLocation.isGranted && notifications.isGranted) {
      return true;
    }

    await _openLocationPermissionSettings();
    return false;
  }
  // <<< END    _LocationPopUpPageState._checkLocationPermission()

  int reason = 0;
  bool ischeckbox = false;

  // >>> START  _LocationPopUpPageState.build()  -  draws this screen / widget (its layout)
  Widget build(BuildContext context) {
    if (_checkingPermissions) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_permissionsGranted) {
      // Keep consent and readiness in one route; the readiness screen retains
      // its GPS, current-location, backend submission, and success behavior.
      return LocationErrorScreen();
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
      },
      child: Scaffold(
        backgroundColor: tBackground,
        body: Dialog(
          backgroundColor: tWhite,
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 200,
            height: 470,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Attention!".tr,
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w800,
                        fontSize: isTab(context) ? 20.sp : 22.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rubia collects location data to enable assignment of bookings, real time tracking for ongoing trips even when the app is closed or not in use"
                            .tr,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mulish(
                            fontSize: isTab(context) ? 9.sp : 13.sp,
                            fontWeight: FontWeight.w400,
                            color: tBlack),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        width: 32.w,
                        height: 6.h,
                        child: Button(
                          color: tPrimaryColor,
                          textcolor: tWhite,
                          bottonText: 'Allow'.tr,
                          borderSide: BorderSide(
                            color: tPrimaryColor,
                          ),
                          onTap: (startLoading, stopLoading, btnState) async {
                            startLoading();
                            bool result = await _checkLocationPermission();
                            if (!mounted) return;
                            stopLoading();
                            if (result) {
                              print('true >>>.');
                              print(result);
                              print('true >>>.');
                              setState(() {
                                _permissionsGranted = true;
                              });
                            } else {
                              print('false >>>.');
                              await Twl.forceNavigateTo(
                                  context,
                                  LocationErrorPage(
                                    Locationdetails: result,
                                  ));
                              print(result);
                              print('false >>>.');
                            }

                          },
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "Hint : ",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.mulish(
                                fontSize: isTab(context) ? 9.sp : 13.sp,
                                fontWeight: FontWeight.w400,
                                color: tbrown),
                          ),
                        ],
                      ),
                      Text(
                        "1) Rubia driver App info\n2) App permissions\n3) Location\n4) Allow all the time ",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.mulish(
                            fontSize: isTab(context) ? 9.sp : 13.sp,
                            fontWeight: FontWeight.w400,
                            color: tbrown),
                      ),
                    ],
                  ),

                  // Expanded(
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         "Note : Rubia driver App info ---> App permissions --> Location --> only Allow all the time ".tr,
                  //         maxLines: 4,
                  //         overflow: TextOverflow.ellipsis,
                  //         textAlign: TextAlign.center,
                  //         style: GoogleFonts.mulish(fontSize: isTab(context) ? 9.sp : 13.sp, fontWeight: FontWeight.w400, color: tBlack),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // <<< END    _LocationPopUpPageState.build()

  // >>> START  _LocationPopUpPageState._openLocationPermissionSettings()  -  open location permission settings
  Future<void> _openLocationPermissionSettings() async {
    await openAppSettings();
  }
  // <<< END    _LocationPopUpPageState._openLocationPermissionSettings()
}
// <<< END    class _LocationPopUpPageState
