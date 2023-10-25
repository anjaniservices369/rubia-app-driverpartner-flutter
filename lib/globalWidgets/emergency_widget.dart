import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';
import '../responsive.dart';

class Emergencywidget extends StatelessWidget {
  const Emergencywidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25.h,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Police Dial",
                    style: GoogleFonts.mulish(
                        color: tBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 14.sp : 16.sp)),
                GestureDetector(
                  onTap: () {
                    launch(
                      "tel://" + '100',
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: tgreen),
                      child: Icon(
                        Icons.call,
                        color: tWhite,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ambulance Dial",
                    style: GoogleFonts.mulish(
                        color: tBlack,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 14.sp : 16.sp)),
                GestureDetector(
                  onTap: () {
                    launch(
                      "tel://" + '108',
                    );
                  },
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: tgreen),
                      child: Icon(
                        Icons.call,
                        color: tWhite,
                      )),
                ),
              ],
            )
          ],
        ));
  }
}
