import 'package:action_slider/action_slider.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/earnings/componants/rideinfo.dart';
import 'package:base_project_flutter/views/ride_info/Car_RideEndingData/DriveEndVerification_popup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maps_curved_line/maps_curved_line.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as GeoLatLong;
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/imageConstant.dart';

import '../../../../../responsive.dart';

// import 'componants/demo.dart';
import '../../globalWidgets/emergency_widget.dart';
import '../odometer/ending_odometer_details.dart';
import 'enter_otp_ride.dart';

class CompleteRide extends StatefulWidget {
  const CompleteRide({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<CompleteRide> createState() => _CompleteRideState();
}

class _CompleteRideState extends State<CompleteRide> {
  final _controller = ActionSliderController();
  var status = 0;
  GoogleMapController? mapController;
  GeoLatLong.LatLng? startLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  Set<Marker> markers = Set();
  addMarkers() async {
    BitmapDescriptor markerbitmapdrop = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'assets/icons/back.png',
    );
    print('lat lng');
    markers.add(Marker(
      markerId: MarkerId(startLocation.toString()),
      position: startLocation!, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'location',
        snippet: '',
      ),
      icon: markerbitmapdrop, //Icon for Marker
    ));
  }

  final Set<Polyline> _polylines = Set();
  GoogleMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);
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
    final homePageProvider = Provider.of<HomePageProvider>(context);
    Future<void> launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
        );
      } else {
        print('Could not launch $url');
      }
    }

    return Scaffold(
      backgroundColor: tBackground,
      body: Container(
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
                                  decoration: BoxDecoration(color: tPrimaryColor, borderRadius: BorderRadius.circular(8), boxShadow: [tBoxShadow]),
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
                                        style:
                                            GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 14.sp : 16.sp)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          MapsLauncher.launchCoordinates(
                              double.parse(widget.bookingDetails['drop_latitude']), double.parse(widget.bookingDetails['drop_longitude']));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: 0.4.h),
                          decoration: BoxDecoration(color: tAppbarColor, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(60)),
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
                              Text('Drop location',
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
                          Twl.forceNavigateTo(context, RideInfo(bookingDetails: widget.bookingDetails, isHistoryPage: false));
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
                      Container(
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
                                decoration: BoxDecoration(boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(14), color: tWhite),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(widget.bookingDetails['car_model'],
                                            style: GoogleFonts.mulish(
                                                color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 13.sp)),
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
                                                Text(Twl.dateReverseFormate(widget.bookingDetails['pickup_date']),
                                                    style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: isTab(context) ? 10.sp : 11.sp)),
                                                Text(widget.bookingDetails['pickup_time'],
                                                    style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontWeight: FontWeight.w700,
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
                                        Text(widget.bookingDetails['user_details']['first_name'] + ' ',
                                            style: GoogleFonts.mulish(
                                                color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 12.sp)),
                                        Text(widget.bookingDetails['user_details']['last_name'],
                                            style: GoogleFonts.mulish(
                                                color: tSecondaryColor, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 12.sp)),
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
                                               (widget.bookingDetails['drop_address'] == null  )
                                                  ? widget.bookingDetails['pickup_address']
                                                  : widget.bookingDetails['drop_address'],
                                              style: GoogleFonts.mulish(
                                                color: tSecondaryColor,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context) ? 10.sp : 12.sp,
                                              ),
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
                            Container(
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
                                  child: Text('Complete ride',
                                      style:
                                          GoogleFonts.mulish(color: tWhite, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 11.sp : 14.sp)),
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
                                  homePageProvider.carPictureStatus = '2';
                                  locationProvider.stopLocationUpdates();
                                  // _stopBubble(context);

                                  showDialog(
                                      context: context,
                                      builder: (ctx) => Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              DriveEndVerificationPopUp(
                                                  bookingDetails:
                                                  widget.bookingDetails)
                                            ],
                                          ));
                                  await Future.delayed(const Duration(seconds: 1));
                                  controller.success();
                                  await Future.delayed(const Duration(seconds: 1));
                                  controller.reset();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
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

  // Future<void> _runMethod(
  //   BuildContext context,
  //   Future<void> Function() method,
  // ) async {
  //   try {
  //     await method();
  //   } catch (error) {
  //     // log(
  //     //   name: 'Dash Bubble Playground',
  //     //   error.toString(),
  //     // );

  //     // SnackBars.show(
  //     //   context: context,
  //     //   status: SnackBarStatus.error,
  //     //   message: 'Error: ${error.runtimeType}',
  //     // );
  //   }
  // }

  // Future<void> _stopBubble(BuildContext context) async {
  //   await _runMethod(
  //     context,
  //     () async {
  //       final hasStopped = await DashBubble.instance.stopBubble();
  //       print('weirth23uirh >>>>>>>>');
  //       print(hasStopped);
  //       // SnackBars.show(
  //       //   context: context,
  //       //   status: SnackBarStatus.success,
  //       //   message: hasStopped ? 'Bubble Stopped' : 'Bubble has not Stopped',
  //       // );
  //     },
  //   );
  // }
}
