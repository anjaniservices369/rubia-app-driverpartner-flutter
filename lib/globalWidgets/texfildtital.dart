import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../responsive.dart';

class TextFildTital extends StatelessWidget {
  const TextFildTital({
    Key? key,
    this.text,
  }) : super(key: key);

  final text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mulish(
          fontWeight: FontWeight.w600,
          color: tSecondaryColor,
          fontSize: isTab(context) ? 10.sp : 12.sp),
    );
  }
}
