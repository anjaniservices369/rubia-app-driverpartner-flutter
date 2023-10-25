import 'package:badges/badges.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AcceptedRideDetails extends StatefulWidget {
  const AcceptedRideDetails({Key? key, this.booking});
  final booking;
  @override
  State<AcceptedRideDetails> createState() => _AcceptedRideDetailsState();
}

class _AcceptedRideDetailsState extends State<AcceptedRideDetails> {
  var checkDetails;
  var resNok;
  fetchCheckDetails() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var checkRes = await UserAPI().checkApi(pref.getString('authCode')!);
    if (checkRes != null && checkRes['status'] == 'OK') {
      if (checkRes['detail'] != null) {
        setState(() {
          checkDetails = checkRes['detail'];
        });
      }
    } else {
      setState(() {
        resNok = checkDetails['status'];
      });
    }
  }

  @override
  void initState() {
    fetchCheckDetails();
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double? usageHours = double.parse(widget.booking['usage_hours']);

    String usageText;
    if (usageHours != null) {
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
    } else {
      usageText = 'Usage hours not available'; // Handle the case where 'usage_hours' is null
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 3.5.w),
      child: GestureDetector(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(color: tWhite, borderRadius: BorderRadius.circular(10)),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(
                  child: Image.asset(
                    Images.LINE,
                    scale: 3,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h, bottom: 1.h, left: 3.5.w, right: 3.5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Id: #' + widget.booking['id'].toString(),
                        style: GoogleFonts.mulish(
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 9.sp : 13.sp,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.booking['car_model'].toString() + ' ( ',
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 11.sp,
                            ),
                          ),
                          Text(
                            widget.booking['car_type'] == CAR_TYPE_AUTOMATIC ? 'Automatic' : 'Manual',
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 11.sp,
                            ),
                          ),
                          Text(
                            ' )',
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
                            Twl.dateReverseFormate(widget.booking['pickup_date'].toString()) + ', ',
                            style: GoogleFonts.mulish(
                              color: tSecondaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 11.sp,
                            ),
                          ),
                          Text(
                            widget.booking['pickup_time'].toString(),
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
                              fontSize: isTab(context) ? 9.sp : 12.sp,
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
                            widget.booking['trip_type'] == TRIP_TYPE_INTERCITY ? Images.INCITY : Images.OUTSTETION,
                            scale: widget.booking['trip_type'] == TRIP_TYPE_INTERCITY
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
                            widget.booking['trip_type'] == TRIP_TYPE_INTERCITY ? 'In city' : 'Out station',
                            style: GoogleFonts.mulish(
                              color: tbrown,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 13.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          widget.booking['rider_type'] == RIDER_TYPE_ONEWAY
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
                            widget.booking['rider_type'] == RIDER_TYPE_ONEWAY ? 'One way' : 'Round trip',
                            style: GoogleFonts.mulish(
                              color: tbrown,
                              fontWeight: FontWeight.w700,
                              fontSize: isTab(context) ? 9.sp : 13.sp,
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
                      Text(
                        'Estimate fare',
                        style: GoogleFonts.mulish(
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: isTab(context) ? 14.sp : 16.sp,
                        ),
                      ),
                      // badges.Badge(
                      //   badgeStyle:
                      //       BadgeStyle(badgeColor: Colors.transparent),
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
                      //     //                   BorderRadius.circular(10)),
                      //     //           child: EstimateWidget(
                      //     //             estimateDetails: widget.booking,
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
                      Text(
                        currencySymbol + widget.booking['estimate_price'].toString(),
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
                widget.booking['rider_type'] == RIDER_TYPE_ONEWAY
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
                                      widget.booking['pickup_address'].toString(),
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
                                      widget.booking['drop_address'].toString(),
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
                                  widget.booking['pickup_address'].toString(),
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
                  height: 4.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 30.w,
                    //   height: 7.h,
                    //   child: Button(
                    //     color: tWhite,
                    //     textcolor: tRed,
                    //     loadingColor: tRed,
                    //     bottonText: 'Reject ride'.tr,
                    //     borderSide: BorderSide(
                    //       color: tRed,
                    //     ),
                    //     onTap: (startLoading, stopLoading, btnState) async {
                    //       startLoading();
                    //       Map<String, String> param = {
                    //         'booking_id': widget.booking['id'].toString(),
                    //       };
                    //       var res = await RideBookingsApi()
                    //           .rejectRideApi(context, param);
                    //       if (res != null && res['status'] == 'OK') {
                    //         Twl.forceNavigateTo(
                    //             context,
                    //             BottomNavigation(
                    //               tabIndexId: 1,
                    //             ));
                    //         stopLoading();
                    //       } else {
                    //         stopLoading();
                    //         Twl.createAlert(
                    //             context, 'Oops', res['error'].toString());
                    //       }
                    //       stopLoading();
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: 4.w,
                    // ),
                    Container(
                      height: isTab(context) ? 70 : 7.h,
                      width: 55.w,
                      child: Button(
                        color: tPrimaryColor,
                        textcolor: tWhite,
                        bottonText: 'Accept Ride'.tr,
                        borderSide: BorderSide(
                          color: tPrimaryColor,
                        ),
                        onTap: (startLoading, stopLoading, btnState) async {
                          // if (checkDetails != null) {
                          if (checkDetails['booking_eligibility']) {
                            startLoading();
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, String> param = {
                              'booking_id': widget.booking['id'].toString(),
                            };
                            var res = await RideBookingsApi().acceptRideApi(context, param);
                            if (res != null && res['status'] == 'OK') {
                              setState(() {
                                isLoading = true;
                                Twl.forceNavigateTo(
                                    context,
                                    BottomNavigation(
                                      tabIndexId: 1,
                                      tabIndexType: 1,
                                    ));
                              });

                              stopLoading();
                            } else {
                              stopLoading();
                              Twl.createAlert(context, 'Oops', "You cannot accept another ride while you have an active ride in progress");
                            }
                            stopLoading();
                          } else {
                            stopLoading();
                            Twl.wallateShowDailogBox(context, checkDetails);
                            stopLoading();
                          }
                          // }
                          //  else {
                          //   Twl.createAlert(context, 'Oops', 'Driver Details not found please contact admin');
                          // }
                        },
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 2.h,
                // ),
              ]))),
    );
  }
}
