import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:badges/badges.dart';
import '../../../../../constants/constants.dart';

class DistanceAndDurationCardWidget extends StatelessWidget {
  const DistanceAndDurationCardWidget({
    Key? key,
    this.rideDetails,
  }) : super(key: key);
  final rideDetails;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
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
                    fontSize: isTab(context) ? 11.sp : 14.sp,
                    fontWeight: FontWeight.w700,
                    // fontFamily:
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),

                Text(
                  "5" + " " + "kms",
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w700,
                    // fontFamily:
                  ),
                ),

                // Row(
                //   children: [
                //     rideDetails['final_distance'] == null
                //         ? Text(
                //             '0',
                //             style: GoogleFonts.mulish(
                //               color: tWhite,
                //               fontSize: isTab(context) ? 12.sp : 16.sp,
                //               fontWeight: FontWeight.w900,
                //               // fontFamily:
                //             ),
                //           )
                //         : Text(
                //             rideDetails['final_distance'].toString(),
                //             style: GoogleFonts.mulish(
                //               color: tWhite,
                //               fontSize: isTab(context) ? 12.sp : 16.sp,
                //               fontWeight: FontWeight.w900,
                //               // fontFamily:
                //             ),
                //           ),
                //     Text(
                //       'km'.tr,
                //       textAlign: TextAlign.end,
                //       style: GoogleFonts.mulish(
                //         color: tWhite,
                //         fontSize: isTab(context) ? 9.sp : 13.sp,
                //         fontWeight: FontWeight.w700,
                //         // fontFamily:
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            // Container(
            //   height: 8.h,
            //   width: 0.3.w,
            //   color:  tDivider,
            // ),
            Column(
              children: [
                Text(
                  'Time'.tr,
                  style: GoogleFonts.mulish(
                    color: tbrown,
                    fontSize: isTab(context) ? 11.sp : 14.sp,
                    fontWeight: FontWeight.w700,
                    // fontFamily:
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),

                Text(
                  "18" + " " + "min",
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w700,
                    // fontFamily:
                  ),
                ),

                // Row(
                //   children: [
                //     rideDetails['final_time'] == null
                //         ? Text(
                //             '0',
                //             style: GoogleFonts.mulish(
                //               color: tWhite,
                //               fontSize: isTab(context) ? 12.sp : 16.sp,
                //               fontWeight: FontWeight.w900,
                //               // fontFamily:
                //             ),
                //           )
                //         : Text(
                //             rideDetails['final_time'].toString(),
                //             style: GoogleFonts.mulish(
                //               color: tWhite,
                //               fontSize: isTab(context) ? 12.sp : 16.sp,
                //               fontWeight: FontWeight.w900,
                //               // fontFamily:
                //             ),
                //           ),
                //     Text(
                //       'mins'.tr,
                //       textAlign: TextAlign.end,
                //       style: GoogleFonts.mulish(
                //         color: tWhite,
                //         fontSize: isTab(context) ? 9.sp : 13.sp,
                //         fontWeight: FontWeight.w700,
                //         // fontFamily:
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            // Container(
            //   height: 8.h,
            //   width: 0.3.w,
            //   color:  tDivider,
            // ),
            Column(
              children: [
                Text(
                  'Amount'.tr,
                  style: GoogleFonts.mulish(
                    color: tbrown,
                    fontSize: isTab(context) ? 11.sp : 14.sp,
                    fontWeight: FontWeight.w700,
                    // fontFamily:
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),

                Text(
                  currencySymbol + '1200.00',
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontSize: isTab(context) ? 10.sp : 12.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // Row(
                // children: [

                // rideDetails['total_fare'] == null
                //     ? Text(
                //         '0',
                //         style: GoogleFonts.mulish(
                //           color: tWhite,
                //           fontSize: isTab(context) ? 12.sp : 16.sp,
                //           fontWeight: FontWeight.w900,
                //           // fontFamily:
                //         ),
                //       )
                //     : Text(
                //         rideDetails['total_fare'].toString(),
                //         style: GoogleFonts.mulish(
                //           color: tWhite,
                //           fontSize: isTab(context) ? 12.sp : 16.sp,
                //           fontWeight: FontWeight.w900,
                //           // fontFamily:
                //         ),
                //       ),
                // ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
