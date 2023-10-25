import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../constants/constants.dart';
import '../../../../globalWidgets/button.dart';
import '../../../../responsive.dart';
import 'locationError/locationError.dart';
import 'location_error_page/location_error_page.dart';

class LocationPopUpPage extends StatefulWidget {
  const LocationPopUpPage({Key? key, this.details}) : super(key: key);
  final details;
  @override
  State<LocationPopUpPage> createState() => _LocationPopUpPageState();
}

class _LocationPopUpPageState extends State<LocationPopUpPage> {
  // void initState() {
  //   super.initState();
  //   new Future.delayed(const Duration(seconds: 3), () async {}).then((value) {
  //     // Twl.forceNavigateTo(context, BottomNavigation());
  //     //here it should navigateto location page
  //     Twl.forceNavigateTo(context, LocationErrorScreen());
  //   });
  // }

  Future<bool> _checkLocationPermission() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var access = await Permission.locationAlways.status;
    print("status");
    print(access);

    bool locationPermissionRequested = prefs.getBool('locationPermissionRequested') ?? false;

    if (!locationPermissionRequested &&
        (access == PermissionStatus.denied ||
            access == PermissionStatus.limited ||
            access == PermissionStatus.permanentlyDenied ||
            access == PermissionStatus.restricted)) {
      final permission = await Permission.locationAlways.request();
      if (permission == PermissionStatus.granted) {
        // await Twl.forceNavigateTo(context, LocationErrorScreen());
        print('true');
        return true;
      } else {
        _openLocationPermissionSettings();
        prefs.setBool('locationPermissionRequested', true);
        return false;
      }
    } else if (access == PermissionStatus.granted) {
      // await Twl.forceNavigateTo(context, LocationErrorScreen());
      print('true');
      return true;
    } else {
      final permission = await Permission.locationAlways.request();
      if (permission == PermissionStatus.granted) {
        // await Twl.forceNavigateTo(context, LocationErrorScreen());
        print('true');
        return true;
      } else {
        _openLocationPermissionSettings();
        prefs.setBool('locationPermissionRequested', true);
        return false;
      }
    }
  }

  @override
  int reason = 0;
  bool ischeckbox = false;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
      },
      child: Scaffold(
        backgroundColor: tBackground,
        body: Dialog(
          backgroundColor: tWhite,
          insetPadding: EdgeInsets.symmetric(horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: 200,
            height: 450,
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
                        style: GoogleFonts.mulish(fontSize: isTab(context) ? 9.sp : 13.sp, fontWeight: FontWeight.w400, color: tBlack),
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
                            if (result) {
                              print('true >>>.');
                              print(result);
                              print('true >>>.');
                              await Twl.forceNavigateTo(context, LocationErrorScreen());
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

                            stopLoading();
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
                            style: GoogleFonts.mulish(fontSize: isTab(context) ? 9.sp : 13.sp, fontWeight: FontWeight.w400, color: tbrown),
                          ),
                        ],
                      ),
                      Text(
                        "1) Rubia driver App info\n2) App permissions\n3) Location\n4) Allow all the time ",
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.mulish(fontSize: isTab(context) ? 9.sp : 13.sp, fontWeight: FontWeight.w400, color: tbrown),
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

  Future<void> _openLocationPermissionSettings() async {
    await openAppSettings();
  }
}
