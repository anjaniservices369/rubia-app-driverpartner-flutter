import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/constants.dart';
import '../../../../responsive.dart';

class OrderID extends StatefulWidget {
  const OrderID({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderID> createState() => _OrderIDState();
}

class _OrderIDState extends State<OrderID> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.8.h),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
      color: tAppbarColor,
      child: Row(
        children: [
          Text(
            'Ride IDd: ',
            style: GoogleFonts.mulish(
              color: tBlack,
              fontSize: isTab(context) ? 9.sp : 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'EG65406504',
            style: GoogleFonts.mulish(
              color: tBlack,
              fontSize: isTab(context) ? 9.sp : 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
