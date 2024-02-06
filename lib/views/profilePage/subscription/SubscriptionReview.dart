import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/profilePage/subscription/subscription.dart';
import 'package:base_project_flutter/views/profile_review/ApplicationStatus.dart';
import 'package:base_project_flutter/views/wallet/walletpage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api_services/DriverDetailApis.dart';
import '../../../constants/imageConstant.dart';
import '../../../globalFuctions/globalFunctions.dart';
import '../../../globalWidgets/button.dart';
import '../../../globalWidgets/leadingbackbtn.dart';
import '../../../responsive.dart';


class SubscriptionReview extends StatefulWidget {
  const SubscriptionReview({Key? key,this.param}) : super(key: key);
  final param;

  @override
  State<SubscriptionReview> createState() => _SubscriptionReviewState();
}

class _SubscriptionReviewState extends State<SubscriptionReview> {
  @override
  void initState() {
    super.initState();
  }

  void _launchDialer(String phoneNumber) async {
    final url = 'tel://$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

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
                        launch(
                          "tel://+917893653899",
                        );
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


  // Future<void> launchURL(String url,) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(
  //       Uri.parse(url),
  //     );
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.forceNavigateTo(
                context, Subscription());
          },
        ),
      ),
      backgroundColor: tBackground,
      body: WillPopScope(
        onWillPop: () {
          return Twl.forceNavigateTo(
              context, Subscription());
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
                                    "Once_Confirmed".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                        isTab(context) ? 11.sp : 13.sp),
                                  ),
                                  Text(
                                    "Subscription_Active".tr,
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
                      startLoading();

                      var ress = await DriverDetailsApi().getDriverSubscription(context, widget.param);
                      if (ress != null && ress['status'] == 'OK') {
                        Twl.forceNavigateTo(context, Subscription());
                      } else {
                        stopLoading();
                        Twl.createAlert(context, 'Oops', ress['error'].toString());
                      }
                      stopLoading();
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
}
