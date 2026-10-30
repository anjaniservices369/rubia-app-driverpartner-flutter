// ----------------------------------------------------------------------
// Application status
//
// Shows approved / pending status of the application.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/globalWidgets/leadingbackbtn.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/profile_review/profile_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/imageConstant.dart';
import '../referalCode/referalCode.dart';

// >>> START  class ApplicationStatusPage
class ApplicationStatusPage extends StatefulWidget {
  const ApplicationStatusPage({Key? key, this.profileStatus, this.profiledetails});
  final profileStatus;
  final profiledetails;
  @override
  State<ApplicationStatusPage> createState() => _ApplicationStatusPageState();
}
// <<< END    class ApplicationStatusPage

// >>> START  class _ApplicationStatusPageState
class _ApplicationStatusPageState extends State<ApplicationStatusPage> {
  // Future<void> launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(
  //       Uri.parse(url),
  //     );
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }


  // >>> START  _ApplicationStatusPageState._showContactInfoDialog()  -  show contact info dialog
  void _showContactInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Information', style: GoogleFonts.mulish(
            color: tBlack,
            fontSize: isTab(context) ? 16.sp : 14.sp,
            fontWeight: FontWeight.w800,
          ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Phone: +91 78936 53899',style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 16.sp : 14.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 10),
              Text('Email: rubia.services@gmail.com',style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 14.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 10),
              Text('Address:  Rubia Services(OPC) Pvt.Ltd Lig 60/5, 4th Phase, KPHB Colony, Hyderabad, 500085' ,style: GoogleFonts.mulish(
                color: tBlack,
                fontSize: isTab(context) ? 14.sp : 12.sp,
                fontWeight: FontWeight.w500,
              ),),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    child: Button(
                      color: tPrimaryColor,
                      textcolor: tWhite,
                      bottonText: 'Call'.tr,
                      borderSide: BorderSide(color: tPrimaryColor),
                      onTap: (startLoading, stopLoading, btnState) async {
                        launchUrl(Uri.parse("tel://+917893653899"));
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Button(
                      color: tPrimaryColor,
                      textcolor: tWhite,
                      bottonText: 'Location'.tr,
                      borderSide: BorderSide(color: tPrimaryColor),
                      onTap: (startLoading, stopLoading, btnState) async {
                        MapsLauncher.launchCoordinates(17.4739803, 78.3886243);
                      },
                    ),
                  ),
                ],
              ),

            ],
          ),
          actions: [
            Center(
              child: Container(
                child: Button(
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'OK'.tr,
                  borderSide: BorderSide(color: tPrimaryColor),
                  onTap: (startLoading, stopLoading, btnState) async{
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              height:2.h,
            ),
          ],
        );
      },
    );
  }
  // <<< END    _ApplicationStatusPageState._showContactInfoDialog()

  // >>> START  _ApplicationStatusPageState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.willpopAlert(context);
          },
        ),
      ),
      backgroundColor: tBackground,
      body: Padding(
        padding: EdgeInsets.all(2),
        child: widget.profileStatus == profile_verified_rejected
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1,
                          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Lottie.asset(
                                Images.DOCUMENT_REJECTED,
                                height: 25.h,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        widget.profiledetails ?? " ",
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                        maxLines: 3,
                                        style: GoogleFonts.mulish(color: tRed, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 10.sp : 13.sp),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                        'Your Applicaton has been rejected ',
                                        style: GoogleFonts.mulish(
                                            color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 11.sp : 13.sp),
                                      ),
                                      Text(
                                        'try again after sometime ',
                                        style: GoogleFonts.mulish(
                                            color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 11.sp : 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Button(
                        // height: 7.h,
                        // width: 55.w,
                        color: tPrimaryColor,
                        textcolor: tWhite,
                        bottonText: 'Contact us'.tr,
                        borderSide: BorderSide(color: tPrimaryColor),
                        // boxshadow: [
                        //   tButtonBoxshadow
                        // ],
                        // onTap: (startLoading, stopLoading, btnState) async {
                        //   await launchURL(CHAT_LINK);
                        // },
                        onTap: (startLoading, stopLoading, btnState) async {
                          _showContactInfoDialog(context);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Container(
                      child: Button(
                        textcolor: tWhite,
                        bottonText: 'Exit'.tr,
                        onTap: (startLoading, stopLoading, btnState) {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1,
                          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(color: tWhite, boxShadow: [tBoxShadow], borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: [
                              Lottie.asset(
                                Images.DOCUMENT_REJECTED,
                                height: 25.h,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                widget.profiledetails ?? " ",
                                style: GoogleFonts.mulish(color: tRed, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 11.sp : 12.sp),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 30,
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Your Applicaton still in progress ',
                                        style: GoogleFonts.mulish(
                                            color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 11.sp : 13.sp),
                                      ),
                                      Text(
                                        'try again after sometime ',
                                        style: GoogleFonts.mulish(
                                            color: tSecondaryColor, fontWeight: FontWeight.w600, fontSize: isTab(context) ? 11.sp : 13.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Button(
                        textcolor: tWhite,
                        bottonText: 'go_home'.tr,
                        onTap: (startLoading, stopLoading, btnState) {
                          Twl.forceNavigateTo(context, ProfileReview());
                          // SystemChannels.platform
                          //     .invokeMethod('SystemNavigator.pop');
                        },
                      ),
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
  // <<< END    _ApplicationStatusPageState.build()
}
// <<< END    class _ApplicationStatusPageState

//Verification sucess status

// >>> START  class VerificationSucessPage
class VerificationSucessPage extends StatefulWidget {
  const VerificationSucessPage({Key? key});

  @override
  State<VerificationSucessPage> createState() => _VerificationSucessPageState();
}
// <<< END    class VerificationSucessPage

// >>> START  class _VerificationSucessPageState
class _VerificationSucessPageState extends State<VerificationSucessPage> {
  // >>> START  _VerificationSucessPageState.build()  -  draws this screen / widget (its layout)
  @override
  // void initState() {
  //   super.initState();
  //   new Future.delayed(const Duration(seconds: 3), () async {}).then((value) {
  //     // Twl.forceNavigateTo(context, BottomNavigation());
  //     //here it should navigateto location page
  //     Twl.forceNavigateTo(context, LocationErrorScreen());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tBackground,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Container(
              height: 50.h,
              child: Lottie.asset('assets/lottie/SucessLottie.json'),
            ),
            SizedBox(height: 2.h),
            Text(
              'Verification Done',
              style: GoogleFonts.mulish(color: tBlack, fontWeight: FontWeight.w700, fontSize: isTab(context) ? 10.sp : 18.sp),
            ),
            SizedBox(height: 2.h),
            Text(
              'Your driver profile has been approved',
              style: GoogleFonts.mulish(color: tBlack, fontSize: isTab(context) ? 10.sp : 12.sp),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: tDefaultPadding / 0.3),
              child: Button(
                  borderSide: BorderSide(
                    color: tPrimaryColor,
                  ),
                  color: tPrimaryColor,
                  textcolor: tWhite,
                  bottonText: 'Go Home',
                  onTap: (startLoading, stopLoading, btnState) async {
                    startLoading();


                    Twl.forceNavigateTo(context, ReferalCodeView());
                    stopLoading();
                  }),
            ),
            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }
  // <<< END    _VerificationSucessPageState.build()
}
// <<< END    class _VerificationSucessPageState
