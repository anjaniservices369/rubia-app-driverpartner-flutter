import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/constants.dart';
import '../../../responsive.dart';

class FinalpriceListWidget extends StatelessWidget {
  const FinalpriceListWidget({
    Key? key,
    required this.title,
    this.value,
  }) : super(key: key);

  final title;
  final value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title,
              style: GoogleFonts.mulish(
                color: tSecondaryColor,
                fontWeight: FontWeight.w400,
                fontSize: isTab(context) ? 7.sp : 12.sp,
              )),
          Spacer(),
          Text(" $currencySymbol $value",
              style: GoogleFonts.mulish(
                color: tSecondaryColor,
                fontWeight: FontWeight.w500,
                fontSize: isTab(context) ? 7.sp : 12.sp,
              )),
        ],
      ),
    );
  }
}
