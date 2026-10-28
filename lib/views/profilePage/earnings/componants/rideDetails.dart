// ----------------------------------------------------------------------
// Earnings by ride
//
// List of rides that produced the earnings.
// ----------------------------------------------------------------------

// import 'package:base_project_flutter/views/profilePage/earnings/componants/driverRideInfo.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/imageConstant.dart';
import '../../../../constants/stetuesConstant.dart';
import '../../../../globalFuctions/globalFunctions.dart';
import '../../../../responsive.dart';
import 'driverRideInfo.dart';

// >>> START  class rideDetails
class rideDetails extends StatefulWidget {
  const rideDetails({
    Key? key,
    this.earningsData,
    this.page,
    this.totalPages,
    this.resNOK,
    this.errorMessage,
    this.showDriverEarnings,
    this.status,

  }) : super(key: key);
  final earningsData;
  final page;
  final totalPages;
  final resNOK;
  final errorMessage;
  final showDriverEarnings;
  final status;

  @override
  State<rideDetails> createState() => _rideDetails();
}
// <<< END    class rideDetails

// >>> START  class _rideDetails
class _rideDetails extends State<rideDetails> {

  // >>> START  _rideDetails.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.earningsData.length == 0
            ? Align(
            alignment: Alignment.center, child: Container())
            : Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 12, vertical: 2),
          child: Row(
            children: [
              Text(
                "earnings_by_orders".tr,
                style: GoogleFonts.mulish(
                    color: tBlue,
                    fontWeight: FontWeight.w700,
                    fontSize:
                    isTab(context) ? 13.sp : 15.sp),
              ),
              Text(
                '(' +
                    widget.earningsData.length.toString() +
                    ')',
                style: GoogleFonts.mulish(
                    color: tLightBrown,
                    fontWeight: FontWeight.w600,
                    fontSize:
                    isTab(context) ? 13.sp : 15.sp),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h),
        ListView.builder(
            itemCount: widget.earningsData.length,

            // earningList.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index == widget.earningsData.length) {
                if (widget.page < widget.totalPages) {
                  return Center(
                      child: CircularProgressIndicator());
                } else {
                  return widget.resNOK == 'NOK'
                      ? Container(
                    height: MediaQuery.of(context)
                        .size
                        .height /
                        1.5,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'No Bookings found',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: isTab(context)
                                ? 9.sp
                                : 12.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                      : Text(
                    'No data found',
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize:
                      isTab(context) ? 9.sp : 12.sp,
                    ),
                  );
                }
              }
              if (widget.errorMessage.isNotEmpty)
                Positioned.fill(
                  child: Container(
                    color: tSecondaryColor,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          widget.errorMessage,
                          style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
              var driverEarnings = widget.earningsData[index];
              // var data = earningList[index];
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 2.h, horizontal: 3.5.w),
                child: GestureDetector(
                    onTap: () {
                      Twl.navigateTo(context, driverRideInfo(bookingDetails:driverEarnings,Status:widget.status,showDriverEarnings:widget.showDriverEarnings));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius:
                            BorderRadius.circular(10)),
                        child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2.h,
                                    bottom: 1.h,
                                    left: 3.5.w,
                                    right: 3.5.w),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      driverEarnings['id']
                                          .toString(),
                                      style: GoogleFonts.mulish(
                                        color: tBlue,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: isTab(context)
                                            ? 9.sp
                                            : 14.sp,
                                      ),
                                    ),
                                    Text(
                                        currencySymbol +
                                            (widget.showDriverEarnings
                                                ? driverEarnings['final_price'].toString()
                                                : ((driverEarnings['price_detail']['estimatePrice'] + (driverEarnings['cancellation_charges'] ?? 0)).toStringAsFixed(0))),
                                        style:
                                        GoogleFonts.mulish(
                                          color: tBlue,
                                          fontWeight:
                                          FontWeight.w800,
                                          fontSize:
                                          isTab(context)
                                              ? 12.sp
                                              : 14.sp,
                                        ))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 0.8.h),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      Twl.dateReverseFormate(
                                          driverEarnings[
                                          'pickup_date'])
                                          .toString() +
                                          ', ' +
                                          driverEarnings[
                                          'pickup_time']
                                              .toString(),
                                      style: GoogleFonts.mulish(
                                        color: tLightBrown,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: isTab(context)
                                            ? 9.sp
                                            : 11.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w,
                                    vertical: 0.8.h),
                                child: Row(
                                  children: [
                                    Text(
                                      driverEarnings[
                                      'trip_type'] ==
                                          TRIP_TYPE_INTERCITY
                                          ? 'In city'
                                          : 'Out station',
                                      style: GoogleFonts.mulish(
                                        color: tLightBrown,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: isTab(context)
                                            ? 9.sp
                                            : 11.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      driverEarnings[
                                      'rider_type'] ==
                                          RIDER_TYPE_ONEWAY
                                          ? 'One way'
                                          : 'Round trip',
                                      style: GoogleFonts.mulish(
                                        color: tBlue,
                                        fontWeight:
                                        FontWeight.w700,
                                        fontSize: isTab(context)
                                            ? 9.sp
                                            : 11.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              Divider(
                                color: tSecondaryDivider,
                                height: 2.h,
                                thickness: 0.5,
                              ),
                              driverEarnings['rider_type'] ==
                                  RIDER_TYPE_ONEWAY
                                  ? Padding(
                                padding:
                                const EdgeInsets.all(
                                    12.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets
                                                .all(isTab(
                                                context)
                                                ? 12
                                                : 8),
                                            decoration: BoxDecoration(
                                                color:
                                                tBackground,
                                                shape: BoxShape
                                                    .circle),
                                            child: Image
                                                .asset(
                                              Images
                                                  .LOCATIONGREEN,
                                              scale: isTab(
                                                  context)
                                                  ? 2
                                                  : 3,
                                            )),
                                        DottedLine(
                                          direction: Axis
                                              .vertical,
                                          lineLength: 30,
                                          lineThickness:
                                          1.0,
                                          dashLength: 4.0,
                                          dashColor:
                                          tDotted,
                                          // dashGradient: [Colors.red, Colors.blue],
                                          // dashRadius: 0.0,
                                          dashGapLength:
                                          4.0,
                                          // dashGapColor: Colors ansparent,
                                          // dashGapGradient: [Colors.red, Colors.blue],
                                          dashGapRadius:
                                          0.0,
                                        ),
                                        // Column(
                                        //   children: [
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //     Container(
                                        //       height: 0.6.h,
                                        //       width: 0.5.w,
                                        //       decoration: BoxDecoration(
                                        //           color: tBlack,
                                        //           shape: BoxShape.circle),
                                        //     ),
                                        //   ],
                                        // ),
                                        Container(
                                            padding: EdgeInsets
                                                .all(isTab(
                                                context)
                                                ? 12
                                                : 8),
                                            decoration: BoxDecoration(
                                                color:
                                                tBackground,
                                                shape: BoxShape
                                                    .circle),
                                            child: Image
                                                .asset(
                                              Images
                                                  .REDLOCATIONICON,
                                              scale: isTab(
                                                  context)
                                                  ? 2
                                                  : 3,
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            driverEarnings[
                                            'pickup_address']
                                                .toString(),
                                            // rideDetails.pickupAddress.toString(),
                                            textAlign:
                                            TextAlign
                                                .start,
                                            style:
                                            GoogleFonts
                                                .mulish(
                                              color:
                                              tBlue,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: isTab(
                                                  context)
                                                  ? 9.sp
                                                  : 11.sp,
                                            ),
                                            maxLines: 2,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                          // VerticalDivider(
                                          //   width: 10,
                                          //   color: tRed,
                                          //   indent: 30,
                                          // ),
                                          Container(
                                            margin: EdgeInsets
                                                .symmetric(
                                                vertical:
                                                2.h),
                                            width: double
                                                .infinity,
                                            height: 0.1.h,
                                            decoration:
                                            BoxDecoration(
                                                color:
                                                tlightGray),
                                          ),
                                          Container(
                                              child: Text(
                                                driverEarnings[
                                                'drop_address'],
                                                // rideDetails.dropAddress.toString(),
                                                textAlign:
                                                TextAlign
                                                    .start,
                                                style:
                                                GoogleFonts
                                                    .mulish(
                                                  color:
                                                  tBlue,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                  fontSize: isTab(
                                                      context)
                                                      ? 9.sp
                                                      : 11.sp,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  : Container(
                                  margin:
                                  EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: tWhite,
                                      borderRadius:
                                      BorderRadius
                                          .circular(8),
                                      boxShadow: [
                                        tBoxShadow
                                      ]),
                                  child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .all(12.0),
                                      child: Row(children: [
                                        Container(
                                            child:
                                            Image.asset(
                                              Images
                                                  .LOCATIONGREEN,
                                              scale:
                                              isTab(context)
                                                  ? 2
                                                  : 3.5,
                                            )),
                                        SizedBox(
                                            width: 3.w),
                                        Container(
                                          width: 30.h,
                                          child: Text(
                                            driverEarnings[
                                            'pickup_address']
                                                .toString(),
                                            textAlign:
                                            TextAlign
                                                .start,
                                            style:
                                            GoogleFonts
                                                .mulish(
                                              color:
                                              tSecondaryColor,
                                              fontWeight:
                                              FontWeight
                                                  .w600,
                                              fontSize: isTab(
                                                  context)
                                                  ? 9.sp
                                                  : 11.sp,
                                            ),
                                            maxLines: 4,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                      ]))),

                              SizedBox(
                                height: 2.h,
                              ),

                              // if (index == 1)
                              // Column(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Center(
                              //       child: SizedBox(
                              //         width: isTab(context) ? 30.w : 40.w,
                              //         height: isTab(context) ? 6.h : 6.h,
                              //         child: ButtonWidget(
                              //             borderSide: BorderSide(
                              //               color: tPrimaryColor,
                              //             ),
                              //             // borderRadius: BorderRadius.circular(15),
                              //             borderRadius: 8.0,
                              //             color: tPrimaryColor,
                              //             textcolor: Colors.black,
                              //             child: Text(
                              //               "Track_Rider".tr,
                              //               style: TextStyle(
                              //                   letterSpacing: 1,
                              //                   color: tWhite,
                              //                   fontWeight: FontWeight.w700,
                              //                   fontSize: isTab(context)
                              //                       ? 10.sp
                              //                       : 11.sp),
                              //             ),
                              //             onTap: (startLoading, stopLoading,
                              //                 btnState) async {
                              //               Twl.forceNavigateTo(
                              //                   context, NotificationPage());
                              //               // startLoading();
                              //               // if (_formKey.currentState!.validate()) {
                              //               //   // if (isChecked == true) {
                              //               //   Map<String, String> param = {
                              //               //     'contact_no': _usernumbercontroller.text,
                              //               //   };
                              //               //   print(param);
                              //               //   var res =
                              //               //       await UserAPI().sendOtp(context, param);
                              //               //   if (res != null && res['status'] == 'OK') {
                              //               //     Twl.navigateTo(
                              //               //         context,
                              //               //         Otppage(
                              //               //           mobileNumber:
                              //               //               _usernumbercontroller.text,
                              //               //           sessionCode: res['details']
                              //               //               ['Details'],
                              //               //         ));
                              //               //   } else {
                              //               //     stopLoading();
                              //               //     Twl.createAlert(context, 'Oops',
                              //               //         res['error'].toString());
                              //               //     stopLoading();
                              //               //   }
                              //               //   stopLoading();
                              //               //   // } else {
                              //               //   //   stopLoading();
                              //               //   //   // return _showDialog(context);
                              //               //   // }

                              //               // }
                              //               // stopLoading();
                              //             }),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       height: 2.h,
                              //     ),
                              //   ],
                              // )
                            ]))),
              );
            })
      ],
    );
  }
  // <<< END    _rideDetails.build()
}
// <<< END    class _rideDetails
