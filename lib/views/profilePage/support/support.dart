import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/profilePage/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';

import '../../../responsive.dart';
// import 'components/customerSupport.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: tWhite,
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tYellow,
        leading: GestureDetector(
          onTap: () {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
                color: tWhite,
                boxShadow: [tBoxShadow],
                borderRadius: BorderRadius.circular(6)),
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: tBlue,
              size: 16,
            ),
          ),
        ),
        centerTitle: false,
        title: Text('Support',
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: WillPopScope(
          onWillPop: () {
            return Twl.forceNavigateTo(
                context, BottomNavigation(tabIndexId: 3));
          },
          child: CustomerSupport()),
    );
  }
}

class CustomerSupport extends StatefulWidget {
  const CustomerSupport({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerSupport> createState() => _CustomerSupportState();
}

class _CustomerSupportState extends State<CustomerSupport> {
  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
      );
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 4.h,
        ),
        decoration: BoxDecoration(
            boxShadow: [tBoxShadow],
            color: tWhite,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Customer Support',
              style: GoogleFonts.mulish(
                color: tBlue,
                fontSize: isTab(context) ? 9.sp : 12.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 8.w),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.h),
              decoration: BoxDecoration(
                  boxShadow: [tBoxShadow],
                  color: tWhite,
                  border: Border.all(color: tPrimaryColor, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: GestureDetector(
                onTap: () async {
                  await launchURL(CHAT_LINK);
                },
                child: Row(
                  children: [
                    Image.asset(
                      Images.EMAILSUPPORT,
                      scale: 4,
                    ),
                    SizedBox(
                      width: 0.6.w,
                    ),
                    Text(
                      'Chat',
                      style: GoogleFonts.mulish(
                        color: tPrimaryColor,
                        fontSize: isTab(context) ? 12.sp : 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
