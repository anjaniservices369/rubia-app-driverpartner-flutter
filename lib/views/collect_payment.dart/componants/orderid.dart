// ----------------------------------------------------------------------
// Ride id banner
//
// Shows the ride id.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../constants/constants.dart';
import '../../../../responsive.dart';

// >>> START  class OrderID
class OrderID extends StatefulWidget {
  const OrderID({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderID> createState() => _OrderIDState();
}
// <<< END    class OrderID

// >>> START  class _OrderIDState
class _OrderIDState extends State<OrderID> {
  // >>> START  _OrderIDState.build()  -  draws this screen / widget (its layout)
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
  // <<< END    _OrderIDState.build()
}
// <<< END    class _OrderIDState
