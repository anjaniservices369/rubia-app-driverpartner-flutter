// ----------------------------------------------------------------------
// Accepted rides list
//
// Rides the driver has accepted (status 12).
// ----------------------------------------------------------------------
import 'dart:async';
import 'dart:convert';

import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/BookingStatusConstants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/providers/hoempageProvider.dart';
import 'package:base_project_flutter/views/bill_details/bill_details.dart';
import 'package:base_project_flutter/views/ride_info/Car_RideEndingData/driverEndUploadSelfie.dart';
import 'package:base_project_flutter/views/ride_info/car_picture/driverUploadSelfie.dart';
import 'package:base_project_flutter/views/ride_info/carnumberadd.dart';
import 'package:base_project_flutter/views/ride_info/completer_ride.dart';
import 'package:base_project_flutter/views/ride_info/ride_info.dart';
import 'package:flutter/material.dart';
import 'package:base_project_flutter/globalWidgets/viewDetailsButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';

import '../../../responsive.dart';

// import '../../profilePage/components/notifactionPage.dart';
// import 'rideDetailsView/rideDetailsView.dart';

// >>> START  class AcceptedRides
class AcceptedRides extends StatefulWidget {
  const AcceptedRides({
    Key? key,
    this.status,
  }) : super(key: key);
  final status;

  @override
  State<AcceptedRides> createState() => _AcceptedRidesState();
}
// <<< END    class AcceptedRides

// >>> START  class _AcceptedRidesState
class _AcceptedRidesState extends State<AcceptedRides> {
  ScrollController _scrollController = ScrollController();
  List<dynamic> bookingsData = [];
  bool showBottomSheet = false;
  int page = 0;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  String errorMessage = '';
  var resNOK;
  Timer? _refreshTimer;

  // >>> START  _AcceptedRidesState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);

