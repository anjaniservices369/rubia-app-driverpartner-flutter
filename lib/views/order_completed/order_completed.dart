// ----------------------------------------------------------------------
// Ride completed
//
// 'Great job' end screen with Ready for next ride.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/providers/locationProvider.dart';
import 'package:base_project_flutter/responsive.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../constants/imageConstant.dart';
import '../../globalWidgets/button.dart';
import '../bottomNavigation.dart/bottomNavigation.dart';

// >>> START  class OrderCompletd
class OrderCompletd extends StatefulWidget {
  const OrderCompletd({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<OrderCompletd> createState() => _OrderCompletdState();
}
// <<< END    class OrderCompletd

// >>> START  class _OrderCompletdState
class _OrderCompletdState extends State<OrderCompletd> {
  // >>> START  _OrderCompletdState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    // Keep rebuilding this widget when LocationProvider changes.
    context.watch<LocationProvider>();
    return Scaffold(
      backgroundColor: tBackground,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: tWhite,
        title: Text(
          'ride_completed'.tr,
          style: GoogleFonts.mulish(
            color: tSecondaryColor,
            fontSize: isTab(context) ? 14.sp : 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.navigateTo(context, BottomNavigation(tabIndexId: 1));
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        decoration: BoxDecoration(
                            color: tWhite,
                            boxShadow: [tBoxShadow],
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Center(
                          child: Column(
                            children: [
                              Image.asset(
                                Images.THUMSUP,
                                scale: isTab(context) ? 2.5 : 3.5,
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                'great_Job'.tr + '!',
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 14.sp : 17.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                'ride_successfully_completed'.tr,
                                style: GoogleFonts.mulish(
                                  color: tSecondaryColor,
                                  fontSize: isTab(context) ? 10.sp : 12.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Button(
                borderSide: BorderSide(
                  color: tPrimaryColor,
                ),
                textcolor: tWhite,
                color: tPrimaryColor,
                bottonText: "ready_for_next_ride".tr,
                onTap: (startLoading, stopLoading, btnState) {
                  Twl.navigateTo(context, BottomNavigation(tabIndexId: 1));
                },
              ),
            ),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
  // <<< END    _OrderCompletdState.build()
}
// <<< END    class _OrderCompletdState
