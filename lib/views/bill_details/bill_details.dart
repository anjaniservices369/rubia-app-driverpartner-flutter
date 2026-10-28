// ----------------------------------------------------------------------
// Bill details
//
// Final bill for a completed ride (distance, time, amount) with the Collect
// Bill button.
// ----------------------------------------------------------------------

import 'package:badges/badges.dart';
import 'package:base_project_flutter/globalWidgets/driverFoodStayNote.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/BookingStatusConstants.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/collect_payment.dart/componants/collect_cash_botomsheet.dart';
import 'package:base_project_flutter/views/profilePage/support/support.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'route_conversion_card.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/imageConstant.dart';

import '../../../../responsive.dart';
import '../../globalWidgets/button.dart';
import '../collect_payment.dart/collect_payment.dart';
import 'final_collect_bill_amount.dart';

// >>> START  class BillDetailsPage
class BillDetailsPage extends StatefulWidget {
  const BillDetailsPage({
    Key? key,
    this.bookingDetails,
  }) : super(key: key);
  final bookingDetails;
  @override
  State<BillDetailsPage> createState() => _BillDetailsPageState();
}
// <<< END    class BillDetailsPage

// >>> START  class _BillDetailsPageState
class _BillDetailsPageState extends State<BillDetailsPage> {
  // >>> START  _BillDetailsPageState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchrideDetails();
    // TODO: implement initState
    super.initState();
  }
  // <<< END    _BillDetailsPageState.initState()

  var bookingDetails;
  var resNOK;
  // >>> START  _BillDetailsPageState.fetchrideDetails()  -  fetchride details
  fetchrideDetails() async {
    var res = await RideBookingsApi()
        .fetchBookigDetails(context, widget.bookingDetails['id'].toString());
    if (res != null && res['status'] == 'OK') {
      setState(() {
        bookingDetails = res['details'];
      });
      usagehour();
    } else {
      setState(() {
        resNOK = res['status'];
      });
    }
  }
  // <<< END    _BillDetailsPageState.fetchrideDetails()

  var usageText;
  // >>> START  _BillDetailsPageState.usagehour()
  usagehour() {
    double? usageHours = double.tryParse(
      bookingDetails['usage_hours'].toString(),
    );

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
  }
  // <<< END    _BillDetailsPageState.usagehour()

  // >>> START  _BillDetailsPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          'bill_details'.tr,
          style: TextStyle(
            color: tSecondaryColor,
            fontSize: isTab(context) ? 10.sp : 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: tYellow,
        actions: [
          GestureDetector(
            onTap: () {
              Twl.navigateTo(context, Support());
            },
            child: Container(
              margin: EdgeInsets.all(11),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: tWhite,
                  boxShadow: [tBoxShadow]),
              child: Row(
                children: [
                  Image.asset(
                    Images.PERSONINHEDSET,
                    color: tPrimaryColor,
                    scale: isTab(context) ? 2.5 : 3.5,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    'support'.tr,
                    style: TextStyle(
                        color: tPrimaryColor,
                        fontSize: isTab(context) ? 10.sp : 11.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: bookingDetails == null
          ? resNOK == 'NOK'
              ? Align(
                  alignment: Alignment.center,
                  child: Text('No data found'),
                )
              : Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: tAppbarColor,
                  ))
          : PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                Twl.forceNavigateTo(
                    context,
                    BottomNavigation(
                      tabIndexId: 1,
                      tabIndexType: 1,
                    ));
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(children: [
                    // Booked in-city, travelled and billed outstation: the message and the route map.
                    RouteConversionCard(rideDetails: bookingDetails),
                    DriverFoodStayNote(rideDetails: bookingDetails),
                    Container(
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.5.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ride Id : #',
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['id'].toString(),
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: tgreen),
                                        child: Icon(
                                          Icons.check,
                                          color: tWhite,
                                          size: isTab(context) ? 10 : 15,
                                        )),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      StatusConstants()
                                          .getBookingStatusConstants(
                                              bookingDetails['status'])
                                          .toString(),
                                      style: GoogleFonts.mulish(
                                        color: tgreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            isTab(context) ? 10.sp : 12.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                    child: Row(
                                  children: [
                                    Text(
                                      bookingDetails['pickup_date'],
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize:
                                            isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      ' ',
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize:
                                            isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['pickup_time'],
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize:
                                            isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bookingDetails['trip_type'] ==
                                              TRIP_TYPE_INTERCITY
                                          ? 'In city'
                                          : 'Out station',
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 9.sp : 11.sp,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['rider_type'] ==
                                              RIDER_TYPE_ONEWAY
                                          ? 'One way'
                                          : 'Round trip',
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 9.sp : 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.2,
                            color: tGray,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.WHITESMALLCAR,
                                          scale: isTab(context) ? 2.5 : 3.5,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          bookingDetails['car_model'],
                                          style: GoogleFonts.mulish(
                                            color: tSecondaryColor,
                                            fontSize:
                                                isTab(context) ? 10.sp : 12.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      bookingDetails['vehicle_number'] == null
                                          ? 'TS0X XX XXXX'
                                          : bookingDetails['vehicle_number']
                                              .toString(),
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontSize: isTab(context) ? 8.sp : 11.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 1.5.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.w),
                        decoration: BoxDecoration(
                            color: tWhite,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [tBoxShadow]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Distance'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontSize: isTab(context) ? 11.sp : 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  bookingDetails['total_distance'] != null
                                      ? bookingDetails['total_distance']
                                          .toString()
                                      : '1.1km',
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Time'.tr,
                                  style: GoogleFonts.mulish(
                                    color: tbrown,
                                    fontSize: isTab(context) ? 11.sp : 13.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  usageText,
                                  style: GoogleFonts.mulish(
                                    color: tSecondaryColor,
                                    fontSize: isTab(context) ? 10.sp : 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                // Text(

                                badges.Badge(
                                    badgeStyle: BadgeStyle(
                                        badgeColor: Colors.transparent),
                                    position: BadgePosition.topEnd(),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        // expand: false,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 30.0),
                                            child: Container(
                                                height: 80.h,
                                                // height: MediaQuery.of(context).size.height / 1,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: FinalCollectBillAmountWidget(
                                                  estimateDetails:bookingDetails,
                                                  billDetails: bookingDetails['price_detail'],
                                                ))),
                                      );
                                    },
                                    badgeContent: Icon(
                                      Icons.info_outline,
                                      color: tBrown,
                                      size: 12,
                                    ),
                                    child: Text(
                                      'Amount'.tr,
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize:
                                            isTab(context) ? 11.sp : 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),

                                SizedBox(
                                  height: 1.h,
                                ),
                                bookingDetails['price_detail']
                                            ['estimatePrice'] ==
                                        null
                                    ? Container(
                                        child: Text('0'),
                                      )
                                    : Text(
                                        currencySymbol +
                                            ((bookingDetails['price_detail']['estimatePrice'] + (bookingDetails['Pending_cancellation_charges'] ?? 0)).toStringAsFixed(0)),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize:
                                              isTab(context) ? 10.sp : 12.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    bookingDetails['rider_type'] == RIDER_TYPE_ONEWAY
                        ? Container(
                            decoration: BoxDecoration(
                                color: tWhite,
                                boxShadow: [tBoxShadow],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(
                                                  isTab(context) ? 15 : 8),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Image.asset(
                                                Images.LOCATIONGREEN,
                                                scale: isTab(context) ? 2 : 4,
                                              )),
                                          Column(
                                            children: [
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Container(
                                                height: 0.6.h,
                                                width: 0.5.w,
                                                decoration: BoxDecoration(
                                                    color: tlightGray,
                                                    shape: BoxShape.rectangle),
                                              ),
                                            ],
                                          ),
                                          Container(
                                              padding: EdgeInsets.all(
                                                  isTab(context) ? 15 : 8),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: Icon(
                                                Icons.location_on_sharp,
                                                color: tRed,
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        width: isTab(context) ? 2.w : 3.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                bookingDetails[
                                                    'pickup_address'],
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 9.sp
                                                      : 11.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Divider(
                                              color: tlightGray,
                                              thickness: 1,
                                            ),
                                            Container(
                                                child: Text(
                                              bookingDetails['drop_address'],
                                              style: GoogleFonts.mulish(
                                                color: tSecondaryColor,
                                                fontSize: isTab(context)
                                                    ? 9.sp
                                                    : 11.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: tWhite,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [tBoxShadow]),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
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
                                      bookingDetails['pickup_address']
                                          .toString(),
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
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Sub total',
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize:
                                              isTab(context) ? 8.sp : 12.sp,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Text(
                                            currencySymbol +
                                                ((int.parse(bookingDetails['subtotal']) + (bookingDetails['Pending_cancellation_charges'] ?? 0)).toStringAsFixed(0)),

                                            style: TextStyle(
                                                fontSize: isTab(context)
                                                    ? 8.sp
                                                    : 12.sp,
                                                color: tSecondaryColor,
                                                fontWeight: FontWeight.bold))),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Discount'.tr,
                                          style: TextStyle(
                                              color: tSecondaryColor,
                                              fontSize:
                                                  isTab(context) ? 8.sp : 12.sp,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 1.w),
                                        bookingDetails['coupon_code'] == ''
                                            ? Container()
                                            : Text(
                                                '|',
                                                style: TextStyle(
                                                    color: tGray,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        SizedBox(width: 1.w),
                                        bookingDetails['coupon_code'] == ''
                                            ? Text(
                                                '',
                                                style: TextStyle(
                                                    color: tbluew,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                bookingDetails['coupon_code']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: tbluew,
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 12.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            child: Text('-',
                                                style: TextStyle(
                                                    fontSize: isTab(context)
                                                        ? 8.sp
                                                        : 12.sp,
                                                    color: tRed,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        bookingDetails['coupon_code'] == ''
                                            ? Container(
                                                child: Text(
                                                    currencySymbol + '0',
                                                    style: TextStyle(
                                                        fontSize: isTab(context)
                                                            ? 8.sp
                                                            : 12.sp,
                                                        color: tRed,
                                                        fontWeight:
                                                            FontWeight.bold)))
                                            : Container(
                                                child: Text(
                                                    currencySymbol +
                                                        bookingDetails[
                                                                'coupon_discount']
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontSize: isTab(context)
                                                            ? 8.sp
                                                            : 12.sp,
                                                        color: tRed,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Divider(
                              color: tlightGray,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total_Amount'.tr,
                                      style: TextStyle(
                                          color: tSecondaryColor,
                                          fontSize:
                                              isTab(context) ? 10.sp : 14.sp,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    bookingDetails['price_detail']
                                                ['estimatePrice'] ==
                                            null
                                        ? Container(
                                            child: Text('0'),
                                          )
                                        : Container(
                                            child: Text(
                                              currencySymbol +
                                                  ((bookingDetails['price_detail']['estimatePrice'] + (bookingDetails['Pending_cancellation_charges'] ?? 0)).toStringAsFixed(0)),
                                              style: TextStyle(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context)
                                                      ? 10.sp
                                                      : 14.sp,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    bookingDetails['payment_status'] == payment_status_pending
                        // payment_status_success
                        ? Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Button(
                                  borderSide: BorderSide(
                                    color: tPrimaryColor,
                                  ),
                                  textcolor: tWhite,
                                  color: tPrimaryColor,
                                  bottonText: "collect_bill".tr,
                                  onTap: (startLoading, stopLoading, btnState) {
                                    Twl.forceNavigateTo(
                                        context,
                                        CollectPayment(
                                            bookingDetails: bookingDetails));
                                  }),
                            ),
                          )
                        : bookingDetails['payment_status'] ==
                                payment_status_success
                            ? Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Bill Amount Collected',
                                      style: GoogleFonts.mulish(
                                        color: tBlack,
                                        fontSize:
                                            isTab(context) ? 18.sp : 14.sp,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 2.h),
                                  widget.bookingDetails['user_my_ratings'] == ''
                                      ? Center(
                                          child: Center(
                                            child: Button(
                                              borderSide: BorderSide(
                                                color: tPrimaryColor,
                                              ),
                                              textcolor: tWhite,
                                              color: tPrimaryColor,
                                              bottonText: "Add Review".tr,
                                              onTap: (startLoading, stopLoading,
                                                  btnState) async {
                                                startLoading();
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    enableDrag: true,
                                                    isDismissible: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                    ),
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(
                                                                context)
                                                            .viewInsets,
                                                        child: Container(
                                                          child: Wrap(
                                                            children: [
                                                              DriverAddReviews(
                                                                bookingDetails:
                                                                    widget
                                                                        .bookingDetails,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                stopLoading();
                                              },
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            : Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Oops payment failed try again',
                                        style: GoogleFonts.mulish(
                                          color: tBlack,
                                          fontSize:
                                              isTab(context) ? 18.sp : 14.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Button(
                                          borderSide: BorderSide(
                                            color: tPrimaryColor,
                                          ),
                                          textcolor: tWhite,
                                          color: tPrimaryColor,
                                          bottonText: "collect_bill".tr,
                                          onTap: (startLoading, stopLoading,
                                              btnState) {
                                            Twl.forceNavigateTo(
                                                context,
                                                CollectPayment(
                                                    bookingDetails:
                                                        bookingDetails));
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                    SizedBox(
                      height: 3.h,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Center(
                    //     child: Button(
                    //         borderSide: BorderSide(
                    //           color: tPrimaryColor,
                    //         ),
                    //         textcolor: tWhite,
                    //         color: tPrimaryColor,
                    //         bottonText: "View time line".tr,
                    //         onTap: (startLoading, stopLoading, btnState) {
                    //           Twl.forceNavigateTo(
                    //               context,
                    //               RideMap(
                    //                   bookingDetails: widget.bookingDetails));
                    //         }),
                    //   ),
                    // ),
                  ]),
                ),
              ),
            ),
    );
  }
  // <<< END    _BillDetailsPageState.build()
}
// <<< END    class _BillDetailsPageState

// List<(double, double)> coordinates = [
//     (17.4685098, 78.4810682), (17.4685039, 78.4810678), (17.4685037, 78.4810676), (17.4685288, 78.4810645), (17.4685268, 78.4810629), (17.4685261, 78.4810653), (17.4685288, 78.4810631), (17.4685259, 78.4810652), (17.4685262, 78.4810654), (17.4685257, 78.481065), (17.4684523, 78.4810737), (17.4684602, 78.4810701), (17.4684832, 78.4810687), (17.4684827, 78.4810688), (17.4684825, 78.4810688), (17.4325888, 78.3688101), (17.4331482, 78.3692857), (17.4341775, 78.3688002), (17.4350081, 78.3678765), (17.4359887, 78.3667979), (17.4367919, 78.3659083), (17.4377495, 78.3647101), (17.4384696, 78.3635779), (17.438889, 78.3637034), (17.4385441, 78.364184), (17.4382396, 78.3648096), (17.4391955, 78.365832), (17.4402509, 78.3667805), (17.4410527, 78.3678013), (17.4405978, 78.3692887), (17.4402366, 78.3706991), (17.4405042, 78.3716638), (17.4419733, 78.3718114), (17.4418307, 78.3730263), (17.4414151, 78.3741254), (17.4406294, 78.3755144), (17.4398184, 78.3768782), (17.4408188, 78.3770096), (17.4418596, 78.3771199), (17.4438, 78.3771003), (17.4455412, 78.3772378), (17.4469709, 78.3777489), (17.4483745, 78.3788226), (17.4500298, 78.3793426), (17.4512676, 78.3806867), (17.4526898, 78.3821203), (17.4543034, 78.3832725), (17.4562354, 78.3839863), (17.458278, 78.3844719), (17.4605714, 78.3849844), (17.4625995, 78.385236), (17.4645809, 78.385355), (17.4666239, 78.3857018), (17.4686398, 78.3847771), (17.4706783, 78.3835504), (17.4721382, 78.3821641), (17.4734877, 78.3815342), (17.4742059, 78.3829012), (17.4732041, 78.3842878), (17.4725519, 78.3854351), (17.4718227, 78.3862601), (17.4713492, 78.3876447), (17.470731, 78.3890482), (17.470053, 78.3905503), (17.4689916, 78.392594), (17.4680738, 78.3948051), (17.468007, 78.3971609), (17.4681671, 78.3993029), (17.4688952, 78.4012453), (17.4693143, 78.4033667), (17.4698049, 78.4056093), (17.4700881, 78.4076914), (17.4696857, 78.4098036), (17.4698071, 78.4115842), (17.4727067, 78.4128167), (17.4748451, 78.4131603), (17.47684, 78.4141853), (17.4788473, 78.4153045), (17.4803357, 78.4169505), (17.4816314, 78.4159088), (17.4822852, 78.4152124), (17.4812863, 78.4165162), (17.480088, 78.4176943), (17.4790466, 78.4189385), (17.4780232, 78.4203294), (17.4769998, 78.4218137), (17.4761479, 78.4232166), (17.4753076, 78.4244803), (17.4740717, 78.4266883), (17.4731542, 78.4284424), (17.4723894, 78.4304246), (17.4718093, 78.4323035), (17.4712877, 78.4339377), (17.471273, 78.4341077), (17.4704848, 78.4365324), (17.4697637, 78.4386277), (17.4691366, 78.440554), (17.4685484, 78.4424312), (17.4673563, 78.4452782), (17.4659764, 78.4482007), (17.4645461, 78.4512121), (17.4636379, 78.453727), (17.4637025, 78.4556634), (17.4638494, 78.4571837), (17.4637407, 78.4592294), (17.4631318, 78.4609905), (17.4626592, 78.4623786), (17.4620503, 78.464191), (17.4615099, 78.4663366), (17.4616279, 78.4678255), (17.4622771, 78.4699997), (17.4627954, 78.4717508), (17.4634954, 78.472487), (17.4646274, 78.4726982), (17.4660772, 78.4729455), (17.4674867, 78.4726243), (17.4692466, 78.4726292), (17.4704682, 78.4734476), (17.4719433, 78.4738908), (17.4716499, 78.474843), (17.4711707, 78.4756905), (17.4711407, 78.4758058), (17.4699715, 78.476264), (17.4694154, 78.4771287), (17.4688581, 78.4788527), (17.4689553, 78.4802318), (17.4685376, 78.4811084), (17.4684966, 78.4810683), (17.4684956, 78.481068), (17.4684943, 78.4810682), (17.4685161, 78.4810665), (17.4685153, 78.4810667), (17.4685177, 78.4810665), (17.4685367, 78.481064), (17.4685349, 78.4810643), (17.4685524, 78.4810597), (17.4685282, 78.4810627), (17.4684245, 78.4810804), (17.4685305, 78.4810653), (17.4684314, 78.4810789), (17.4684775, 78.4810687), (17.4684778, 78.481069), (17.4684992, 78.4810678), (17.4685305, 78.4810647), (17.4684543, 78.4810749), (17.4685282, 78.4810639), (17.46853, 78.4810649), (17.4685273, 78.4810651), (17.4685257, 78.4810642), (17.4685226, 78.4810667), (17.4685279, 78.4810643), (17.4685258, 78.481064), (17.4685304, 78.4810646), (17.4685431, 78.4810614)
// ];

// double calcDis(Iterable<dynamic> a) {
//   List<LatLng> latLngList = [];
//   double totalDist = 0;
  
//   for (var element in a) {
//      double latitude = element.;
//     double longitude = coordinates[i + 1];
//     LatLng latLng = LatLng(latitude, longitude);
//     latLngList.add(latLng);
//   }
//   for (int i = 0; i < coordinates.length; i += 2) {
//     double latitude = coordinates[i];
//     double longitude = coordinates[i + 1];
//     LatLng latLng = LatLng(latitude, longitude);
//     latLngList.add(latLng);
//   }

//   for (int i = 0; i < coordinates.length - 1; i++) {
//     double distance = calculateDistance(coordinates[i], coordinates[i + 1]);
//     totalDist += distance;
//   }

//   //var a = Geolocator.distanceBetween(slat, slng, dlat, dlat);
//   return totalDist;
// }

// double degreesToRadians(double degrees) {
//   return degrees * pi / 180.0;
// }

// double calculateDistance(LatLng point1, LatLng point2) {
//   const double earthRadius = 6371.0; // Earth's radius in kilometers

//   double lat1 = degreesToRadians(point1.latitude);
//   double lon1 = degreesToRadians(point1.longitude);
//   double lat2 = degreesToRadians(point2.latitude);
//   double lon2 = degreesToRadians(point2.longitude);

//   double dLat = lat2 - lat1;
//   double dLon = lon2 - lon1;

//   double a =
//       pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
//   double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//   double distance = earthRadius * c;

//   return distance;
// }

// class LatLng {
//   double latitude;
//   double longitude;

//   LatLng(this.latitude, this.longitude);
// }
