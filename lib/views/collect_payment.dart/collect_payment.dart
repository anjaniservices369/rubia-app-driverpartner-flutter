import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bill_details/bill_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/imageConstant.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../responsive.dart';
import '../../globalWidgets/button.dart';
import 'componants/amountCard.dart';
import 'componants/collect_cash_botomsheet.dart';
import 'componants/generateQR_card.dart';
import 'componants/orderid.dart';

class CollectPayment extends StatefulWidget {
  CollectPayment({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<CollectPayment> createState() => _CollectPaymentState();
}

class _CollectPaymentState extends State<CollectPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: tWhite,
        title: Text(
          'collect_payment'.tr,
          style: GoogleFonts.mulish(
            color: tBlack,
            fontSize: isTab(context) ? 10.sp : 13.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.h),
            child: TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: tPrimaryColor,
                  ),
                  SizedBox(
                    width: 0.5.w,
                  ),
                  Text(
                    'support'.tr,
                    style: GoogleFonts.mulish(
                      color: tPrimaryColor,
                      fontSize: isTab(context) ? 7.sp : 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, BillDetailsPage(bookingDetails: widget.bookingDetails));
        },
        child: SingleChildScrollView(
          child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0.8.h),
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
                    color: tAppbarColor,
                    child: Row(
                      children: [
                        Text(
                          'Ride ID: #',
                          style: GoogleFonts.mulish(
                            color: tBlack,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.bookingDetails['id'].toString(),
                          style: GoogleFonts.mulish(
                            color: tBlack,
                            fontSize: isTab(context) ? 9.sp : 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currencySymbol + ((widget.bookingDetails['price_detail']['estimatePrice'] + (widget.bookingDetails['Pending_cancellation_charges'] ?? 0)).toStringAsFixed(0)),
                                style: GoogleFonts.mulish(fontSize: isTab(context) ? 22.sp : 25.sp, fontWeight: FontWeight.w800, color: tSecondaryColor),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "collect_amount".tr,
                                style: GoogleFonts.mulish(fontSize: isTab(context) ? 10.sp : 13.sp, fontWeight: FontWeight.w600, color: tSecondaryColor),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              ArgonButton(
                                height: isTab(context) ? 70 : 45,
                                width: 38.w,
                                color: tPrimaryColor,
                                borderRadius: 12,
                                borderSide: BorderSide(color: tPrimaryColor),
                                child: Text(
                                  "view_bill".tr,
                                  style: TextStyle(color: tWhite, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 10.sp : 12.sp),
                                ),
                                loader: Container(
                                  padding: EdgeInsets.all(20),
                                  child: SpinKitRotatingCircle(
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: (startLoading, stopLoading, btnState) {
                                  Twl.forceNavigateTo(context, BillDetailsPage(bookingDetails: widget.bookingDetails));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Center(
                      // child: QrImage(
                      //   data: "https://docs.cashfree.com/docs/flutter-sdk",
                      //   version: QrVersions.auto,
                      //   size: 250,
                      // ),
                      // child: Column(
                      //   children: [
                      //     Image.asset(
                      //       Images.QR_CODE,
                      //       scale: 2,
                      //     ),
                      //     SizedBox(height: 2.h),
                      //     Text(
                      //       "UPI id : @paytm",
                      //        style: GoogleFonts.mulish(
                      //         color: tBlack,
                      //         fontSize: isTab(context) ? 16.sp : 14.sp,
                      //         fontWeight: FontWeight.w800,
                      //       ),
                      //     ),
                      //     SizedBox(height: 2.h),
                      //     Center(
                      //       child: Button(
                      //         borderSide: BorderSide(
                      //           color: tPrimaryColor,
                      //         ),
                      //         textcolor: tWhite,
                      //         color: tPrimaryColor,
                      //         bottonText: "Continue".tr,
                      //         onTap: (startLoading, stopLoading, btnState) async {
                      //           showModalBottomSheet(
                      //               context: context,
                      //               isScrollControlled: true,
                      //               enableDrag: true,
                      //               isDismissible: true,
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(30.0),
                      //               ),
                      //               builder: (context) {
                      //                 return Padding(
                      //                   padding: MediaQuery.of(context).viewInsets,
                      //                   child: Container(
                      //                     child: Wrap(
                      //                       children: [DriverAddReviews(bookingDetails: widget.bookingDetails)],
                      //                     ),
                      //                   ),
                      //                 );
                      //               });
                      //         },
                      //       ),
                      //     ),
                      //   ],
                      // ),

                    ),
                  ),
                  // SizedBox(
                  //   height: 1.h,
                  // ),
                  // Text(
                  //   'or'.tr,
                  //   style: GoogleFonts.mulish(
                  //     color: tBlack,
                  //     fontSize: isTab(context) ? 18.sp : 20.sp,
                  //     fontWeight: FontWeight.w800,
                  //   ),
                  // ),
                  SizedBox(
                    height: 2.h,
                  ),
                  widget.bookingDetails['payment_status'] == payment_status_success
                      ? widget.bookingDetails['user_my_ratings'] == ''
                      ? Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Cash Collected',
                          style: GoogleFonts.mulish(
                            color: tBlack,
                            fontSize: isTab(context) ? 18.sp : 14.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Center(
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
                                          children: [DriverAddReviews(bookingDetails: widget.bookingDetails)],
                                        ),
                                      ),
                                    );
                                  });
                              stopLoading();
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                      : Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Cash Collected',
                      style: GoogleFonts.mulish(
                        color: tBlack,
                        fontSize: isTab(context) ? 18.sp : 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                      : Center(
                    child: Center(
                      child: Button(
                        borderSide: BorderSide(
                          color: tPrimaryColor,
                        ),
                        textcolor: tWhite,
                        color: tPrimaryColor,
                        bottonText: "collect_cash".tr,
                        onTap: (startLoading, stopLoading, btnState) async {
                          startLoading();
                          var res = await RideBookingsApi().fetchCollectCashApi(context, widget.bookingDetails['id'].toString(),widget.bookingDetails['user_id'].toString());
                          if (res != null && res['status'] == 'OK') {
                            stopLoading();
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
                                        children: [DriverAddReviews(bookingDetails: widget.bookingDetails)],
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            stopLoading();
                            Twl.createAlert(context, 'Oops', res['error'].toString());
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
