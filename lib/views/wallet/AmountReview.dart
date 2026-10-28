// ----------------------------------------------------------------------
// Confirm top-up amount
//
// Reviews the amount before paying.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';

import '../bottomNavigation.dart/bottomNavigation.dart';

// >>> START  class AmountReview
class AmountReview extends StatefulWidget {
  const AmountReview({Key? key}) : super(key: key);

  @override
  State<AmountReview> createState() => _AmountReviewState();
}
// <<< END    class AmountReview

// >>> START  class _AmountReviewState
class _AmountReviewState extends State<AmountReview> {
  // >>> START  _AmountReviewState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    super.initState();
  }
  // <<< END    _AmountReviewState.initState()

  // >>> START  _AmountReviewState._showContactInfoDialog()  -  show contact info dialog
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
                        // _launchDialer("+917893653899");
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
  // <<< END    _AmountReviewState._showContactInfoDialog()


  // Future<void> launchURL(String url,) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(
  //       Uri.parse(url),
  //     );
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }

  // >>> START  _AmountReviewState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
          },
        ),
      ),
      backgroundColor: tBackground,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
        },
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1,
                      margin:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                      decoration: BoxDecoration(
                          color: tWhite,
                          boxShadow: [tBoxShadow],
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Lottie.asset(
                            Images.DOCUMENT_PENDING,
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 30,
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Once Payment is confirmed,".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        isTab(context) ? 11.sp : 13.sp),
                                  ),
                                  Text(
                                    "Amount will be added to your Wallet".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        isTab(context) ? 11.sp : 13.sp),
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
                    bottonText: 'Continue'.tr,
                    onTap: (startLoading, stopLoading, btnState) async {
                      Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
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
      ),
    );
  }
  // <<< END    _AmountReviewState.build()
}
// <<< END    class _AmountReviewState
