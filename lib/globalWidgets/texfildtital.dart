// ----------------------------------------------------------------------
// Text-box title
//
// Small label shown above a text box.
// ----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';
import '../responsive.dart';

// >>> START  class TextFildTital
class TextFildTital extends StatelessWidget {
  const TextFildTital({
    Key? key,
    this.text,
  }) : super(key: key);

  final text;
  // >>> START  TextFildTital.build()  -  draws this screen / widget (its layout)
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
  // <<< END    TextFildTital.build()
}
// <<< END    class TextFildTital
