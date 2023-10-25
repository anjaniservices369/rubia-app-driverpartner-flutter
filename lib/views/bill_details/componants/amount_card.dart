import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../../constants/constants.dart';
import '../../../../../responsive.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({
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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '5Hours',
                      // 'amount'.tr,
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
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
                        child: Text('+ ' + currencySymbol + '212',
                            // rideDetails['total_fare'].toString(),
                            style: TextStyle(
                                fontSize: isTab(context) ? 8.sp : 12.sp,
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
                    Text(
                      'GST',
                      // 'amount'.tr,
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
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
                        child: Text('+ ' + currencySymbol + '122',
                            // rideDetails['total_fare'].toString(),
                            style: TextStyle(
                                fontSize: isTab(context) ? 8.sp : 12.sp,
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
                    Text(
                      'Sub total',
                      // 'amount'.tr,
                      style: TextStyle(
                          color: tSecondaryColor,
                          fontSize: isTab(context) ? 8.sp : 12.sp,
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
                        child: Text(currencySymbol + '22',
                            // rideDetails['total_fare'].toString(),
                            style: TextStyle(
                                fontSize: isTab(context) ? 8.sp : 12.sp,
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
                              fontSize: isTab(context) ? 8.sp : 12.sp,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 1.w),
                        // rideDetails['user']['coupon_code'] != null
                        //     ?
                        Text(
                          '|',
                          style: TextStyle(
                              color: tGray,
                              fontSize: isTab(context) ? 8.sp : 12.sp,
                              fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(width: 1.w),
                        // rideDetails['user']['coupon_code'] != null
                        //     ?
                        Text(
                          'T20RIDE',
                          // rideDetails['user']['coupon_code'].toString(),
                          style: TextStyle(
                              color: tbluew,
                              fontSize: isTab(context) ? 8.sp : 12.sp,
                              fontWeight: FontWeight.w600),
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
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                    color: tRed,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            child: Text(currencySymbol + '100',
                                style: TextStyle(
                                    fontSize: isTab(context) ? 8.sp : 12.sp,
                                    color: tRed,
                                    fontWeight: FontWeight.bold))),
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
                          fontSize: isTab(context) ? 10.sp : 14.sp,
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
                        currencySymbol + '17509',
                        // rideDetails['total_fare'].toString(),
                        style: TextStyle(
                            color: tSecondaryColor,
                            fontSize: isTab(context) ? 10.sp : 14.sp,
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
    );
  }
}
