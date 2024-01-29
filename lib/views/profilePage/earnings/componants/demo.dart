import 'dart:developer';

import 'package:base_project_flutter/constants/BookingStatusConstants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/profilePage/ridehistory/ridehistory.dart';
import 'package:base_project_flutter/views/profilePage/support/support.dart';
import 'package:base_project_flutter/views/ride_info/completer_ride.dart';
import 'package:base_project_flutter/views/ride_info/ride_info.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constants/constants.dart';
import '../../../../../constants/imageConstant.dart';
import '../../../../../globalFuctions/globalFunctions.dart';
import '../../../../../globalWidgets/button.dart';

import '../../../../../responsive.dart';
import '../../../../api_services/rideBookingsApi.dart';
import '../../../bottomNavigation.dart/bottomNavigation.dart';
import '../../../ride_info/final_bill_amount.dart';

class RideInfo extends StatefulWidget {
  const RideInfo({Key? key, this.bookingDetails, this.isHistoryPage, this.selectedType})
      : super(key: key);
  final bookingDetails;
  final isHistoryPage;
  final selectedType;


  @override
  State<RideInfo> createState() => _RideInfoState();
}

class _RideInfoState extends State<RideInfo> {
  @override
  bool loading = false;

  Widget build(BuildContext context) {
    Future<void> fetchData() async {
      setState(() {
        loading = false;
      });
    }

    print(widget.bookingDetails['status']);
    log(widget.bookingDetails['status'].toString());
    print(widget.bookingDetails['status']);
    double? usageHours = double.parse(widget.bookingDetails['usage_hours']);

    void initState() {
      // Call the fetch data method
      fetchData();
    }

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
    return WillPopScope(
      onWillPop: () {
        return widget.isHistoryPage == false
            ? widget.bookingDetails['status'] == STATUS_START_RIDE
            ? Twl.forceNavigateTo(context,
            CompleteRide(bookingDetails: widget.bookingDetails,))
            : Twl.forceNavigateTo(context,
            RideInfoPage(bookingDetails: widget.bookingDetails))
            : Twl.forceNavigateTo(context, MyRidesView(selectedType:widget.selectedType));
      },
      child: loading
          ? Center(
        child: SpinKitThreeBounce(
          size: 10,
          color: tSecondaryColor,
        ),
      )
          : Scaffold(
        appBar: AppBar(
          elevation: 1,
          titleSpacing: 7,
          backgroundColor: tYellow,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: isTab(context) ? 7 : 0,
                  horizontal: isTab(context) ? 7 : 0),
              decoration: BoxDecoration(
                  boxShadow: [tBackbtnBoxShadow],
                  color: tWhite,
                  borderRadius: BorderRadius.circular(7)),
              child: IconButton(
                  onPressed: () {
                    widget.isHistoryPage == false
                        ? widget.bookingDetails['status'] ==
                        STATUS_START_RIDE
                        ? Twl.forceNavigateTo(
                        context,
                        CompleteRide(
                            bookingDetails:
                            widget.bookingDetails))
                        : Twl.forceNavigateTo(
                        context,
                        RideInfoPage(
                            bookingDetails:
                            widget.bookingDetails))
                        : Twl.forceNavigateTo(context, MyRidesView(selectedType:widget.selectedType));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: tSecondaryColor,
                  )),
            ),
          ),
          title: Text(
            'Ride info',
            // widget.isHistoryPage.toString(),
            style: TextStyle(
                color: tSecondaryColor,
                fontFamily: "mulish",
                fontSize: isTab(context) ? 14.sp : 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: loading
            ? Center(
          child: SpinKitThreeBounce(
            size: 10,
            color: tSecondaryColor,
          ),
        )
            : WillPopScope(
          onWillPop: () {
            return widget.isHistoryPage == false
                ? widget.bookingDetails['status'] ==
                STATUS_START_RIDE
                ? Twl.forceNavigateTo(
                context,
                CompleteRide(
                    bookingDetails: widget.bookingDetails))
                : Twl.forceNavigateTo(
                context,
                RideInfoPage(
                    bookingDetails: widget.bookingDetails))
                : Twl.forceNavigateTo(context, MyRidesView(selectedType:widget.selectedType));
          },
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 1.h,
              ),
              Container(
                width: double.infinity,
                color: tYellow,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ride_Id'.tr +
                        ' : ' +
                        widget.bookingDetails['id'].toString(),
                    style: TextStyle(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBackbtnBoxShadow],
                            borderRadius:
                            BorderRadiusDirectional.circular(
                                10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.circular(50),
                                child: Container(
                                  width:
                                  isTab(context) ? 250 : 16.w,
                                  height:
                                  isTab(context) ? 250 : 8.h,
                                  decoration: new BoxDecoration(
                                    color: tlightGray,
                                    borderRadius:
                                    new BorderRadius.all(
                                        new Radius.circular(
                                            isTab(context)
                                                ? 150
                                                : 50.0)),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.bookingDetails[
                                    'user_details']['selfie'],
                                    height: 10.h,
                                    width: 20.w,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url,
                                        downloadProgress) =>
                                        SpinKitThreeBounce(
                                          size: 10,
                                          color: tSecondaryColor,
                                        ),
                                    errorWidget: (context, url,
                                        error) =>
                                        Image.network(
                                            'https://t3.ftcdn.net/jpg/03/53/11/00/360_F_353110097_nbpmfn9iHlxef4EDIhXB1tdTD0lcWhG9.jpg',
                                            fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Container(
                                // width: 60,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      widget.bookingDetails[
                                      'user_details']
                                      ['first_name']
                                          .toString() +
                                          widget.bookingDetails[
                                          'user_details']
                                          ['last_name']
                                              .toString(),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: GoogleFonts.mulish(
                                        color: tBlue,
                                        fontWeight: FontWeight.w800,
                                        fontSize: isTab(context)
                                            ? 10.sp
                                            : 13.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  launch("tel://" +
                                      widget.bookingDetails[
                                      'user_details']
                                      ['contact_no']
                                          .toString());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: tGreen,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    Icons.call,
                                    size: isTab(context) ? 20 : 30,
                                    color: tWhite,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    widget.bookingDetails['rider_type'] ==
                        RIDER_TYPE_ONEWAY
                        ? Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10),
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius:
                          BorderRadius.circular(8),
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
                                      scale: isTab(context)
                                          ? 2
                                          : 3.5,
                                    )),
                                Column(
                                  children: [
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Container(
                                      height: 0.6.h,
                                      width: 0.5.w,
                                      decoration:
                                      BoxDecoration(
                                          color:
                                          tlightGray,
                                          shape: BoxShape
                                              .rectangle),
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
                                    widget.bookingDetails[
                                    'pickup_address']
                                        .toString(),
                                    textAlign:
                                    TextAlign.start,
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontWeight:
                                      FontWeight.w600,
                                      fontSize: isTab(context)
                                          ? 9.sp
                                          : 11.sp,
                                    ),
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin:
                                    EdgeInsets.symmetric(
                                        vertical: 2.h),
                                    width: double.infinity,
                                    height: 0.1.h,
                                    decoration: BoxDecoration(
                                        color: tDivider),
                                  ),
                                  Container(
                                      child: Text(
                                        widget.bookingDetails[
                                        'drop_address']
                                            .toString(),
                                        maxLines: 2,
                                        textAlign:
                                        TextAlign.start,
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontWeight:
                                          FontWeight.w600,
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
                        margin:
                        EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius:
                            BorderRadius.circular(8),
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
                                  widget.bookingDetails[
                                  'pickup_address']
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isTab(context)
                                        ? 9.sp
                                        : 11.sp,
                                  ),
                                  maxLines: 4,
                                  overflow:
                                  TextOverflow.ellipsis,
                                ),
                              ),
                            ]))),
                    SizedBox(
                      height: 2.h,
                    ),
                    widget.bookingDetails['status'] ==
                        STATUS_RIDE_COMPLETED
                        ? Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context)
                                    ? 8.sp
                                    : 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              currencySymbol +
                                  widget.bookingDetails[
                                  'price_detail']
                                  ['estimatePrice']
                                      .toString(),
                              style: GoogleFonts.inter(
                                color: tPrimaryColor,
                                fontWeight: FontWeight.w800,
                                fontSize: isTab(context)
                                    ? 16.sp
                                    : 20.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  // expand: false,
                                  context: context,
                                  backgroundColor:
                                  Colors.transparent,
                                  builder: (context) =>
                                      Padding(
                                          padding: EdgeInsets
                                              .symmetric(
                                              vertical:
                                              10.0,
                                              horizontal:
                                              30.0),
                                          child: Container(
                                              height: 80.h,
                                              // height: MediaQuery.of(context).size.height / 1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10)),
                                              child:
                                              FinalBillAmountWidget(
                                                estimateDetails:
                                                widget
                                                    .bookingDetails,
                                                billDetails: widget
                                                    .bookingDetails[
                                                'price_detail'],
                                              ))),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 15,
                                    color: tLightBrown,
                                  ),
                                  SizedBox(height: 2.h)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Estimate_fare'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context)
                                    ? 8.sp
                                    : 16.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // showModalBottomSheet(
                                //   isScrollControlled: true,
                                //   // expand: false,
                                //   context: context,
                                //   backgroundColor: Colors.transparent,
                                //   builder: (context) => Padding(
                                //       padding: EdgeInsets.symmetric(
                                //           vertical: 10.0, horizontal: 30.0),
                                //       child: Container(
                                //           height: 80.h,
                                //           // height: MediaQuery.of(context).size.height / 1,
                                //           decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(
                                //                       10)),
                                //           child: EstimateWidget(
                                //             estimateDetails:
                                //                 widget.bookingDetails,
                                //           ))),
                                // );
                              },
                              child: Column(
                                children: [
                                  // Icon(
                                  //   Icons.info_outline,
                                  //   size: 15,
                                  //   color: tLightBrown,
                                  // ),
                                  // SizedBox(height: 2.h)
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          currencySymbol +
                              widget.bookingDetails[
                              'estimate_price']
                                  .toString(),
                          style: GoogleFonts.inter(
                            color: tPrimaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: isTab(context)
                                ? 16.sp
                                : 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 3.w),
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [tBoxShadow]),
                      child:
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Start Time',
                                  style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontSize: isTab(context)
                                        ? 10.sp
                                        : 10.sp,
                                    fontWeight: FontWeight.w800,
                                  )),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Images.CALENDER,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        Twl.dateReverseFormate(
                                            widget.bookingDetails[
                                            'start_time']),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context)
                                              ? 10.sp
                                              : 10.sp,
                                          fontWeight:
                                          FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        DateFormat.jm().format(DateTime.parse(widget.bookingDetails['start_time'])),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context)
                                              ? 10.sp
                                              : 10.sp,
                                          fontWeight:
                                          FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 8.h,
                            width: 0.4.w,
                            color: tSecondaryColor,
                          ),
                          Column(
                            children: [
                              Text('Duration',
                                  style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontSize: isTab(context)
                                        ? 10.sp
                                        : 10.sp,
                                    fontWeight: FontWeight.w800,
                                  )),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Images.TIMER,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    usageText,
                                    style: GoogleFonts.mulish(
                                      color: tSecondaryColor,
                                      fontSize: isTab(context)
                                          ? 10.sp
                                          : 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            height: 8.h,
                            width: 0.4.w,
                            color: tSecondaryColor,
                          ),
                          Column(
                            children: [
                              Text( widget.bookingDetails['status'] == 8 ? 'Cancel Time' : 'End Time',
                                  style: GoogleFonts.mulish(
                                    color: tPrimaryColor,
                                    fontSize: isTab(context)
                                        ? 10.sp
                                        : 10.sp,
                                    fontWeight: FontWeight.w800,
                                  )),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    Images.CALENDER,
                                    scale: 3,
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                  widget.bookingDetails['end_date'] != null ? Twl.dateReverseFormate(widget.bookingDetails['end_time']).toString() : Twl.dateReverseFormate(widget.bookingDetails['start_time']).toString(),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context)
                                              ? 10.sp
                                              : 10.sp,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        widget.bookingDetails['end_time'] != null
                                            ? widget.bookingDetails['end_time'].toString()
                                            : DateFormat.jm().format(DateTime.parse(widget.bookingDetails['start_time'])),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 10.sp : 10.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.w, vertical: 3.w),
                      decoration: BoxDecoration(
                          color: tWhite,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [tBoxShadow]),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          widget.bookingDetails['trip_type'] ==
                              TRIP_TYPE_INTERCITY
                              ? Row(
                            children: [
                              Image.asset(Images.INCITY,
                                  scale: isTab(context)
                                      ? 2.9
                                      : 12),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                'In City',
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context)
                                      ? 12.sp
                                      : 12.sp,
                                  fontWeight: FontWeight.w700,
                                  // fontFamily:
                                ),
                              ),
                            ],
                          )
                              : Row(
                            children: [
                              Image.asset(
                                Images.OUT_STATION,
                                scale:
                                isTab(context) ? 2.9 : 3,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                'Out station',
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context)
                                      ? 12.sp
                                      : 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 8.h,
                            width: 0.4.w,
                            color: tSecondaryColor,
                          ),
                          widget.bookingDetails['rider_type'] ==
                              RIDER_TYPE_ONEWAY
                              ? Row(
                            children: [
                              Image.asset(
                                Images.ROUND_TRIP,
                                scale: 3,
                              ),
                              SizedBox(width: 3.w),
                              Text(
                                'One way',
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context)
                                      ? 12.sp
                                      : 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          )
                              : Row(
                            children: [
                              Image.asset(
                                Images.ROUND_TRIP,
                                scale: 3,
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Text(
                                'Round trip',
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context)
                                      ? 12.sp
                                      : 12.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3.w, vertical: 3.w),
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBackbtnBoxShadow],
                          borderRadius:
                          BorderRadiusDirectional.circular(10)),
                      child: Row(
                        children: [
                          Image.asset(
                            Images.CAR,
                            scale: 4,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            widget.bookingDetails['car_model'],
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontSize:
                              isTab(context) ? 12.sp : 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          widget.bookingDetails['car_type'] ==
                              CAR_TYPE_AUTOMATIC
                              ? Text(
                            '(Automatic)',
                            style: GoogleFonts.mulish(
                              color: tLightBrown,
                              fontSize: isTab(context)
                                  ? 12.sp
                                  : 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                              : Text(
                            '(Manual)',
                            style: GoogleFonts.mulish(
                              color: tLightBrown,
                              fontSize: isTab(context)
                                  ? 12.sp
                                  : 12.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomerSupport(),
                    widget.bookingDetails['status'] ==
                        STATUS_RIDE_COMPLETED ||
                        widget.bookingDetails['status'] ==
                            STATUS_USER_CANCELLED ||
                        widget.bookingDetails['status'] ==
                            STATUS_BOOKING_AUTO_CANCELLED ||
                        widget.bookingDetails['status'] ==
                            STATUS_DRIVER_CANCELLED ||
                        widget.bookingDetails['status'] ==
                            STATUS_START_RIDE
                        ? Text(
                        StatusConstants()
                            .getBookingStatusConstants(
                            widget.bookingDetails['status'])
                            .toString(),
                        style: GoogleFonts.mulish(
                          color: StatusConstants()
                              .getBookingStatusConstantsColors(
                              widget.bookingDetails[
                              'status']),
                          fontWeight: FontWeight.w700,
                          fontSize:
                          isTab(context) ? 9.sp : 12.sp,
                        ))
                        : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SizedBox(
                          width: isTab(context) ? 30.w : 40.w,
                          height: isTab(context) ? 6.h : 8.h,
                          child: ButtonWidget(
                              borderSide: BorderSide(
                                color: tRed,
                              ),
                              color: tRed,
                              child: Text(
                                "cancel_ride".tr,
                                style: GoogleFonts.mulish(
                                  color: tWhite,
                                  fontWeight: FontWeight.w800,
                                  fontSize: isTab(context)
                                      ? 10.sp
                                      : 16.sp,
                                ),
                              ),
                              borderRadius: 15.0,
                              onTap: (startLoading,
                                  stopLoading,
                                  btnState) async {
                                startLoading();
                                setState(() {
                                  loading = true;
                                });
                                showBarModalBottomSheet(
                                  context: context,
                                  backgroundColor: tWhite,
                                  builder: (context) => Padding(
                                      padding: EdgeInsets
                                          .symmetric(
                                          horizontal: 0),
                                      child: Container(
                                          height: 35.h,
                                          child: CancelRideBottomSheet(
                                              bookingDetails:
                                              widget
                                                  .bookingDetails))),
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class CancelRideBottomSheet extends StatefulWidget {
  const CancelRideBottomSheet({Key? key, this.bookingDetails})
      : super(key: key);
  final bookingDetails;

  @override
  State<CancelRideBottomSheet> createState() => _CancelRideBottomSheetState();
}

class _CancelRideBottomSheetState extends State<CancelRideBottomSheet> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 80.w,
          child: Text(
            'confirm_your_cancellation'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: tSecondaryColor,
                fontFamily: "mulish",
                fontSize: isTab(context) ? 10.sp : 17.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Container(
          width: 80.w,
          child: Text(
            'Once_you_cancel_your_ride_you_will_be_pay_fee_Rs_500_for_cancellations_as_per_our_policy'
                .tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: tPrimaryColor,
                fontFamily: "mulish",
                fontSize: isTab(context) ? 10.sp : 12.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Checkbox(
              activeColor: tPrimaryColor,
              value: _isChecked,
              onChanged: (value) {
                print(_isChecked);
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
            Container(
              child: Text(
                'i_agree_to_The'.tr,
                style: GoogleFonts.mulish(
                  color: tSecondaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: isTab(context) ? 8.sp : 12.sp,
                ),
              ),
            ),
            Container(
              child: Text(
                'terms_&_conditions'.tr,
                style: GoogleFonts.mulish(
                  color: tYellow,
                  fontWeight: FontWeight.w600,
                  fontSize: isTab(context) ? 8.sp : 12.sp,
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              width: isTab(context) ? 40.w : 50.w,
              height: isTab(context) ? 5.h : 7.h,
              child: ButtonWidget(
                  borderSide: BorderSide(
                    color: tRed,
                  ),
                  color: tRed,
                  child: Text(
                    "cancel_ride".tr,
                    style: GoogleFonts.mulish(
                      color: tWhite,
                      fontWeight: FontWeight.w800,
                      fontSize: isTab(context) ? 10.sp : 16.sp,
                    ),
                  ),
                  borderRadius: 15.0,
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    Twl.navigateBack(context);
                    showBarModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => CancelReasonWidget(
                            bookingDetails: widget.bookingDetails));
                  }),
            ),
          ),
        ),
      ]),
    );
  }
}

class CancelReasonWidget extends StatefulWidget {
  const CancelReasonWidget({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;

  @override
  State<CancelReasonWidget> createState() => _CancelReasonWidgetState();
}

class _CancelReasonWidgetState extends State<CancelReasonWidget> {
  TextEditingController _descriptionController = TextEditingController();
  var reasonSelectedValue;
  var selectedIndex;
  bool selectedDropDown = false;
  List reasonsList = [
    {
      "id": 0,
      "value": false,
      "title": "unsafe_Pickup_area".tr,
    },
    {
      "id": 1,
      "value": false,
      "title": "unable_To_Swipe_Arrived".tr,
    },
    {
      "id": 2,
      "value": false,
      "title": "wrong_Pickup_Location".tr,
    },
    {
      "id": 3,
      "value": false,
      "title": "long_Pickup".tr,
    },
  ];
  var selectedCancelReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: tWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [tBoxShadow]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cancel Ride',
                          style: GoogleFonts.mulish(
                            color: tBlue,
                            fontWeight: FontWeight.w700,
                            fontSize: isTab(context) ? 10.sp : 16.sp,
                          ),
                        ),
                        Text(
                          'Please select reason for cancel ride',
                          style: GoogleFonts.mulish(
                            color: tLightBrown,
                            fontWeight: FontWeight.w600,
                            fontSize: isTab(context) ? 8.sp : 14.sp,
                          ),
                        ),
                        Divider(
                          endIndent: 40.0,
                          thickness: 1,
                          color: tSecondaryDivider,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.5.h,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: reasonsList.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            reasonSelectedValue = index;
                            selectedCancelReason = reasonsList[index];
                            print(selectedCancelReason.toString());
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 5,
                          ),
                          child: ListTile(
                            trailing: Radio(
                              activeColor: tPrimaryColor,
                              value: index,
                              groupValue: reasonSelectedValue,
                              onChanged: (value) {
                                setState(() {
                                  // reasonSelectedValue = value as int;
                                  // selectedCancelReason = reasonsList[index];
                                  // print(selectedCancelReason.toString());
                                  selectedIndex = index;
                                  reasonSelectedValue = index;
                                  selectedCancelReason = reasonsList[index];
                                  print(selectedCancelReason.toString());
                                });
                              },
                            ),
                            title: Text(
                              reasonsList[index]["title"],
                              style: GoogleFonts.lexend(
                                  color: tSecondaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTab(context) ? 9.sp : 12.sp),
                            ),
                          ),
                        ));
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: isTab(context) ? 4 : 3,
                    decoration: InputDecoration(
                        fillColor: tWhite,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 1.5, color: tgreen)),
                        // hintText: 'Write Reason ( Optional )',
                        hintStyle: TextStyle(
                            color: tGray,
                            fontSize: isTab(context) ? 7.sp : 10.sp,
                            fontWeight: FontWeight.w400),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: tgreen, width: 1.5))),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Button(
                        textcolor: tWhite,
                        borderSide: BorderSide(color: tPrimaryColor),
                        bottonText: 'Submit'.tr,
                        color: tPrimaryColor,
                        onTap: (startLoading, stopLoading, btnState) async {
                          if (selectedIndex != null) {
                            print('object');
                            startLoading();
                            var reason = reasonsList[selectedIndex]["title"];
                            print(reason);
                            // var res = await UserAPI()
                            //     .cancelRide(
                            //         context,
                            //         widget.appointmentDetails.id.toString(),
                            //         STATUS_CANCELLED_BY_OWNER.toString(),
                            //         reason,
                            //         _reasonController.text);
                            var res = await RideBookingsApi().cancelRide(
                                context,
                                widget.bookingDetails['id'].toString(),
                                _descriptionController.toString());
                            print(res);
                            print(
                              widget.bookingDetails['id'].toString(),
                            );
                            print(_descriptionController.toString());
                            if (res != null && res['status'] == 'OK') {
                              stopLoading();
                              setState(() {
                                Twl.forceNavigateTo(
                                    context,
                                    BottomNavigation(
                                      tabIndexId: 1,
                                    ));
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Service has been cancel'),
                              ));
                            } else {
                              stopLoading();

                              return Twl.createAlert(
                                  context, 'Oops', res['error']);
                            }
                            stopLoading();
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

