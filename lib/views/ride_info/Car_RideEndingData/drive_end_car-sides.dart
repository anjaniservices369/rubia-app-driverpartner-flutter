import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/views/ride_info/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import '../../../api_services/rideBookingsApi.dart';
import '../../../background_services/background_services.dart';
import '../../../constants/imageConstant.dart';
import '../../../constants/stetuesConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../providers/hoempageProvider.dart';
import '../../../providers/locationProvider.dart';
import '../../../responsive.dart';
import '../../bill_details/bill_details.dart';
import 'package:location/location.dart' as loct;
import '../location_callback_handler.dart';
import '../location_service_repository.dart';

import 'package:background_locator_2/settings/android_settings.dart';
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'driverEndUploadSelfie.dart';

class DriveEndCarSides extends StatefulWidget {
  const DriveEndCarSides({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<DriveEndCarSides> createState() => _DriveEndCarSidesState();
}

class _DriveEndCarSidesState extends State<DriveEndCarSides> {
  late BackgroundService backgroundService;
  final _formKey = new GlobalKey<FormState>();
  var firstImg;
  var secoundImg;
  var thirdImg;
  var fourthImg;
  var fivthImg;
  var sixthImg;
  List allImg = [];
  bool firstImgLoading = false;
  bool secoundImgLoading = false;
  bool thirdImgLoading = false;
  bool fourthImgLoading = false;
  bool fivthImgLoading = false;
  bool sixthImgLoading = false;

  // final Location location = Location();
  var _locationAddress;

  @override
  // void dispose() {
  //   BackgroundLocation.stopLocationService();
  //   super.dispose();
  // }
  ReceivePort port = ReceivePort();

  String logStr = '';
  bool isRunning = false;
  LocationDto? lastLocation;

  @override
  void initState() {
    super.initState();
    backgroundService = BackgroundService();
    if (IsolateNameServer.lookupPortByName(
        LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);
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

//     List<String> entries = log.split(', ');

// // Initialize an empty list to store the transformed log
//     List<Map<String, double>> transformedLog = [];

// // Loop through the entries and transform them into dictionaries
//     for (String entry in entries) {
//       // Split the entry into "lat" and "lng" components
//       List<String> components = entry.split(', ');

//       // Extract "lat" and "lng" values and convert them to double
//       double lat = double.parse(components[0].substring(5));
//       double lng = double.parse(components[1].substring(5));

//       // Create a dictionary for this entry and add it to the transformedLog list
//       transformedLog.add({"lat": lat, "lng": lng});
//     }
  }

  Future<void> updateUI(dynamic data) async {
    final log = await FileManager.readLogFile();

    LocationDto? locationDto =
    (data != null) ? LocationDto.fromJson(data) : null;
    await _updateNotificationText(locationDto!);

    if (mounted)
      setState(() {
        if (data != null) {
          lastLocation = locationDto;
        }
        logStr = log;
      });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
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

  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);

    LocationProvider _locationData = Provider.of<LocationProvider>(context);
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: tBackground,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(context,
                DriverEndUploadSelfie(bookingDetails: widget.bookingDetails));
          },
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context,
              DriverEndUploadSelfie(bookingDetails: widget.bookingDetails));
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadiusDirectional.circular(12)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 16),
                            decoration: BoxDecoration(
                                color: tWhite,
                                boxShadow: [tBoxShadow],
                                borderRadius:
                                BorderRadiusDirectional.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Take car picture".tr,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: isTab(context) ? 18.sp : 20.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Before you End ride upload images of car".tr,
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              firstImgLoading = true;
                                            });
                                            String imageUrl =
                                            await Twl().uploadImage();
                                            if (imageUrl != null) {
                                              print(
                                                  'Uploaded image URL: $imageUrl');
                                              setState(() {
                                                firstImg = imageUrl;
                                                firstImgLoading = false;
                                              });
                                              _storedData.rideEndedImagesList
                                                  .add({
                                                "booking_id": widget
                                                    .bookingDetails['id']
                                                    .toString(),
                                                "image": firstImg,
                                                "image_type":
                                                image_type_front.toString(),
                                                "type":
                                                type_after_ride.toString()
                                              });

                                              print(_storedData
                                                  .rideEndedImagesList
                                                  .toString());
                                            } else {
                                              print(
                                                  'Image upload failed or no image selected.');
                                              setState(() {
                                                firstImg = null;
                                              });
                                            }
                                          },
                                          child: firstImg == null
                                              ? firstImgLoading == false
                                              ? Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                border: Border.all(
                                                    color: tlightGray,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets
                                                        .all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child:
                                                    Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images
                                                          .CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Align(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            CircularProgressIndicator(
                                              color: tAppbarColor,
                                            ),
                                          )
                                              : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                color: tlightGray,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      firstImg,
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child: Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images.CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                secoundImgLoading = true;
                                              });

                                              String imageUrl =
                                              await Twl().uploadImage();
                                              if (imageUrl != null) {
                                                print(
                                                    'Uploaded image URL: $imageUrl');
                                                setState(() {
                                                  secoundImg = imageUrl;
                                                  secoundImgLoading = false;
                                                });
                                                _storedData.rideEndedImagesList
                                                    .add({
                                                  "booking_id": widget
                                                      .bookingDetails['id']
                                                      .toString(),
                                                  "image": secoundImg,
                                                  "image_type": image_type_back
                                                      .toString(),
                                                  "type":
                                                  type_after_ride.toString()
                                                });

                                                print(_storedData
                                                    .rideEndedImagesList
                                                    .toString());
                                              } else {
                                                print(
                                                    'Image upload failed or no image selected.');
                                                setState(() {
                                                  secoundImg = null;
                                                });
                                              }
                                            },
                                            child: secoundImg == null
                                                ? secoundImgLoading == false
                                                ? Container(
                                              height: 13.h,
                                              width: 38.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      15),
                                                  border: Border.all(
                                                      color:
                                                      tlightGray,
                                                      width: 2)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets
                                                          .all(6),
                                                      decoration: BoxDecoration(
                                                          color:
                                                          tWhite,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                      child:
                                                      Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images
                                                            .CAMERAICON,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Align(
                                              alignment:
                                              Alignment.center,
                                              child:
                                              CircularProgressIndicator(
                                                color: tAppbarColor,
                                              ),
                                            )
                                                : Container(
                                              height: 13.h,
                                              width: 38.w,
                                              decoration: BoxDecoration(
                                                  color: tlightGray,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        secoundImg,
                                                      ),
                                                      fit: BoxFit.cover),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(12)),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding:
                                                      EdgeInsets.all(
                                                          6),
                                                      decoration: BoxDecoration(
                                                          color: tWhite,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              4)),
                                                      child: Image.asset(
                                                        // Images.FRONTCAMERA,
                                                        Images.CAMERAICON,
                                                        scale: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              thirdImgLoading = true;
                                            });
                                            String imageUrl =
                                            await Twl().uploadImage();
                                            if (imageUrl != null) {
                                              print(
                                                  'Uploaded image URL: $imageUrl');
                                              setState(() {
                                                thirdImg = imageUrl;
                                                thirdImgLoading = false;
                                              });
                                              _storedData.rideEndedImagesList
                                                  .add({
                                                "booking_id": widget
                                                    .bookingDetails['id']
                                                    .toString(),
                                                "image": thirdImg,
                                                "image_type":
                                                image_type_side_one
                                                    .toString(),
                                                "type":
                                                type_after_ride.toString()
                                              });

                                              print(_storedData
                                                  .rideEndedImagesList
                                                  .toString());
                                            } else {
                                              print(
                                                  'Image upload failed or no image selected.');
                                              setState(() {
                                                thirdImg = null;
                                              });
                                            }
                                          },
                                          child: thirdImg == null
                                              ? thirdImgLoading == false
                                              ? Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                border: Border.all(
                                                    color: tlightGray,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets
                                                        .all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child:
                                                    Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images
                                                          .CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Align(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            CircularProgressIndicator(
                                              color: tAppbarColor,
                                            ),
                                          )
                                              : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                color: tlightGray,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      thirdImg,
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child: Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images.CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              fourthImgLoading = true;
                                            });
                                            String imageUrl =
                                            await Twl().uploadImage();
                                            if (imageUrl != null) {
                                              print(
                                                  'Uploaded image URL: $imageUrl');
                                              setState(() {
                                                fourthImg = imageUrl;
                                                fourthImgLoading = false;
                                              });
                                              _storedData.rideEndedImagesList
                                                  .add({
                                                "booking_id": widget
                                                    .bookingDetails['id']
                                                    .toString(),
                                                "image": fourthImg,
                                                "image_type":
                                                image_type_side_two
                                                    .toString(),
                                                "type":
                                                type_after_ride.toString()
                                              });

                                              print(_storedData
                                                  .rideEndedImagesList
                                                  .toString());
                                            } else {
                                              print(
                                                  'Image upload failed or no image selected.');
                                              setState(() {
                                                firstImg = null;
                                              });
                                            }
                                          },
                                          child: fourthImg == null
                                              ? fourthImgLoading == false
                                              ? Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                border: Border.all(
                                                    color: tlightGray,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets
                                                        .all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child:
                                                    Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images
                                                          .CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Align(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            CircularProgressIndicator(
                                              color: tAppbarColor,
                                            ),
                                          )
                                              : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                color: tlightGray,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      fourthImg,
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child: Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images.CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Take any Damage picture".tr,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: isTab(context) ? 18.sp : 20.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              fivthImgLoading = true;
                                            });
                                            String imageUrl =
                                            await Twl().uploadImage();
                                            if (imageUrl != null) {
                                              print(
                                                  'Uploaded image URL: $imageUrl');
                                              setState(() {
                                                fivthImg = imageUrl;
                                                fivthImgLoading = false;
                                              });
                                              _storedData.rideEndedImagesList
                                                  .add({
                                                "booking_id": widget
                                                    .bookingDetails['id']
                                                    .toString(),
                                                "image": fivthImg,
                                                "image_type": image_type_damages
                                                    .toString(),
                                                "type":
                                                type_after_ride.toString()
                                              });

                                              print(_storedData
                                                  .rideEndedImagesList
                                                  .toString());
                                            } else {
                                              print(
                                                  'Image upload failed or no image selected.');
                                              setState(() {
                                                fivthImg = null;
                                              });
                                            }
                                          },
                                          child: fivthImg == null
                                              ? fivthImgLoading == false
                                              ? Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                border: Border.all(
                                                    color: tlightGray,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets
                                                        .all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child:
                                                    Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images
                                                          .CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Align(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            CircularProgressIndicator(
                                              color: tAppbarColor,
                                            ),
                                          )
                                              : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                color: tlightGray,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      fivthImg,
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child: Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images.CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            setState(() {
                                              sixthImgLoading = true;
                                            });
                                            String imageUrl =
                                            await Twl().uploadImage();
                                            if (imageUrl != null) {
                                              print(
                                                  'Uploaded image URL: $imageUrl');
                                              setState(() {
                                                sixthImg = imageUrl;
                                                sixthImgLoading = false;
                                              });
                                              if (_storedData
                                                  .rideEndedImagesList
                                                  .contains({
                                                "booking_id": widget
                                                    .bookingDetails['id']
                                                    .toString(),
                                                "image": sixthImg,
                                                "image_type": image_type_damages
                                                    .toString(),
                                                "type":
                                                type_after_ride.toString()
                                              })) {
                                                _storedData.rideEndedImagesList
                                                    .remove({
                                                  "booking_id": widget
                                                      .bookingDetails['id']
                                                      .toString(),
                                                  "image": sixthImg,
                                                  "image_type":
                                                  image_type_damages
                                                      .toString(),
                                                  "type":
                                                  type_after_ride.toString()
                                                });
                                              } else {
                                                _storedData.rideEndedImagesList
                                                    .add({
                                                  "booking_id": widget
                                                      .bookingDetails['id']
                                                      .toString(),
                                                  "image": sixthImg,
                                                  "image_type":
                                                  image_type_damages
                                                      .toString(),
                                                  "type":
                                                  type_after_ride.toString()
                                                });
                                              }

                                              print(_storedData
                                                  .rideEndedImagesList
                                                  .toString());
                                            } else {
                                              print(
                                                  'Image upload failed or no image selected.');
                                              setState(() {
                                                sixthImg = null;
                                              });
                                            }
                                          },
                                          child: sixthImg == null
                                              ? sixthImgLoading == false
                                              ? Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(15),
                                                border: Border.all(
                                                    color: tlightGray,
                                                    width: 2)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets
                                                        .all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child:
                                                    Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images
                                                          .CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Align(
                                            alignment:
                                            Alignment.center,
                                            child:
                                            CircularProgressIndicator(
                                              color: tAppbarColor,
                                            ),
                                          )
                                              : Container(
                                            height: 13.h,
                                            width: 38.w,
                                            decoration: BoxDecoration(
                                                color: tlightGray,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      sixthImg,
                                                    ),
                                                    fit: BoxFit.cover),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    12)),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    padding:
                                                    EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: tWhite,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            4)),
                                                    child: Image.asset(
                                                      // Images.FRONTCAMERA,
                                                      Images.CAMERAICON,
                                                      scale: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Button(
                // height: 7.h,
                // width: 55.w,
                // color: tBlack,
                  textcolor: tWhite,
                  bottonText: 'save'.tr,

                  // boxshadow: [tButtonBoxshadow],
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();

                    loct.Location location = new loct.Location();
                    loct.LocationData _locationData =
                    await location.getLocation();
                    print('addresses;;sdfdsf;');
                    GeoData data = await Geocoder2.getDataFromCoordinates(
                        latitude: _locationData.latitude ?? 0.0,
                        longitude: _locationData.longitude ?? 0.0,
                        googleMapApiKey: mapKey);
                    print('coordinates'.toString());
                    print(data.toString());
                    print('coordinates'.toString());
                    print('addresses');
                    print(data.address);
                    print('addresses');
                    var first = data;
                    setState(() {
                      _locationAddress =
                      "${first.address}";
                    });
                    //check delivery
                    print('first');

                    print(_locationAddress);
                    print('3269326982698937197');
                    print('first');

                    // 'lat_long_route_map':
                    //         jsonEncode(_data.locationEntries).toString();
                    // LocationService().stopListeningForLocation();
                    if (_locationAddress != null) {
                      stopLoading();
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: true,
                          title:
                          'Are you sure you want to complete ride with this location',
                          desc: _locationAddress.toString(),
                          btnOkOnPress: () async {
                            startLoading();
                            print(_storedData.rideEndedImagesList.toString());

                            Map<String, String> params = {
                              'json_data':
                              jsonEncode(_storedData.rideEndedImagesList)
                                  .toString(),
                            };

                            var res = await RideBookingsApi()
                                .getVehicleVerficationDetails(context, params);
                            // LocationServiceProvider _data = Provider.of<LocationServiceProvider>(context, listen: false);
                            print('lat and long >>>>>>>>>>>>>');
                            // onStop();
                            // _onStart();
                            // print(logStr.toString());

                            var databasesPath = await getDatabasesPath();
                            String path = join(databasesPath, 'location_database.db');
                            Database database = await openDatabase(path, version: 1,
                                onCreate: (Database db, int version) async {
                                  await db.execute(
                                      'CREATE TABLE IF NOT EXISTS locations (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, timestamp INTEGER)');
                                });

                            List<Map<String, dynamic>> result = await database.query('locations');

                            List<String> locationStrings = result.map((data) =>
                            "${data['latitude']},${data['longitude']}").toList();


                            print("cordinates>>>>>>>>>>>>>");
                            print(locationStrings);

                            List<Map<String, String>> formattedCoordinates = [];

                            for (int i = 0; i < result.length; i++) {
                              double lat = result[i]['latitude'];
                              double lng = result[i]['longitude'];

                              formattedCoordinates.add({
                                'lat': lat.toString(),
                                'lng': lng.toString(),
                              });
                            }

                            formattedCoordinates.add({
                              'lat': _locationData.latitude.toString(),
                              'lng': _locationData.longitude.toString(),
                            });

                            // Encode all coordinates into JSON
                            String jsonResult = jsonEncode(formattedCoordinates);

                            print(jsonResult);


                            if (res != null && res['status'] == 'OK') {
                              Map<String, String> params1 = {
                                'booking_id': widget.bookingDetails['id'].toString(),
                                'final_drop_latitude': _locationData.latitude.toString(),
                                'final_drop_longitude': _locationData.longitude.toString(),
                                'final_drop_address': _locationAddress,
                                'lat_long_route_map': jsonResult,
                              };

                              log(jsonResult.toString());

                              print('stop services >>>>>>>>>>');

                              var res1 = await RideBookingsApi().completeRideApi(context, params1);
                              print('res1----------------');
                              print(res1);
                              print('res1----------------------------------');
                              if (res1 != null && res1['status'] == 'OK') {

                                // Clear the SQLite data after successfully storing in backend
                                await database.delete('locations');
                                FileManager.clearLogFile();

                                // Checkingggg if the locations table is deleted
                                List<Map<String, dynamic>> checkDeletion = await database.query('locations');
                                if (checkDeletion.isEmpty) {
                                  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                  print('The locations table is deleted.');
                                  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                } else {
                                  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                  print('locations table NOTTTTTTTTT deleted');
                                  print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                }

                                backgroundService.stopService();
                                setState(() {
                                  logStr = '';
                                });


                                if (firstImg != '' && firstImg != null &&
                                    secoundImg != '' && secoundImg != null &&
                                    thirdImg != '' && thirdImg != null &&
                                    fourthImg != '' && fourthImg != null) {
                                  _storedData.rideEndedImagesList.clear();
                                  _storedData.carPictureStatus = '0';

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('Sucessfully Updated'),
                                  ));
                                  startLoading();
                                  Twl.forceNavigateTo(
                                      context,
                                      BillDetailsPage(
                                          bookingDetails:
                                          widget.bookingDetails));
                                } else {
                                  stopLoading();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text('All fields are manditory'),
                                  ));
                                  stopLoading();
                                }
                              } else {
                                stopLoading();
                                Twl.createAlert(context, 'Oops', res1['error']);
                                stopLoading();
                              }
                            } else {
                              stopLoading();
                              Twl.createAlert(context, 'Oops', res['error']);
                              stopLoading();
                            }
                          },
                          btnOkColor: tPrimaryColor,
                          btnCancelOnPress: () {
                            Twl.navigateBack(context);
                          },
                          btnOkIcon: Icons.done,
                          btnCancelIcon: Icons.cancel,
                          btnCancelColor: Colors.red)
                        ..show();
                    } else {
                      Twl.createAlert(
                          context, 'Oops', 'Unable to get location');
                    }
                  }),
              SizedBox(
                height: 2.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onStop() async {
    // await BackgroundLocator.unRegisterLocationUpdate();
    // final _isRunning = await BackgroundLocator.isServiceRunning();
    // setState(() {
    //   isRunning = _isRunning;
    // });
  }

  void _onStart() async {
    if (await _checkLocationPermission()) {
      await _startLocator();
      final _isRunning = await BackgroundLocator.isServiceRunning();

      setState(() {
        isRunning = _isRunning;
        lastLocation = null;
      });
    } else {
      // show error
    }
  }

  Future<bool> _checkLocationPermission() async {
    final access = await LocationPermissions().checkPermissionStatus();
    switch (access) {
      case PermissionStatus.unknown:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        final permission = await LocationPermissions().requestPermissions(
          permissionLevel: LocationPermissionLevel.locationAlways,
        );
        if (permission == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
        break;
      case PermissionStatus.granted:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  Future<void> _startLocator() async {
    Map<String, dynamic> data = {'countInit': 1};
    return await BackgroundLocator.registerLocationUpdate(
        LocationCallbackHandler.callback,
        initCallback: LocationCallbackHandler.initCallback,
        initDataCallback: data,
        disposeCallback: LocationCallbackHandler.disposeCallback,
        iosSettings: IOSSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            distanceFilter: 0,
            stopWithTerminate: true),
        autoStop: false,
        androidSettings: AndroidSettings(
            accuracy: LocationAccuracy.NAVIGATION,
            interval: 5,
            distanceFilter: 0,
            client: LocationClient.google,
            androidNotificationSettings: AndroidNotificationSettings(
                notificationChannelName: 'Location tracking',
                notificationTitle: 'Start Location Tracking',
                notificationMsg: 'Track location in background',
                notificationBigMsg:
                'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
                notificationIconColor: Colors.grey,
                notificationTapCallback:
                LocationCallbackHandler.notificationCallback)));
  }
}
