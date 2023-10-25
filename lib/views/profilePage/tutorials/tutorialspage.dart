import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../globalFuctions/globalFunctions.dart';

class TutorialsPage extends StatefulWidget {
  const TutorialsPage({Key? key}) : super(key: key);

  @override
  _TutorialsPageState createState() => _TutorialsPageState();
}

class _TutorialsPageState extends State<TutorialsPage> {
  bool selected = true;
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text('Training tutorials',
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                decoration: BoxDecoration(
                    color: tWhite,
                    boxShadow: [tBoxShadow],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ExpansionTile(
                  title: Text(
                    "Order accept".tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontSize: isTab(context) ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    selected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: isTab(context) ? 45 : 30,
                    color: tPrimaryColor,
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      selected = expanded;
                    });
                  },
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        child: Column(
                          children: [
                            Text(
                              'How to earn more money with Rubia app?'.tr,
                              style: GoogleFonts.mulish(
                                color: tLightBrown,
                                fontSize: isTab(context) ? 12.sp : 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                'How to accept order in Rubia app?'.tr,
                                style: GoogleFonts.mulish(
                                  color: tLightBrown,
                                  fontSize: isTab(context) ? 12.sp : 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                decoration: BoxDecoration(
                    color: tWhite,
                    boxShadow: [tBoxShadow],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ExpansionTile(
                  title: Text(
                    "Order cancel".tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontSize: isTab(context) ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    selected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: isTab(context) ? 45 : 30,
                    color: tPrimaryColor,
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      selected = expanded;
                    });
                  },
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        //  height: 200,
                        //  width:200,
                        child: Column(
                          children: [
                            Text(
                              'How to earn more money with Rubia app?'.tr,
                              style: GoogleFonts.mulish(
                                color: tLightBrown,
                                fontSize: isTab(context) ? 12.sp : 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                'How to accept order in Rubia app?'.tr,
                                style: GoogleFonts.mulish(
                                  color: tLightBrown,
                                  fontSize: isTab(context) ? 12.sp : 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                decoration: BoxDecoration(
                    color: tWhite,
                    boxShadow: [tBoxShadow],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ExpansionTile(
                  title: Text(
                    "Order payment".tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontSize: isTab(context) ? 14.sp : 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  trailing: Icon(
                    selected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: isTab(context) ? 45 : 30,
                    color: tPrimaryColor,
                  ),
                  onExpansionChanged: (bool expanded) {
                    setState(() {
                      selected = expanded;
                    });
                  },
                  children: <Widget>[
                    ListTile(
                      title: Container(
                        child: Column(
                          children: [
                            Text(
                              'How to earn more money with Rubia app?'.tr,
                              style: GoogleFonts.mulish(
                                color: tLightBrown,
                                fontSize: isTab(context) ? 12.sp : 14.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              child: Text(
                                'How to accept order in Rubia app?'.tr,
                                style: GoogleFonts.mulish(
                                  color: tLightBrown,
                                  fontSize: isTab(context) ? 12.sp : 14.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Image.asset(Images.TRAINING),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
