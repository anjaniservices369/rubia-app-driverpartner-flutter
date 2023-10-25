import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';

class EnableLocationView extends StatelessWidget {
  const EnableLocationView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: tDefaultPadding, vertical: tDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: MediaQuery.of(context).viewInsets,
                decoration: BoxDecoration(
                    color: tWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [tBoxShadow]),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.h),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),

                      Lottie.asset(
                        'assets/lottie/location_layer.json',
                        height: 25.h,
                      ),

                      SizedBox(
                        height: 2.h,
                      ),

                      SizedBox(
                        height: 5.h,
                      ),
                      Text('enable_location_to_get_nearby_rides'.tr,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: tSecondaryColor,
                              fontSize: isTab(context) ? 11.sp : 14.sp,
                              fontWeight: FontWeight.w600)),

                      SizedBox(
                        height: 4.h,
                      ),
                      //api
                      // status != PermissionStatus.granted
                      //     ? Padding(
                      //         padding:
                      //             const EdgeInsets.all(8.0),
                      //         child: Center(
                      //           child: SizedBox(
                      //             width: isTab(context)
                      //                 ? 40.w
                      //                 : 60.w,
                      //             height: isTab(context)
                      //                 ? 6.h
                      //                 : 7.h,
                      //             child: ButtonWidget(
                      //                 borderSide: BorderSide(
                      //                   color: tBlack,
                      //                 ),
                      //                 // borderRadius: BorderRadius.circular(15),
                      //                 borderRadius: 15.0,
                      //                 color: tBlack,
                      //                 child: Text(
                      //                   "Fetching",
                      //                   style:
                      //                       GoogleFonts.mulish(
                      //                           letterSpacing:
                      //                               1,
                      //                           color: tWhite,
                      //                           fontWeight:
                      //                               FontWeight
                      //                                   .w700,
                      //                           fontSize: isTab(
                      //                                   context)
                      //                               ? 10.sp
                      //                               : 15.sp),
                      //                 ),
                      //                 onTap: (startLoading,
                      //                     stopLoading,
                      //                     btnState) async {
                      //                   await determinePosition();
                      //                 }),
                      //           ),
                      //         ),
                      //       )
                      //     :
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: SizedBox(
                            width: isTab(context) ? 40.w : 60.w,
                            height: isTab(context) ? 6.h : 7.h,
                            child: Button(
                                borderSide: BorderSide(
                                  color: tPrimaryColor,
                                ),
                                // borderRadius: BorderRadius.circular(15),
                                textcolor: tWhite,
                                color: tPrimaryColor,
                                bottonText: "enable_location".tr,
                                onTap: (startLoading, stopLoading, btnState) {
                                  Twl.forceNavigateTo(
                                      context,
                                      BottomNavigation(
                                        tabIndexId: 0,
                                      ));
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: isTab(context)
                              ? tDefaultPadding
                              : tDefaultPadding / 2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
