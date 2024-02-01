import 'package:action_slider/action_slider.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/earnings/componants/rideinfo.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/imageConstant.dart';
import '../../../../../responsive.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/emergency_widget.dart';
import 'enter_otp_ride.dart';
// import 'package:intl/intl.dart';



class RideInfoPage extends StatefulWidget {
  const RideInfoPage({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<RideInfoPage> createState() => _RideInfoPageState();
}

class _RideInfoPageState extends State<RideInfoPage> {

  @override
  void initState() {
    fetchBookingDetails();
    super.initState();
  }

  var bookingDetails;
  var resNOK;
  var txt='';
  var pickUpTime ='';

  fetchBookingDetails() async {
    var res = await RideBookingsApi().fetchBookigDetails(context, widget.bookingDetails['id'].toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('trip_type');
    await prefs.remove('booking_id');
    if (res != null && res['status'] == 'OK') {
      setState(() {
        bookingDetails = res['details'];
        print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
        print(bookingDetails);
        print(bookingDetails['pickup_date']);
        print(bookingDetails['pickup_time']);
        // print(DateFormat('hh:mm a').format(DateTime.now()));
        // print(DateTime.now()
        //     .toString()
        //     .substring(0,10)
        // );

        print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");

        prefs.setString('trip_type', bookingDetails['trip_type'].toString());
        prefs.setString('booking_id', bookingDetails['id'].toString());
      });
    } else {
      setState(() {
        resNOK = res['status'];
      });
    }
  }

  final _controller = ActionSliderController();
  var status = 0;
  final Set<Polyline> _polylines = Set();
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    String pickupLatitude = widget.bookingDetails['pickup_latitude'];
    String pickupLongitude = widget.bookingDetails['pickup_longitude'];
    String dropLatitude = widget.bookingDetails['drop_latitude'] ?? '';
    String dropLongitude = widget.bookingDetails['drop_longitude'] ?? '';
    Set<Marker> markers = {};
    LatLng dropLatLng;
    // Create LatLng objects for pickup and drop coordinates
    LatLng pickupLatLng = LatLng(double.parse(pickupLatitude), double.parse(pickupLongitude));
    if (dropLatitude != null && dropLatitude.isNotEmpty && dropLongitude != null && dropLongitude.isNotEmpty) {
      dropLatLng = LatLng(double.parse(dropLatitude), double.parse(dropLongitude));

      markers.add(
        Marker(
          markerId: MarkerId('pickup'),
          position: pickupLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          // Add any additional properties for the marker
        ),
      );

      markers.add(
        Marker(
          markerId: MarkerId('drop'),
          position: dropLatLng,
          // Add any additional properties for the marker
        ),
      );
      _polylines.add(Polyline(
        polylineId: PolylineId("line 1"),
        visible: true,
        width: 2,
        patterns: [PatternItem.dash(30), PatternItem.gap(10)],
        points: MapsCurvedLines.getPointsOnCurve(pickupLatLng, dropLatLng),
        color: tBlack,
      ));
    } else {
      markers.add(
        Marker(
          markerId: MarkerId('pickup'),
          position: pickupLatLng,
        ),
      );
    }
    Future<void> launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
        );
      } else {
        print('Could not launch $url');
      }
    }



    // DateTime currentTime = DateTime.now();
    // Duration timeDifference = pickUpTime.difference(DateFormat('hh:mm a').parse(time));
    // (bookingDetails['pickup_time']== (timeDifference.inHours <= 1 && timeDifference.inHours >= 0 && timeDifference.inHours <= 0) )

    // print("time difference $timeDifference");
    // bool isOnTime(){
    //   if(bookingDetails['pickup_date'] == DateTime.now().toString().substring(0,10)){
    //    print("date matched");
    //    // print("time difference $timeDifference");
    //     return true;
    //   }else{
    //     print("date do not matched");
    //     // print("time difference $timeDifference");
    //     return false;
    //   }
    //
    // }