    // TODO: implement initState
    super.initState();
    if (mounted) {
      setState(() {
        fetchBookings();
      });
    }
    // A ride on this list can change while it is open: the customer cancels it, or it is moved along. Ask the server again every
    // few seconds so the list follows (a cancelled ride leaves it and shows under Cancelled rides).
    _refreshTimer = Timer.periodic(const Duration(seconds: 8), (_) => _silentRefresh());
  }
  // <<< END    _AcceptedRidesState.initState()

  // >>> START  _AcceptedRidesState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _refreshTimer?.cancel();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  // <<< END    _AcceptedRidesState.dispose()

  // >>> START  _AcceptedRidesState._silentRefresh()  -  silent refresh
  /// Skipped while a load is running or when the driver has scrolled on to later pages (their place in the list is kept).
  Future<void> _silentRefresh() async {
    if (!mounted || isLoading || page > 1) return;
    try {
      final data = await RideBookingsApi().fetchBookingsList(context, '0', widget.status.toString());
      if (!mounted || data is! Map) return;
      // The server answers "No Bookings found" (no list) when the last ride on this tab has moved on: that is an empty list.
      final none = data['status'] == 'NOK' &&
          data['details'] is! List &&
          data.toString().toLowerCase().contains('no bookings');
      if (!none && data['details'] is! List) return;
      final fresh = none ? <dynamic>[] : List<dynamic>.from(data['details']);
      if (jsonEncode(fresh) == jsonEncode(bookingsData)) return;
      final pagination = data['pagination'];
      setState(() {
        bookingsData = fresh;
        if (pagination is Map) {
          totalPages = pagination['total_pages'] ?? totalPages;
          totalCount = pagination['total_count'] ?? totalCount;
        }
        if (none) {
          totalPages = 0;
          totalCount = 0;
          resNOK = 'NOK'; // makes the list show "No Bookings found"
        }
        page = 1;
        errorMessage = '';
      });
    } catch (_) {
      // a missed refresh is fine; the next one tries again
    }
  }
  // <<< END    _AcceptedRidesState._silentRefresh()

  // >>> START  _AcceptedRidesState._scrollListener()  -  scroll listener
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        print('Api reHitted');
        fetchBookings();
      }
    }
  }
  // <<< END    _AcceptedRidesState._scrollListener()

  // >>> START  _AcceptedRidesState.fetchBookings()  -  fetch bookings
  Future<void> fetchBookings() async {
    setState(() {
      isLoading = true;
    });

    try {
      dynamic data = await RideBookingsApi().fetchBookingsList(context, page.toString(), widget.status.toString());

      final List<dynamic> newBookings = data['details'];
      resNOK = data['status'];
      print('newBookings');
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
  // <<< END    _AcceptedRidesState.fetchBookings()

  // >>> START  _AcceptedRidesState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    HomePageProvider _storedData = Provider.of<HomePageProvider>(context);
    return isLoading?
    Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: tPrimaryColor,
        ),
      ),
    )
    :ListView.builder(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: bookingsData.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == bookingsData.length) {
            if (page < totalPages) {
              print('here>>>>>>>>>>>>');
              print(page);
              print(totalPages);
              return Center(child: CircularProgressIndicator());
            } else {
              return resNOK == 'NOK'
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
                  //   Text(
                  //     'No data found',
                  //     style: GoogleFonts.mulish(
                  //       color: tSecondaryColor,
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: isTab(context) ? 9.sp : 12.sp,
                  //     ),
                  //   ),
                  // )
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
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.5.w),
            child: GestureDetector(
                onTap: () {
                  booking['status'] == STATUS_RIDE_COMPLETED
                      ? Twl.navigateTo(context, BillDetailsPage(bookingDetails: booking))
                      : _storedData.carPictureStatus == '2'
                          ? Twl.forceNavigateTo(
                              context,
                              DriverEndUploadSelfie(
                                bookingDetails: booking,
                              ))
                          : booking['status'] == STATUS_START_RIDE
                              ? Twl.forceNavigateTo(context, CompleteRide(bookingDetails: booking))
                              : _storedData.carPictureStatus == '1'
                                  ? Twl.forceNavigateTo(context, AddCarNumber(bookingDetails: booking))
                                  : booking['status'] == STATUS_ARRIVED_LOCATION
                                      ? Twl.forceNavigateTo(context, DriverUploadSelfie(bookingDetails: booking))
                                      : Twl.forceNavigateTo(context, RideInfoPage(bookingDetails: booking));
                },
                child: Container(
                    decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(10)),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.h, bottom: 1.h, left: 3.5.w, right: 3.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Id: #' + booking['id'].toString(),
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context) ? 9.sp : 14.sp,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 4.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(color: tAppbarColor, borderRadius: BorderRadius.circular(7)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    // A completed ride stays here until the payment is collected and the customer is rated.
                                    booking['status'] == STATUS_RIDE_COMPLETED
                                        ? (booking['payment_status'] == payment_status_success ? 'Add review' : 'Collect payment')
                                        : StatusConstants().getBookingStatusConstants(booking['status']),
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 9.sp : 12.sp,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  Twl.dateReverseFormate(booking['pickup_date'].toString()) + ', ',
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                  ),
                                ),
                                Text(
                                  booking['pickup_time'].toString(),
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  Images.TIMERR,
                                  scale: isTab(context) ? 2.9 : 4,
                                ),
                                SizedBox(
                                  width: 0.8.w,
                                ),
                                Text(
                                  usageText,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  booking['trip_type'] == TRIP_TYPE_INTERCITY ? Images.INCITY : Images.OUTSTETION,
                                  scale: booking['trip_type'] == TRIP_TYPE_INTERCITY
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
                                  booking['trip_type'] == TRIP_TYPE_INTERCITY ? 'In city' : 'Out station',
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                booking['rider_type'] == RIDER_TYPE_ONEWAY
                                    ? Image.asset(
                                        Images.ONEWAY,
                                        scale: isTab(context) ? 100 : 105,
                                      )
                                    : Image.asset(
                                        Images.ROUNDTRIPW,
                                        scale: isTab(context) ? 2.9 : 4,
                                      ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Text(
                                  booking['rider_type'] == RIDER_TYPE_ONEWAY ? 'One way' : 'Round trip',
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontWeight: FontWeight.w700,
                                    fontSize: isTab(context) ? 9.sp : 11.sp,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: tDivider,
                        height: 2.h,
                        thickness: 0.9,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // badges.Badge(
                            //   badgeStyle: BadgeStyle(
                            //       badgeColor: Colors.transparent),
                            //   position: BadgePosition.topEnd(),
                            //   onTap: () {
                            //     // showModalBottomSheet(
                            //     //   isScrollControlled: true,
                            //     //   // expand: false,
                            //     //   context: context,
                            //     //   backgroundColor: Colors.transparent,
                            //     //   builder: (context) => Padding(
                            //     //       padding: EdgeInsets.symmetric(
                            //     //           vertical: 10.0, horizontal: 30.0),
                            //     //       child: Container(
                            //     //           height: 80.h,
                            //     //           // height: MediaQuery.of(context).size.height / 1,
                            //     //           decoration: BoxDecoration(
                            //     //               borderRadius:
                            //     //                   BorderRadius.circular(
                            //     //                       10)),
                            //     //           child: EstimateWidget(
                            //     //             estimateDetails: booking,
                            //     //           ))),
                            //     // );
                            //   },
                            //   badgeContent: Icon(
                            //     Icons.info_outline,
                            //     color: tBrown,
                            //     size: 12,
                            //   ),
                            //   child: Text(
                            //     'Estimate fare',
                            //     style: GoogleFonts.mulish(
                            //       color: tSecondaryColor,
                            //       fontWeight: FontWeight.w700,
                            //       fontSize: isTab(context) ? 14.sp : 16.sp,
                            //     ),
                            //   ),
                            // ),
                            booking['status'] == STATUS_RIDE_COMPLETED
                                ? Text(
                                    'Collect fare',
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 14.sp : 16.sp,
                                    ),
                                  )
                                : Text(
                                    'Estimate fare',
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 14.sp : 16.sp,
                                    ),
                                  ),
                            booking['status'] == STATUS_RIDE_COMPLETED
                                ? Text(
                                    currencySymbol + booking['driver_earnings'].toString(),
                                    style: GoogleFonts.mulish(
                                      color: tPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 16.sp : 18.sp,
                                    ),
                                  )
                                : Text(
                                    currencySymbol + booking['driver_earnings'].toString(),
                                    style: GoogleFonts.mulish(
                                      color: tPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 16.sp : 18.sp,
                                    ),
                                  )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      booking['rider_type'] == RIDER_TYPE_ONEWAY
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(8), boxShadow: [tBoxShadow]),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            child: Image.asset(
                                          Images.LOCATIONGREEN,
                                          scale: isTab(context) ? 2 : 3.5,
                                        )),
                                        Column(
                                          children: [
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                            SizedBox(
                                              height: 1,
                                            ),
                                            Container(
                                              height: 0.6.h,
                                              width: 0.5.w,
                                              decoration: BoxDecoration(color: tlightGray, shape: BoxShape.rectangle),
                                            ),
                                          ],
                                        ),
                                        Container(
                                            child: Icon(
                                          Icons.location_on,
                                          color: tRed,
                                          size: 35,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            booking['pickup_address'].toString(),
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.mulish(
                                              color: tSecondaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context) ? 9.sp : 11.sp,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 2.h),
                                            width: double.infinity,
                                            height: 0.1.h,
                                            decoration: BoxDecoration(color: tDivider),
                                          ),
                                          Container(
                                              child: Text(
                                            booking['drop_address'].toString(),
                                            maxLines: 2,
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.mulish(
                                              color: tSecondaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: isTab(context) ? 9.sp : 11.sp,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(8), boxShadow: [tBoxShadow]),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(children: [
                                    Container(
                                        child: Image.asset(
                                      Images.LOCATIONGREEN,
                                      scale: isTab(context) ? 2 : 3.5,
                                    )),
                                    SizedBox(width: 3.w),
                                    Container(
                                      width: 30.h,
                                      child: Text(
                                        booking['pickup_address'].toString(),
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTab(context) ? 9.sp : 11.sp,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ]))),
                      SizedBox(height: 2.h),
                      booking['status'] == STATUS_DRIVER_ACCEPTED ? SizedBox(height: 1.h) : Container(),
                      booking['status'] == STATUS_RIDE_COMPLETED && booking['payment_status'] == payment_status_pending
                          ? Container(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Text(
                                    'Payment pending',
                                    style: GoogleFonts.mulish(
                                      color: tRed,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 14.sp : 16.sp,
                                    ),
                                  ),
                                  SizedBox(height: 1.h)
                                ],
                              ))
                          : Container(),
                      SizedBox(
                        height: 1.h,
                      ),
                      const ViewDetailsButton(),
                      SizedBox(
                        height: 2.h,
                      ),
                    ]))),
          );
        });
  }
  // <<< END    _AcceptedRidesState.build()
}
// <<< END    class _AcceptedRidesState
