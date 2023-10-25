import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/ride_info/Car_RideEndingData/driverEndUploadSelfie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalWidgets/button.dart';
import '../../../responsive.dart';

class DriveEndVerificationPopUp extends StatefulWidget {
  const DriveEndVerificationPopUp({Key? key, this.bookingDetails}) : super(key: key);
  final bookingDetails;
  @override
  State<DriveEndVerificationPopUp> createState() => _DriveEndVerificationPopUpState();
}

class _DriveEndVerificationPopUpState extends State<DriveEndVerificationPopUp> {
  @override
  int reason = 0;
  bool ischeckbox = false;
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 1));
      },
      child: Dialog(
        backgroundColor: tWhite,
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                //
                Center(
                  child: Text(
                    "verification".tr,
                    style: GoogleFonts.mulish(
                      color: tSecondaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: isTab(context) ? 20.sp : 22.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        "before_you_start_ride_please_take_selfies_&".tr,
                        style: GoogleFonts.mulish(
                          color: tBrown,
                          fontWeight: FontWeight.w500,
                          fontSize: isTab(context) ? 10.sp : 12.sp,
                        ),
                      ),
                      Text(
                        "take_photos_of_car".tr,
                        style: GoogleFonts.mulish(
                          color: tBrown,
                          fontWeight: FontWeight.w500,
                          fontSize: isTab(context) ? 10.sp : 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Image.asset(
                  Images.VERIFICATIONDIMG,
                  scale: isTab(context) ? 2 : 3,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                        scale: 1.1,
                        child: Theme(
                          data: ThemeData(unselectedWidgetColor: tPrimaryColor),
                          child: Checkbox(
                              activeColor: tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(color: ischeckbox == true ? tPrimaryColor : tPrimaryColor, width: 0.6)),
                              value: ischeckbox,
                              onChanged: (bool? value) {
                                setState(() {
                                  ischeckbox = value!;
                                });
                              }),
                        )),
                    Container(
                        child: Expanded(
                            child: Text(
                      "Please_be_ready_with_your_camera_and_clean_your_lens".tr,
                      style: GoogleFonts.mulish(
                        color: tbrown,
                        fontWeight: FontWeight.w400,
                        fontSize: isTab(context) ? 10.sp : 12.sp,
                      ),
                    )))
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'Start'.tr,
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();
                    ischeckbox == true
                        ? Twl.forceNavigateTo(context, DriverEndUploadSelfie(bookingDetails: widget.bookingDetails))
                        : Twl.createAlert(context, 'Oops', 'Please Check the verification process');
                    stopLoading();
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