    // void showTimeAlert(BuildContext context) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: const Text(
    //           'Warning!!',
    //           style: TextStyle(fontSize: 24,fontWeight: FontWeight.w900, color: Colors.red),
    //         ),
    //         content: const Text(
    //           "Can't start the ride before scheduled time",
    //           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0XFFFF8F0C)),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, 'OK'),
    //             child: const Text(
    //               'OK',
    //               style: TextStyle(fontSize: 20, color: Color(0XFF144272)),
    //             ),
    //           ),
    //         ],
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15.0),
    //         ),
    //       );
    //     },
    //   );
    // }



    final homePageProvider = Provider.of<HomePageProvider>(context);
    return Scaffold(
      backgroundColor: tBackground,
      body: bookingDetails == null
          ? resNOK == 'NOK'
              ? Align(
                  alignment: Alignment.center,
                  child: Text('No data found'),
                )
              : Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: tSecondaryColor,
                  ))
          : Container(
              child: WillPopScope(
                onWillPop: () {
                  return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
                },
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: (controller) {
                        _mapController = controller;
                      },
                      initialCameraPosition: CameraPosition(
                        target: pickupLatLng,
                        zoom: 12.0,
                      ),
                      polylines: _polylines,
                      markers: markers,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        homePageProvider.status != '2'
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await launchURL(CHAT_LINK);
                                    },
                                    child: Container(
                                        width: 25.w,
                                        padding: EdgeInsets.all(16),
                                        margin: EdgeInsets.only(bottom: 80, right: 10),
                                        decoration:
                                            BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(8), boxShadow: [tBoxShadow]),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              Images.PERSONINHEDSET,
                                              scale: isTab(context) ? 2.5 : 3.5,
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text("Help",
                                                style: GoogleFonts.mulish(
                                                    color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 12.sp)),
                                          ],
                                        )),
                                  ),
                                ],
                              )
                            : Container(),
                        homePageProvider.status != '2'
                            ? GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showBarModalBottomSheet(
                                    context: context,
                                    backgroundColor: tWhite,
                                    builder: (context) => Padding(padding: EdgeInsets.symmetric(horizontal: 0), child: Emergencywidget()),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(20.0),
                                        margin: EdgeInsets.only(bottom: 180, right: 10),
                                        decoration: BoxDecoration(color: tRed, shape: BoxShape.circle, boxShadow: [tBoxShadow]),
                                        child: Center(
                                          child: Text("sos",
                                              style: GoogleFonts.mulish(
                                                  color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 14.sp : 16.sp)),
                                        )),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        homePageProvider.status == '2'
                            ? Container()
                            :
                        Text(txt,style: TextStyle(fontSize: 30),),
                        Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      MapsLauncher.launchCoordinates(
                                          double.parse(bookingDetails['pickup_latitude']), double.parse(bookingDetails['pickup_longitude']));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.4.h),
                                      decoration:
                                          BoxDecoration(color: tAppbarColor, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(60)),

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,

                                        children: [

                                          Container(
                                            padding: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(color: tPink, shape: BoxShape.circle, boxShadow: [tBoxShadow]),
                                            child: Image.asset(Images.INFOICONCLRW, scale: isTab(context) ? 2 : 3),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text('Pick up location',
                                              style: GoogleFonts.mulish(
                                                  color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 9.sp : 12.sp)),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                      print(bookingDetails['driver_earnings'].toString());
                                      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                      Twl.forceNavigateTo(context, RideInfo(bookingDetails: bookingDetails, isHistoryPage: false));
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(color: tPrimaryColor, shape: BoxShape.circle, boxShadow: [tBoxShadow]),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(color: tPink, shape: BoxShape.circle, boxShadow: [tBoxShadow]),
                                        child: Image.asset(Images.INFOICONCLR, scale: isTab(context) ? 2 : 3),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            homePageProvider.status == '0'
                                ? Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                        color: tWhite,
                                        boxShadow: [tBoxShadow],
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.0.h),
                                            decoration:
                                                BoxDecoration(boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(14), color: tWhite),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(bookingDetails['car_model'],
                                                        style: GoogleFonts.mulish(
                                                            color: tSecondaryColor,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: isTab(context) ? 10.sp : 13.sp)),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Image.asset(
                                                          Images.CALENDORICON,
                                                          scale: isTab(context) ? 2 : 3.5,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Text(Twl.dateReverseFormate(bookingDetails['pickup_date']),
                                                                style: GoogleFonts.mulish(
                                                                    color: tSecondaryColor,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: isTab(context) ? 10.sp : 11.sp)),
                                                            Text(bookingDetails['pickup_time'],
                                                                style: GoogleFonts.mulish(
                                                                    color: tSecondaryColor,
                                                                    fontWeight: FontWeight.w800,
                                                                    fontSize: isTab(context) ? 10.sp : 11.sp)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tPink),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.person,
                                                        color: tPrimaryColor,
                                                      )),
                                                    ),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    Text(bookingDetails['user_details']['first_name'] ?? "N/A",
                                                        style: GoogleFonts.mulish(
                                                            color: tSecondaryColor,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: isTab(context) ? 10.sp : 12.sp)),
                                                    Text(bookingDetails['user_details']['last_name'] ?? "N/A",
                                                        style: GoogleFonts.mulish(
                                                            color: tSecondaryColor,
                                                            fontWeight: FontWeight.w700,
                                                            fontSize: isTab(context) ? 10.sp : 12.sp)),
                                                    Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        launch(
                                                          "tel://" + widget.bookingDetails['user_details']['contact_no'].toString(),
                                                        );
                                                      },
                                                      child: Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tgreen),
                                                          child: Icon(
                                                            Icons.call,
                                                            color: tWhite,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: tPink),
                                                      child: Center(
                                                          child: Icon(
                                                        Icons.location_pin,
                                                        color: tPrimaryColor,
                                                      )),
                                                    ),
                                                    SizedBox(
                                                      width: 3.w,
                                                    ),
                                                    Container(
                                                      child: Expanded(
                                                        child: Text(
                                                          bookingDetails['pickup_address'],
                                                          style: GoogleFonts.mulish(
                                                              color: tSecondaryColor,
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: isTab(context) ? 10.sp : 12.sp),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                          height: 1.8.h,
                                        ),
                                        bookingDetails['status'] == 2
                                            ? Container(
                                                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.h),
                                                child: ActionSlider.custom(
                                                  toggleMargin: EdgeInsets.zero,
                                                  controller: _controller,
                                                  toggleWidth: 60.0,
                                                  height: 60.0,
                                                  backgroundColor: tPrimaryColor,
                                                  foregroundChild: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: tPink,
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        size: 30,
                                                        color: tPrimaryColor,
                                                      )),
                                                  foregroundBuilder: (context, state, child) => child!,
                                                  backgroundChild: Center(
                                                    child: Text('Go for pickup',
                                                        style: GoogleFonts.mulish(
                                                            color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 11.sp : 14.sp)),
                                                  ),
                                                  backgroundBuilder: (context, state, child) => ClipRect(
                                                      child: OverflowBox(
                                                          maxWidth: state.standardSize.width,
                                                          maxHeight: state.toggleSize.height,
                                                          minWidth: state.standardSize.width,
                                                          minHeight: state.toggleSize.height,
                                                          child: child!)),
                                                  backgroundBorderRadius: BorderRadius.circular(12),
                                                  action: (controller) async {
                                                    controller.loading();
                                                    await Future.delayed(const Duration(seconds: 1));
                                                    controller.success();
                                                    await Future.delayed(const Duration(seconds: 1));
                                                    controller.reset();
                                                    setState(() {
                                                      // status = 1;
                                                      // homePageProvider.status = '1';
                                                    });
                                                    Map<String, String> param = {
                                                      'booking_id': widget.bookingDetails['id'].toString(),
                                                    };
                                                    print(param);
                                                    var res = await homePageProvider.fetchDriverPickupDetails(context, param);
                                                    if (res['status'] == 'OK') {
                                                      setState(() {
                                                        bookingDetails['status'] = STATUS_GO_FOR_PICKUP;
                                                      });
                                                    } else {
                                                      Twl.createAlert(context, 'Oops', res['error'].toString());
                                                    }
                                                  },
                                                ),
                                              )
                                            : bookingDetails['status'] == 4
                                                ? Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.h),
                                                    child: ActionSlider.custom(
                                                      toggleMargin: EdgeInsets.zero,
                                                      controller: _controller,
                                                      toggleWidth: 60.0,
                                                      height: 60.0,
                                                      backgroundColor: tPrimaryColor,
                                                      foregroundChild: DecoratedBox(
                                                          decoration: BoxDecoration(
                                                            color: tPink,
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                          child: Icon(
                                                            Icons.arrow_forward,
                                                            size: 30,
                                                            color: tPrimaryColor,
                                                          )),
                                                      foregroundBuilder: (context, state, child) => child!,
                                                      backgroundChild: Center(
                                                        child: Text('Arrived Location',
                                                            style: GoogleFonts.mulish(
                                                                color: tWhite,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: isTab(context) ? 11.sp : 14.sp)),
                                                      ),
                                                      backgroundBuilder: (context, state, child) => ClipRect(
                                                          child: OverflowBox(
                                                              maxWidth: state.standardSize.width,
                                                              maxHeight: state.toggleSize.height,
                                                              minWidth: state.standardSize.width,
                                                              minHeight: state.toggleSize.height,
                                                              child: child!)),
                                                      backgroundBorderRadius: BorderRadius.circular(12),
                                                      action: (controller) async {
                                                        try {

                                                          controller.loading();

                                                          Position driverLocation = await Geolocator.getCurrentPosition();

                                                          double distanceInMeters = await Geolocator.distanceBetween(
                                                            driverLocation.latitude,
                                                            driverLocation.longitude,
                                                            double.parse(bookingDetails['pickup_latitude']),
                                                            double.parse(bookingDetails['pickup_longitude']),
                                                          );

                                                          if (distanceInMeters <= 300) {
                                                            await Future.delayed(const Duration(seconds: 1));
                                                            controller.success();
                                                            await Future.delayed(const Duration(seconds: 1));
                                                            controller.reset();
                                                            setState(() {
                                                              status = 1;
                                                              homePageProvider.status = '2';
                                                            });
                                                          } else {
                                                            showRadiusError();
                                                          }
                                                        } catch (e) {
                                                          showErrorDialog();
                                                          print('Error fetching location: $e');

                                                        }finally{
                                                          controller.reset();
                                                        }
                                                      },

                                                    ),
                                                  )
                                                : Container()
                                      ],
                                    ),
                                  )
                                : homePageProvider.status == '2'
                                    ? OtpDetailCard(bookingDetails: bookingDetails)
                                    : Container(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void showErrorDialog() {
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
            'Please Enable location Services or please check your internet',
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

  void showRadiusError() {
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
            'You are not within 300 meters of the pickup location.',
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


//var time = bookingDetails['pickup_time'];
//DateTime fullpickupTime = DateFormat('hh:mm a').parse(time);
//pickUpTime = DateFormat('hh:mm a').format(fullpickupTime);
//print("pick up time object >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> :$pickUpTime");
// if(isOnTime()){
// // if(false){
//   status = 1;
//   homePageProvider.status = '2';
// }else{
//   showTimeAlert(context);
// }
