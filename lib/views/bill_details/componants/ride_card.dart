import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../responsive.dart';

class RideCardWidget extends StatelessWidget {
  const RideCardWidget({
    Key? key,
    this.rideDetails,
  }) : super(key: key);
  final rideDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: tWhite,
          boxShadow: [tBoxShadow],
          borderRadius: BorderRadius.circular(8)),
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
                      'EG-065960506',
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 10.sp : 12.sp,
                      ),
                    ),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: tgreen),
                        child: Icon(
                          Icons.check,
                          color: tWhite,
                          size: isTab(context) ? 10 : 15,
                        )),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      'Completed',
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
                    child: Text(
                  '20th Dec 2022, 09:30 AM',
                  // rideDetails['id'].toString(),
                  style: GoogleFonts.mulish(
                    color: tbrown,
                    fontSize: isTab(context) ? 10.sp : 11.sp,
                    fontWeight: FontWeight.w600,
                    // fontFamily:
                  ),
                )),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Out station',
                      // rideDetails['date-time'].toString(),
                      // style: TextStyle(
                      //     fontSize: isTab(context) ? 8.sp : 12.sp,
                      //     color: tGray,
                      //     fontWeight: FontWeight.w400),
                      style: GoogleFonts.mulish(
                        color: tbrown,
                        fontSize: isTab(context) ? 10.sp : 11.sp,
                        fontWeight: FontWeight.w600,
                        // fontFamily:
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Round trip',
                      // rideDetails['date-time'].toString(),
                      // style: TextStyle(
                      //     fontSize: isTab(context) ? 8.sp : 12.sp,
                      //     color: tGray,
                      //     fontWeight: FontWeight.w400),
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontSize: isTab(context) ? 10.sp : 11.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                          'Mini',
                          style: GoogleFonts.mulish(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 10.sp : 12.sp,
                            fontWeight: FontWeight.w700,
                            // fontFamily:
                          ),
                        ),
                        Text(
                          '(Luxury)',
                          style: GoogleFonts.mulish(
                            color: tbrown,
                            fontSize: isTab(context) ? 8.sp : 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'AP39 AB 2324',
                      // rideDetails['date-time'].toString(),
                      // style: TextStyle(
                      //     fontSize: isTab(context) ? 8.sp : 12.sp,
                      //     color: tGray,
                      //     fontWeight: FontWeight.w400),
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontSize: isTab(context) ? 8.sp : 11.sp,
                        fontWeight: FontWeight.w700,
                        // fontFamily:
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
