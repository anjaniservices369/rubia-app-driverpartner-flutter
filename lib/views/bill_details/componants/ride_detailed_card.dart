import 'package:base_project_flutter/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:badges/badges.dart';
import '../../../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';

class RideDetailsLocationCard extends StatelessWidget {
  const RideDetailsLocationCard({
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
                        padding: EdgeInsets.all(isTab(context) ? 15 : 8),
                        decoration: BoxDecoration(
                            // color: tbackground,
                            shape: BoxShape.circle),
                        child: Image.asset(
                          Images.LOCATIONGREEN,
                          scale: isTab(context) ? 2 : 4,
                          // color: tGray,
                        )),
                    Column(
                      children: [
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Container(
                          height: 0.6.h,
                          width: 0.5.w,
                          decoration: BoxDecoration(
                              color: tlightGray, shape: BoxShape.rectangle),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.all(isTab(context) ? 15 : 8),
                        decoration: BoxDecoration(
                            // color: tlocationbgtwo,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          'Spline Arcade, Aayyappa Society, Madhapur, Telangana (500081)',
                          // rideDetails['pickup_address'].toString(),
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
                        'Secunderabad Railway Station, Secunderabad, Telangana (500081)',
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
    );
  }
}
