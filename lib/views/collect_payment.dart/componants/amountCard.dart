import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_icon_button/loading_icon_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/constants.dart';
import '../../../../responsive.dart';
import '../../../globalWidgets/button.dart';

class CollectAmountCard extends StatefulWidget {
  const CollectAmountCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CollectAmountCard> createState() => _CollectAmountCardState();
}

class _CollectAmountCardState extends State<CollectAmountCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
                color: tWhite,
                boxShadow: [tBoxShadow],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currencySymbol + "100",
                  style: GoogleFonts.mulish(
                      fontSize: isTab(context) ? 22.sp : 25.sp,
                      fontWeight: FontWeight.w800,
                      color: tSecondaryColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "collect_amount".tr,
                  style: GoogleFonts.mulish(
                      fontSize: isTab(context) ? 10.sp : 13.sp,
                      fontWeight: FontWeight.w600,
                      color: tSecondaryColor),
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
                    style: TextStyle(
                        color: tWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: isTab(context) ? 10.sp : 12.sp),
                  ),
                  loader: Container(
                    padding: EdgeInsets.all(20),
                    child: SpinKitRotatingCircle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: (startLoading, stopLoading, btnState) {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
