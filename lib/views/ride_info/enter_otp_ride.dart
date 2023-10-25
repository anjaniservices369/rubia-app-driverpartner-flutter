import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:flutter/material.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../responsive.dart';
import '../../globalWidgets/button.dart';
import '../../providers/background_locator.dart';
import '../odometer/starting_odometer_details.dart';
import 'dart:async';
import 'dart:isolate';
import 'dart:ui';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:location_permissions/location_permissions.dart' as locPermission;

import 'location_callback_handler.dart';
import 'location_service_repository.dart';
import 'file_manager.dart';

class OtpDetailCard extends StatefulWidget {
  const OtpDetailCard({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<OtpDetailCard> createState() => _OtpDetailCardState();
}

class _OtpDetailCardState extends State<OtpDetailCard> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController _otpCodeController = TextEditingController();

  // Future<void> initLocationService() async {
  //   await BackgroundLocation.startLocationService();
  //   BackgroundLocation.getLocationUpdates((location) {
  //     // Handle the location updates here
  //     print("Latitude: ${location.latitude}, Longitude: ${location.longitude}");
  //   });
  // }

  ReceivePort port = ReceivePort();

  String logStr = '';
  bool isRunning = false;
  LocationDto? lastLocation;

  @override
  void initState() {
    super.initState();

    if (IsolateNameServer.lookupPortByName(LocationServiceRepository.isolateName) != null) {
      IsolateNameServer.removePortNameMapping(LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(port.sendPort, LocationServiceRepository.isolateName);
    try {
      port.listen(
        (dynamic data) async {
          await updateUI(data);
        },
      );
      initPlatformState();
    } catch (e) {
      // Handle any exceptions that occur during port listening or initialization.
      print('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateUI(dynamic data) async {
    final log = await FileManager.readLogFile();

    LocationDto? locationDto = (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto!);

    if (mounted)
      setState(() {
        if (data != null) {
          lastLocation = locationDto;
        }
        logStr = log;
      });
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received", msg: "${DateTime.now()}", bigMsg: "${data.latitude}, ${data.longitude}");
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();
    logStr = await FileManager.readLogFile();
    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    // List<dynamic> locationData = [];
    // locationData.add(logStr.toString());
    // print("Array converted ");
    // print(locationData.toString());
    final homePageProvider = Provider.of<HomePageProvider>(context);
    BackgroundLocationProvider _data = Provider.of<BackgroundLocationProvider>(context);
    return Container(
      child: WillPopScope(
        onWillPop: () {
          return Twl.navigateBack(context);
        },
        child: Stack(
          children: [
            // GoogleMapPage(),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: tWhite,
                              boxShadow: [tBoxShadow],
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.0.h),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: tPrimaryColor),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            children: [
                                              Text(widget.bookingDetails['car_model'],
                                                  style: GoogleFonts.mulish(
                                                      color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 14.sp)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tPink),
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                    child: Icon(
                                                  Icons.person,
                                                  color: tPrimaryColor,
                                                )),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Text(widget.bookingDetails['user_details']['first_name'],
                                                style: GoogleFonts.mulish(
                                                    color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 12.sp)),
                                            Text(widget.bookingDetails['user_details']['last_name'],
                                                style: GoogleFonts.mulish(
                                                    color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 12.sp)),
                                            Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                launch(
                                                  "tel://" + widget.bookingDetails['user_details']['contact_no'].toString(),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tgreen),
                                                child: Padding(
                                                    padding: EdgeInsets.all(12.0),
                                                    child: Icon(
                                                      Icons.call,
                                                      color: tWhite,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                Text('Enter OTP',
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 11.sp : 14.sp)),
                                SizedBox(
                                  height: 1.3.h,
                                ),
                                Text('Please ask OTP to the customer',
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 9.sp : 12.sp)),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                                    child: PinCodeTextField(
                                      textStyle: TextStyle(color: tBlack, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 12.sp : 15.sp),
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        color: tBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      length: 4,
                                      obscureText: false,
                                      obscuringCharacter: '*',
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      validator: (v) {
                                        if (v!.length < 4 || v.length == 0) {
                                          return "Otp length did not match";
                                        } else {
                                          return null;
                                        }
                                      },
                                      pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderWidth: 1.5,
                                          borderRadius: BorderRadius.circular(15),
                                          activeColor: tgreen,
                                          selectedColor: tgreen,
                                          selectedFillColor: Color(0xffF4F4F4),
                                          inactiveFillColor: Color(0xffF4F4F4),
                                          inactiveColor: tgreen,
                                          fieldHeight: isTab(context) ? 10.w : 14.w,
                                          fieldWidth: isTab(context) ? 10.w : 14.w,
                                          activeFillColor: Color(0xffF4F4F4)),
                                      cursorColor: tBlack,
                                      animationDuration: Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      controller: _otpCodeController,
                                      keyboardType: TextInputType.number,
                                      onCompleted: (v) {
                                        print("Completed");
                                      },
                                      onTap: () {
                                        print("Pressed");
                                      },
                                      onChanged: (value) {
                                        print(value);
                                      },
                                      beforeTextPaste: (text) {
                                        print("Allowing to paste $text");
                                        return true;
                                      },
                                    )),
                                SizedBox(
                                  height: tDefaultPadding * 3.5,
                                ),
                                // Text(
                                //   logStr,
                                // ),
                                Center(
                                  child: SizedBox(
                                    width: isTab(context) ? 53.w : 53.w,
                                    height: isTab(context) ? 7.5.h : 6.5.h,
                                    child: Button(
                                      color: tPrimaryColor,
                                      textcolor: tWhite,
                                      bottonText: 'Next',
                                      onTap: (startLoading, stopLoading, btnState) async {
                                        startLoading();
                                        homePageProvider.status = '0';
                                        print(logStr.toString());
                                        if (_formKey.currentState!.validate()) {
                                          print('logStr >>>>>>>');

                                          print(logStr.toString());
                                          // _onStart();
                                          bool result = await _onStart();
                                          if (result) {
                                            print(result);
                                            print('Location >>>>>>>>>>>>.');

                                            print('Location 1221378216368126 >>>>>>>>>>>>.');
                                            Map<String, String> param = {
                                              'booking_id': widget.bookingDetails['id'].toString(),
                                              'final_pickup_latitude': widget.bookingDetails['pickup_latitude'].toString(),
                                              'final_pickup_longitude': widget.bookingDetails['pickup_longitude'].toString(),
                                              'otp': _otpCodeController.text,
                                            };
                                            print(param);
                                            var res = await homePageProvider.getDriverArrivedLocation(context, param);
                                            if (res['status'] == 'OK') {
                                              return showDialog(
                                                  context: context,
                                                  builder: (ctx) => Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(logStr.toString()),
                                                          StartingOdometerDetails(
                                                            bookingDetails: widget.bookingDetails,
                                                          )
                                                          // VerificationPopUp(bookingDetails: widget.bookingDetails)
                                                        ],
                                                      ));
                                            } else {
                                              Twl.createAlert(context, 'Oops', res['error'].toString());
                                            }
                                          } else {
                                            Twl.createAlert(context, 'Oops',
                                                "Failed to execute background location.Please enable your location permission to always use");
                                          }

                                          stopLoading();
                                        }
                                        stopLoading();
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onStop() async {
    await BackgroundLocator.unRegisterLocationUpdate();
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
  }

  Future<bool> _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      setState(() {
        isRunning = _isRunning;
        lastLocation = null;
      });
      return true;
    } else {
      print('error');
      // show error
      // Twl.createAlert(context, "error", "Invalid permission.Please grant permission always use");
      // Twl.forceNavigateTo(context, LocationErrorPage());
      return false;
    }
  }

  late final Permission _permission;
  Future<bool> _checkLocationPermission() async {
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
    // return false;
    // if (status) {
    //   return true;
    // } else {
    //   final permission = await locPermission.LocationPermissions().requestPermissions(
    //     permissionLevel: locPermission.LocationPermissionLevel.locationAlways,
    //   );
    //   if (permission == PermissionStatus.granted) {
    //     return true;
    //     // Permission was granted as locationAlways
    //   } else {
    //     return false;
    //     // Permission was not granted
    //   }
    // }
    // print('status');
    // print(status);
    // return false;
    // switch (access) {
    //   case PermissionStatus.unknown:
    //   case PermissionStatus.denied:
    //   case PermissionStatus.restricted:
    //     final permission = await LocationPermissions().requestPermissions(
    //       permissionLevel: LocationPermissionLevel.locationAlways,
    //     );
    //     if (permission == PermissionStatus.granted) {
    //       return true;
    //     } else {
    //       return false;
    //     }
    //     break;
    //   case PermissionStatus.granted:
    //     return true;
    //     break;
    //   default:
    //     return false;
    //     break;
    // }
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings:
            IOSSettings(accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 20, stopWithTerminate: false, showsBackgroundLocationIndicator: true),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            wakeLockTime: 60 * 60 * 60,
            distanceFilter: 20,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                    'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback: LocationCallbackHandler.notificationCallback)));
  }
}

class CustomOtpPinwidget extends StatelessWidget {
  const CustomOtpPinwidget(
      {Key? key, this.selectedFillColor, this.inactiveFillColor, this.otpLength, this.shape, this.fieldHeight, this.fieldWidth, this.inactiveColor})
      : super(key: key);

  final selectedFillColor;
  final inactiveFillColor;
  final otpLength;
  final shape;
  final fieldHeight;
  final fieldWidth;
  final inactiveColor;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpCodeController = TextEditingController();

    bool hasError = false;
    return PinCodeTextField(
      textStyle: TextStyle(color: tBlack, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 12.sp : 15.sp),
      // backgroundColor: Colors.white,
      appContext: context,
      pastedTextStyle: TextStyle(
        color: tBlack,
        fontWeight: FontWeight.w700,
      ),
      length: otpLength,
      obscureText: false,
      obscuringCharacter: '*',

      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < otpLength || v.length == 0) {
          return "Otp length did not match";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
          shape: shape,
          borderWidth: 1.5,
          borderRadius: BorderRadius.circular(15),
          // PinCodeFieldShape.box,
          activeColor: tgreen,
          selectedColor: tgreen,
          selectedFillColor: Color(0xffF4F4F4),
          inactiveFillColor: Color(0xffF4F4F4),
          inactiveColor: tgreen,
          // borderRadius: BorderRadius.circular(8),
          fieldHeight: fieldHeight,
          // isTab(context) ? 10.w : 13.w,
          fieldWidth: fieldWidth,
          //  isTab(context) ? 10.w : 13.w,
          // ignore: dead_code
          activeFillColor: Color(0xffF4F4F4)),
      cursorColor: tBlack,
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      //errorAnimationController: errorController,
      controller: _otpCodeController,
      keyboardType: TextInputType.number,
      // boxShadows: [tBoxShadow],
      onCompleted: (v) {
        print("Completed");
      },
      onTap: () {
        print("Pressed");
      },
      onChanged: (value) {
        print(value);
        // setState(() {
        //   currentText = value;
        // });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");

        return true;
      },
    );
  }
}

class OrderIdCard extends StatefulWidget {
  const OrderIdCard({Key? key}) : super(key: key);

  @override
  State<OrderIdCard> createState() => _OrderIdCardState();
}

class _OrderIdCardState extends State<OrderIdCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.0.h),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: tPrimaryColor),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text('EG65406504',
                          style: GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 14.sp)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tPink),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Icon(
                          Icons.person,
                          color: tPrimaryColor,
                        )),
                      ),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Text('Manikanta chemiti',
                        style: GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 12.sp)),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tgreen),
                      child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.call,
                            color: tWhite,
                          )),
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }
}
