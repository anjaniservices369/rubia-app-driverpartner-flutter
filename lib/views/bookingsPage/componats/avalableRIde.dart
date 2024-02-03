import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/views/bookingsPage/componats/AcceptedRideDetails.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/earnings/componants/rideinfo.dart';
import 'package:base_project_flutter/views/profilePage/subscription/subscription.dart';
import 'package:base_project_flutter/views/ride_info/car_picture/driverUploadSelfie.dart';
import 'package:base_project_flutter/views/ride_info/ride_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:badges/badges.dart';
import 'package:badges/badges.dart' as badges;
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../responsive.dart';
import '../../profile_review/profile_block.dart';
import '../../profile_review/profile_review.dart';
import 'estimated_fare.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' show cos, sqrt, asin, pi, sin, pow;

class AvalableRide extends StatefulWidget {

  const AvalableRide({
    Key? key,
    this.status,
    this.index,
  }) : super(key: key);
  final status;
  final index;

  @override
  State<AvalableRide> createState() => _AvalableRideState();
}

class _AvalableRideState extends State<AvalableRide> {
  late final BottomNavigation bottomNavigation;
  ScrollController _scrollController = ScrollController();
  List<dynamic> bookingsData = [];
  List<dynamic> earningsData = [];
  bool showBottomSheet = false;
  int page = 0;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  bool isSubscribed = false;
  String errorMessage = '';
  var resNOK;
  DateTime d1 = DateTime.now();
  DateTime d2 = DateTime.now().add(Duration(days: 30));

  late Duration difference = d1.difference(d2);

  DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day, 23, 59, 59);
    return parsedDate;
  }

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    // TODO: implement initState
    super.initState();
    if (mounted) {
      bottomNavigation = BottomNavigation();
      fetchCheckDetails();
      fetchBookings();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        print('Api reHitted');
        fetchBookings();
      }
    }
  }

  List<dynamic> bookingsFilterData = [];
  Future<void> fetchBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      dynamic data = await RideBookingsApi().fetchBookingsList(
          context, page.toString(), widget.status.toString());

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.latitude);

      for (var bdata in data['details']) {
        double distanceInMeters = Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            double.parse(bdata['pickup_latitude']),
            double.parse(bdata['pickup_longitude']));
        print("*******************");
        double distanceInKms = distanceInMeters / 1000;
        print(distanceInKms);
        if (distanceInKms < MAX_DISTANCE) {
          bookingsFilterData.add(bdata);
        }
      }

      print(bookingsFilterData);
      final List<dynamic> newBookings = bookingsFilterData;
      print('newBookings>>>>>>>>>>>>>');
      resNOK = data['status'];
      print(newBookings.toString());
      print('newBookings');
      final paginationData = data['pagination'];

      setState(() {
        bookingsData.addAll(newBookings);
        totalPages = paginationData['total_pages'];
        totalCount = paginationData['total_count'];
        page++;
        isLoading = false;
        errorMessage = '';
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to fetch bookings.';
      });
    }
  }



  var checkDetails;
  var resNok;
  fetchCheckDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checkRes = await UserAPI().checkApi(pref.getString('authCode')!);
    if (checkRes != null && checkRes['status'] == 'OK') {
      if (checkRes['detail'] != null) {

        if (checkRes['detail']['status'] == 0) {
          Twl.navigateTo(context, ProfileBlock());
        }
        if(checkRes['detail']['online_status']==2){
          print("widget.index : ${widget.index}");
          if(widget.index == 1){
            goOnlinealert();
          }
        }

        setState(() {
          checkDetails = checkRes['detail'];
          if(checkDetails['subscription_end']!=''){
            d2 = parseDate(checkDetails['subscription_end']);
            print(checkDetails['subscription_end']);
            print(d2);
            difference = d2.difference(d1);
            print("difference : $difference");
            print("difference in days: ${difference.inDays}");
          }
          if(checkDetails['driver_subscription_status'] == 1){
            isSubscribed = true;
          }else {
            isSubscribed = false;
          }
        });
      }
    }else {
      setState(() {
        resNok = checkDetails['status'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return isLoading ?
    Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: tPrimaryColor,
        ),
      ),
    ) : isSubscribed ?
      Column(
          crossAxisAlignment : CrossAxisAlignment.stretch,
        children: [
          if (difference.inDays < 3 && difference.inDays >=0)
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.red,
              child: Text(
                'Your subscription plan will expire in ${difference.inDays.toString()} days.',
                style: GoogleFonts.mulish(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: isTab(context) ? 9.sp : 12.sp,
              ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              itemCount: bookingsData.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == bookingsData.length) {
                  if (page < totalPages) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return bookingsData.length == 0
                        ? Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Bookings found',
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 12.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                        : Container();
                  }
                }
                if (errorMessage.isNotEmpty)
                  Positioned.fill(
                    child: Container(
                      color: tSecondaryColor,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                var booking = bookingsData[index];
                double? usageHours = double.parse(booking['usage_hours']);

                String usageText;
                if (usageHours != null) {
                  if (usageHours >= 1) {
                    int wholeHours = usageHours.toInt();
                    int wholeMinutes = ((usageHours - wholeHours) * 60).toInt();
                    if (wholeMinutes > 0) {
                      usageText = '$wholeHours hrs $wholeMinutes mins usage';
                    } else {
                      usageText = '$wholeHours hrs usage';
                    }
                  } else {
                    int usageMinutes = (usageHours * 60).toInt();
                    usageText = '$usageMinutes mins usage';
                  }
                } else {
                  usageText =
                  'Usage hours not available'; // Handle the case where 'usage_hours' is null
                }


                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.5.w),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: tWhite,
                              builder: (context) => SingleChildScrollView(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 0),
                                    child: Column(
                                      children: [
                                        Container(
                                          // height: 55.h,
                                            child: AcceptedRideDetails(
                                                booking: booking)),
                                      ],
                                    )),
                              ),
                            );
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: tWhite,
                                  boxShadow: [tBoxShadow],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 2.h,
                                          bottom: 1.h,
                                          left: 2.w,
                                          right: 2.w),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.CALENDORICON,
                                                scale: isTab(context) ? 2.5 : 3.5,
                                              ),
                                              SizedBox(
                                                width: 0.5.w,
                                              ),
                                              Text(
                                                Twl.dateReverseFormate(
                                                    booking['pickup_date']
                                                        .toString()) +
                                                    ', ',
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                              Text(
                                                booking['pickup_time'].toString(),
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                currencySymbol +
                                                    booking['driver_earnings'],
                                                style: GoogleFonts.mulish(
                                                  color: tPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                  isTab(context) ? 16.sp : 15.sp,
                                                ),
                                              )
                                            ],
                                          )
                                          // badges.Badge(
                                          //     badgeStyle: BadgeStyle(
                                          //         badgeColor: Colors.transparent),
                                          //     position: BadgePosition.topEnd(),
                                          //     onTap: () {
                                          //       // showModalBottomSheet(
                                          //       //   isScrollControlled: true,
                                          //       //   // expand: false,
                                          //       //   context: context,
                                          //       //   backgroundColor: Colors.transparent,
                                          //       //   builder: (context) => Padding(
                                          //       //       padding: EdgeInsets.symmetric(
                                          //       //           vertical: 10.0,
                                          //       //           horizontal: 30.0),
                                          //       //       child: Container(
                                          //       //           height: 80.h,
                                          //       //           // height: MediaQuery.of(context).size.height / 1,
                                          //       //           decoration: BoxDecoration(
                                          //       //               borderRadius:
                                          //       //                   BorderRadius.circular(
                                          //       //                       10)),
                                          //       //           child: EstimateWidget(
                                          //       //             estimateDetails: booking,
                                          //       //           ))),
                                          //       // );
                                          //     },
                                          //     badgeContent: Icon(
                                          //       Icons.info_outline,
                                          //       color: tBrown,
                                          //       size: 12,
                                          //     ),
                                          //     child: Text(
                                          //       currencySymbol +
                                          //           booking['estimate_price'].toString(),
                                          //       style: GoogleFonts.mulish(
                                          //         color: tPrimaryColor,
                                          //         fontWeight: FontWeight.bold,
                                          //         fontSize:
                                          //             isTab(context) ? 16.sp : 15.sp,
                                          //       ),
                                          //     )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 2.w, vertical: 0.2.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.TIMERR,
                                                scale: isTab(context) ? 2.9 : 3,
                                              ),
                                              SizedBox(
                                                width: 0.8.w,
                                              ),
                                              Text(
                                                usageText,
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                booking['car_model'].toString() +
                                                    ' ( ',
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                              Text(
                                                booking['car_type'] ==
                                                    CAR_TYPE_AUTOMATIC
                                                    ? 'Automatic'
                                                    : 'Manual',
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                              Text(
                                                ' )',
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 0.2.h),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                booking['trip_type'] ==
                                                    TRIP_TYPE_INTERCITY
                                                    ? Images.INCITY
                                                    : Images.OUTSTETION,
                                                scale: booking['trip_type'] ==
                                                    TRIP_TYPE_INTERCITY
                                                    ? isTab(context)
                                                    ? 2.9
                                                    : 12
                                                    : isTab(context)
                                                    ? 2.9
                                                    : 3,
                                              ),
                                              SizedBox(
                                                width: 0.5.w,
                                              ),
                                              Text(
                                                booking['trip_type'] ==
                                                    TRIP_TYPE_INTERCITY
                                                    ? 'In city'
                                                    : 'Out station',
                                                style: GoogleFonts.mulish(
                                                  color: tbrown,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              booking['rider_type'] ==
                                                  RIDER_TYPE_ONEWAY
                                                  ? Image.asset(
                                                Images.ONEWAY,
                                                scale:
                                                isTab(context) ? 100 : 105,
                                              )
                                                  : Image.asset(
                                                Images.ROUNDTRIPW,
                                                scale: isTab(context) ? 2.9 : 4,
                                              ),
                                              SizedBox(
                                                width: 0.5.w,
                                              ),
                                              Text(
                                                booking['rider_type'] ==
                                                    RIDER_TYPE_ONEWAY
                                                    ? 'One way'
                                                    : 'Round trip',
                                                style: GoogleFonts.mulish(
                                                  color: tbrown,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      'Click here to view more details --->>>',
                                      style: GoogleFonts.mulish(
                                        color: tPrimaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 9.sp : 11.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ]))),
                    ],
                  ),
                );
              }),
          ),
        ],
      )
     :  AlertDialog(
                title: Text("Alert!",style: GoogleFonts.mulish(
                  color: tBlack,
                  fontSize: isTab(context) ? 16.sp : 14.sp,
                  fontWeight: FontWeight.w800,
                ),),
                content: Text("Your subscription is not active. Please subscribe to get rides."),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 90,
                        height: 40,
                        child: PopupButton(
                          borderSide: BorderSide(
                            color: tPrimaryColor,
                          ),
                          textcolor: tPrimaryColor,
                          bottonText: 'cancel',
                          onTap: (startLoading, stopLoading,
                              btnState) async {
                            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Container(
                        width: 90,
                        height: 40,
                        child: PopupButton(
                          borderSide: BorderSide(
                            color: tPrimaryColor,
                          ),
                          textcolor: tPrimaryColor,
                          bottonText: 'Ok',
                          onTap: (startLoading, stopLoading,
                              btnState) async {
                            Twl.navigateTo(context, Subscription());
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
    }

  void goOnlinealert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: GoogleFonts.mulish(
              color: tBlack,
              fontSize: isTab(context) ? 16.sp : 14.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            'Please go Online',
            style: GoogleFonts.mulish(
              color: tBlack,
              fontSize: isTab(context) ? 16.sp : 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Center(
              child: Container(
                child: Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'OK'.tr,
                  borderSide: BorderSide(color: tPrimaryColor),
                  onTap: (startLoading, stopLoading, btnState) async {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        );
      },
    );
  }

  }

