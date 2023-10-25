import 'package:badges/badges.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/BookingStatusConstants.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bill_details/rideMapScreen.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/collect_payment.dart/componants/collect_cash_botomsheet.dart';
import 'package:base_project_flutter/views/profilePage/support/support.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/imageConstant.dart';

import '../../../../responsive.dart';
import '../../globalWidgets/button.dart';
import '../bookingsPage/componats/estimated_fare.dart';
import '../collect_payment.dart/collect_payment.dart';
import '../ride_info/final_bill_amount.dart';
import 'componants/amount_card.dart';
import 'componants/distance_card.dart';
import 'componants/ride_card.dart';
import 'componants/ride_detailed_card.dart';

class BillDetailsPage extends StatefulWidget {
  const BillDetailsPage({
    Key? key,
    this.bookingDetails,
  }) : super(key: key);
  final bookingDetails;
  @override
  State<BillDetailsPage> createState() => _BillDetailsPageState();
}

class _BillDetailsPageState extends State<BillDetailsPage> {
  @override
  void initState() {
    fetchrideDetails();
    // TODO: implement initState
    super.initState();
  }

  var bookingDetails;
  var resNOK;
  fetchrideDetails() async {
    var res = await RideBookingsApi().fetchBookigDetails(context, widget.bookingDetails['id'].toString());
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

  var usageText;
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
      usageText = 'Usage hours not available'; // Handle the case where 'usage_hours' is null
    }
  }

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
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: tWhite, boxShadow: [tBoxShadow]),
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
                    style: TextStyle(color: tPrimaryColor, fontSize: isTab(context) ? 10.sp : 11.sp, fontWeight: FontWeight.w600),
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
          : WillPopScope(
              onWillPop: () {
                return Twl.forceNavigateTo(
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
                    Container(
                      decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.5.w, vertical: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Ride Id : #',
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 10.sp : 12.sp,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['id'].toString(),
                                      style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 10.sp : 12.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: tgreen),
                                        child: Icon(
                                          Icons.check,
                                          color: tWhite,
                                          size: isTab(context) ? 10 : 15,
                                        )),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Text(
                                      StatusConstants().getBookingStatusConstants(bookingDetails['status']).toString(),
                                      style: GoogleFonts.mulish(
                                        color: tgreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 10.sp : 12.sp,
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
                                        fontSize: isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      ' ',
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize: isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['pickup_time'],
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontSize: isTab(context) ? 10.sp : 11.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      bookingDetails['trip_type'] == TRIP_TYPE_INTERCITY ? 'In city' : 'Out station',
                                      style: GoogleFonts.mulish(
                                        color: tbrown,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 9.sp : 11.sp,
                                      ),
                                    ),
                                    Text(
                                      bookingDetails['rider_type'] == RIDER_TYPE_ONEWAY ? 'One way' : 'Round trip',
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
                                            fontSize: isTab(context) ? 10.sp : 12.sp,
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
                                      bookingDetails['vehicle_number'] == null ? 'TS0X XX XXXX' : bookingDetails['vehicle_number'].toString(),
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
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.w),
                        decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10), boxShadow: [tBoxShadow]),
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
                                  bookingDetails['total_distance'] != null ? bookingDetails['total_distance'].toString() : '0.0km',
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
                                    badgeStyle: BadgeStyle(badgeColor: Colors.transparent),
                                    position: BadgePosition.topEnd(),
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        // expand: false,
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) => Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                                            child: Container(
                                                height: 80.h,
                                                // height: MediaQuery.of(context).size.height / 1,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                                child: FinalBillAmountWidget(
                                                  estimateDetails: bookingDetails,
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
                                        fontSize: isTab(context) ? 11.sp : 13.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),

                                SizedBox(
                                  height: 1.h,
                                ),
                                bookingDetails['price_detail']['estimatePrice'] == null
                                    ? Container(
                                        child: Text('0'),
                                      )
                                    : Text(
                                        currencySymbol + bookingDetails['price_detail']['estimatePrice'].toStringAsFixed(0),
                                        style: GoogleFonts.mulish(
                                          color: tSecondaryColor,
                                          fontSize: isTab(context) ? 10.sp : 12.sp,
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
                            decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.all(isTab(context) ? 15 : 8),
                                              decoration: BoxDecoration(shape: BoxShape.circle),
                                              child: Image.asset(
                                                Images.LOCATIONGREEN,
                                                scale: isTab(context) ? 2 : 4,
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
                                              padding: EdgeInsets.all(isTab(context) ? 15 : 8),
                                              decoration: BoxDecoration(shape: BoxShape.circle),
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Text(
                                                bookingDetails['pickup_address'],
                                                style: GoogleFonts.mulish(
                                                  color: tSecondaryColor,
                                                  fontSize: isTab(context) ? 9.sp : 11.sp,
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
                                                fontSize: isTab(context) ? 9.sp : 11.sp,
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
                            decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(8), boxShadow: [tBoxShadow]),
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
                                      bookingDetails['pickup_address'].toString(),
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
                      decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(10)),
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
                                      style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 8.sp : 12.sp, fontWeight: FontWeight.w600),
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
                                        child: Text(currencySymbol + bookingDetails['subtotal'].toString(),
                                            style: TextStyle(
                                                fontSize: isTab(context) ? 8.sp : 12.sp, color: tSecondaryColor, fontWeight: FontWeight.bold))),
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
                                          style:
                                              TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 8.sp : 12.sp, fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(width: 1.w),
                                        bookingDetails['coupon_code'] == ''
                                            ? Container()
                                            : Text(
                                                '|',
                                                style: TextStyle(color: tGray, fontSize: isTab(context) ? 8.sp : 12.sp, fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                        SizedBox(width: 1.w),
                                        bookingDetails['coupon_code'] == ''
                                            ? Text(
                                                '',
                                                style: TextStyle(color: tbluew, fontSize: isTab(context) ? 8.sp : 12.sp, fontWeight: FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                bookingDetails['coupon_code'].toString(),
                                                style: TextStyle(color: tbluew, fontSize: isTab(context) ? 8.sp : 12.sp, fontWeight: FontWeight.w600),
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
                                                style: TextStyle(fontSize: isTab(context) ? 8.sp : 12.sp, color: tRed, fontWeight: FontWeight.bold))),
                                        bookingDetails['coupon_code'] == ''
                                            ? Container(
                                                child: Text(currencySymbol + '0',
                                                    style:
                                                        TextStyle(fontSize: isTab(context) ? 8.sp : 12.sp, color: tRed, fontWeight: FontWeight.bold)))
                                            : Container(
                                                child: Text(currencySymbol + bookingDetails['coupon_discount'].toString(),
                                                    style: TextStyle(
                                                        fontSize: isTab(context) ? 8.sp : 12.sp, color: tRed, fontWeight: FontWeight.bold))),
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
                                      style: TextStyle(color: tSecondaryColor, fontSize: isTab(context) ? 10.sp : 14.sp, fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    bookingDetails['price_detail']['estimatePrice'] == null
                                        ? Container(
                                            child: Text('0'),
                                          )
                                        : Container(
                                            child: Text(
                                              currencySymbol + bookingDetails['price_detail']['estimatePrice'].toStringAsFixed(0),
                                              style: TextStyle(
                                                  color: tSecondaryColor, fontSize: isTab(context) ? 10.sp : 14.sp, fontWeight: FontWeight.w600),
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
                                    Twl.forceNavigateTo(context, CollectPayment(bookingDetails: bookingDetails));
                                  }),
                            ),
                          )
                        : bookingDetails['payment_status'] == payment_status_success
                            ? Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Bill Amount Collected',
                                      style: GoogleFonts.mulish(
                                        color: tBlack,
                                        fontSize: isTab(context) ? 18.sp : 14.sp,
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
                                              onTap: (startLoading, stopLoading, btnState) async {
                                                startLoading();
                                                showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    enableDrag: true,
                                                    isDismissible: true,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(30.0),
                                                    ),
                                                    builder: (context) {
                                                      return Padding(
                                                        padding: MediaQuery.of(context).viewInsets,
                                                        child: Container(
                                                          child: Wrap(
                                                            children: [
                                                              DriverAddReviews(
                                                                bookingDetails: widget.bookingDetails,
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
                                          fontSize: isTab(context) ? 18.sp : 14.sp,
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
                                          onTap: (startLoading, stopLoading, btnState) {
                                            Twl.forceNavigateTo(context, CollectPayment(bookingDetails: bookingDetails));
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
}
