// ----------------------------------------------------------------------
// Ride history list
//
// List of past rides for one tab.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/BookingStatusConstants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/profilePage/earnings/componants/rideinfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../responsive.dart';

// >>> START  class RideHistoryList
class RideHistoryList extends StatefulWidget {
  const
  RideHistoryList({
    Key? key,
    this.status,
    this.selectedType,
    this.allDates = false,
  }) : super(key: key);
  final status;
  final selectedType;
  // true: ignore the date range of Ride History and list every ride of this status
  final bool allDates;

  @override
  State<RideHistoryList> createState() => _RideHistoryListState();
}
// <<< END    class RideHistoryList

// >>> START  class _RideHistoryListState
class _RideHistoryListState extends State<RideHistoryList> {
  ScrollController _scrollController = ScrollController();
  List<dynamic> bookingsData = [];
  bool showBottomSheet = false;
  int page = 0;
  int totalPages = 0;
  int totalCount = 0;

  bool isLoading = false;
  String errorMessage = '';

  // >>> START  _RideHistoryListState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    fetchBookingsHistory();
    // TODO: implement initState
    super.initState();
  }
  // <<< END    _RideHistoryListState.initState()

  var resStatus;

  // >>> START  _RideHistoryListState.dispose()  -  cleanup when the screen closes
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
  // <<< END    _RideHistoryListState.dispose()

  // >>> START  _RideHistoryListState._scrollListener()  -  scroll listener
  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (page < totalPages) {
        print('Api reHitted');
        fetchBookingsHistory();
      }
    }
  }
  // <<< END    _RideHistoryListState._scrollListener()

  // >>> START  _RideHistoryListState.fetchBookingsHistory()  -  fetch bookings history
  Future<void> fetchBookingsHistory() async {
    setState(() {
      isLoading = true;
    });
    try {
      dynamic data = await RideBookingsApi().fetchBookingHistory(
          context, page.toString(), widget.status.toString(),
          allDates: widget.allDates);
      final List<dynamic> newBookings = data['details'];
      setState(() {
        resStatus = data['status'];
      });
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
  // <<< END    _RideHistoryListState.fetchBookingsHistory()

  // >>> START  _RideHistoryListState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: bookingsData.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == bookingsData.length) {
            if (page < totalPages) {
              return Center(child: CircularProgressIndicator());
            } else {
              return resStatus == 'NOK'
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
                  : isLoading ? Center(
                      child: SpinKitRotatingCircle(
                        color: tAppbarColor,
                      ),
                      ) : Center();
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
          double? usageHours = double.tryParse(booking['usage_hours']);

          String usageText;
          if (usageHours != null) {
            if (usageHours >= 1) {
              int wholeHours = usageHours.toInt();
              int wholeMinutes = ((usageHours - wholeHours) * 60).toInt();
              if (wholeMinutes > 0) {
                usageText = '$wholeHours hrs $wholeMinutes mins ';
              } else {
                usageText = '$wholeHours hrs ';
              }
            } else {
              int usageMinutes = (usageHours * 60).toInt();
              usageText = '$usageMinutes mins ';
            }
          } else {
            usageText =
                'Usage hours not available'; // Handle the case where 'usage_hours' is null
          }
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.5.w),
            child: GestureDetector(
                onTap: () {
                  Twl.forceNavigateTo(
                      context,
                      RideInfo(
                        selectedType:widget.selectedType,
                        bookingDetails: booking,
                        isHistoryPage: true,
                      ));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: tWhite,
                        boxShadow: [tBoxShadow],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 2.h,
                                bottom: 1.h,
                                left: 3.5.w,
                                right: 3.5.w),
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
                                Container(
                                  height: 4.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      color: StatusConstants()
                                          .getBookingStatusConstantsColors(
                                              booking['status']),
                                      borderRadius: BorderRadius.circular(7)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    StatusConstants().getBookingStatusConstants(
                                        booking['status']),
                                    style: GoogleFonts.mulish(
                                      color: tWhite,
                                      fontWeight: FontWeight.w700,
                                      fontSize: isTab(context) ? 9.sp : 12.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.4.h),
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
                                      Twl.dateReverseFormate(
                                              booking['pickup_date']
                                                  .toString()) +
                                          ', ',
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 0.4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontSize: isTab(context) ? 9.sp : 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      Images.ROUNDTRIPW,
                                      scale: isTab(context) ? 2.9 : 4,
                                    ),
                                    SizedBox(
                                      width: 0.5.w,
                                    ),
                                    Text(
                                      booking['rider_type'] == RIDER_TYPE_ONEWAY
                                          ? 'One way'
                                          : 'Round trip',
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
                          booking['status'] == STATUS_RIDE_COMPLETED
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 5.w, right: 5.w, top: 5, bottom: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Distance',
                                              style: GoogleFonts.mulish(
                                                color: tbrown,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text(
                                              booking['total_distance']
                                                  .toString(),
                                              style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Time',
                                              style: GoogleFonts.mulish(
                                                color: tbrown,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text(
                                              usageText,
                                              style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Amount',
                                              style: GoogleFonts.mulish(
                                                color: tbrown,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 12.sp,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Text(
                                              ((booking['price_detail']['estimatePrice'] + (booking['cancellation_charges'] ?? 0)).toStringAsFixed(0)),
                                              style: GoogleFonts.mulish(
                                                color: tBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 14.sp,
                                              ),
                                            ),
                                          ],
                                        )
                                      ]),
                                )
                              : Container(),
                          SizedBox(
                            height: 2.h,
                          ),
                          booking['rider_type'] == RIDER_TYPE_ONEWAY
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [tBoxShadow]),
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
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 0.6.h,
                                                  width: 0.5.w,
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 0.6.h,
                                                  width: 0.5.w,
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 0.6.h,
                                                  width: 0.5.w,
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 0.6.h,
                                                  width: 0.5.w,
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Container(
                                                  height: 0.6.h,
                                                  width: 0.5.w,
                                                  decoration: BoxDecoration(
                                                      color: tlightGray,
                                                      shape:
                                                          BoxShape.rectangle),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                booking['pickup_address']
                                                    .toString(),
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isTab(context)
                                                      ? 9.sp
                                                      : 11.sp,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 2.h),
                                                width: double.infinity,
                                                height: 0.1.h,
                                                decoration: BoxDecoration(
                                                    color: tDivider),
                                              ),
                                              Container(
                                                  child: Text(
                                                booking['drop_address']
                                                    .toString(),
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isTab(context)
                                                      ? 9.sp
                                                      : 11.sp,
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
                                  decoration: BoxDecoration(
                                      color: tWhite,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [tBoxShadow]),
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
                                            booking['pickup_address']
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.mulish(
                                              color: tSecondaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  isTab(context) ? 9.sp : 11.sp,
                                            ),
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]))),
                          SizedBox(height: 2.h),
                        ]))),
          );
        });
  }
  // <<< END    _RideHistoryListState.build()
}
// <<< END    class _RideHistoryListState
