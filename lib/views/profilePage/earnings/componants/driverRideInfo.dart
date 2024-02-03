import 'package:base_project_flutter/views/profilePage/earnings/componants/rideDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/BookingStatusConstants.dart';
import '../../../../constants/constants.dart';
import '../../../../constants/imageConstant.dart';
import '../../../../constants/stetuesConstant.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../../globalWidgets/button.dart';
import '../../../../responsive.dart';
import '../../../ride_info/final_bill_amount.dart';
import '../../support/support.dart';
import '../earnings.dart';
import 'driver_final_bill.dart';
import 'earn_container.dart';

class driverRideInfo extends StatefulWidget {
  const driverRideInfo({Key? key,
  this.bookingDetails,
    this.Status,
    this.showDriverEarnings,
  })
      : super(key: key);
  final bookingDetails;
  final Status;
  final showDriverEarnings;


  @override
  State<driverRideInfo> createState() => _driverRideInfoState();

}

class _driverRideInfoState extends State<driverRideInfo> {


  @override
  Widget build(BuildContext context) {
    double? usageHours = double.parse(widget.bookingDetails['usage_hours']);
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
            return Twl.forceNavigateTo(context, EarningPage(tabindex:widget.Status));
          },
      child: Scaffold(
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
                        Twl.forceNavigateTo(context, EarningPage(tabindex:widget.Status));
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
        body: SingleChildScrollView(
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
                                    'user_details']['selfie'] ?? '',
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
                            (widget.showDriverEarnings? Text(
                              'Your Total Earnings'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context)
                                    ? 6.sp
                                    : 14.sp,
                              ),
                            ): Text(
                              'Total Amount Collected'.tr,
                              style: GoogleFonts.mulish(
                                color: tSecondaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context)
                                    ? 6.sp
                                    : 14.sp,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            Text(
                              currencySymbol +
                                  (widget.showDriverEarnings
                                      ? widget.bookingDetails['final_price'].toString()
                                      : ((widget.bookingDetails['price_detail']['estimatePrice'] + (widget.bookingDetails['cancellation_charges'] ?? 0)).toStringAsFixed(0))),
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
                                              DriverBillAmountWidget(
                                                estimateDetails:
                                                widget
                                                    .bookingDetails,
                                                billDetails: widget
                                                    .bookingDetails[
                                                'price_detail'],
                                                  showDriverEarnings: widget.showDriverEarnings,
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
                                        Twl.dateReverseFormate(
                                            widget.bookingDetails[
                                            'end_date']),
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
                                        widget.bookingDetails[
                                        'end_time']
                                            .toString(),
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
                        : Container()
                  ],
                ),
              ),
            ]),
          ),
      ),
    );
  }
}
