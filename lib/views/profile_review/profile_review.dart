import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/profile_review/ApplicationStatus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';

import '../enable_location/enable_location.dart';

class ProfileReview extends StatefulWidget {
  const ProfileReview({Key? key}) : super(key: key);

  @override
  State<ProfileReview> createState() => _ProfileReviewState();
}

class _ProfileReviewState extends State<ProfileReview> {
  @override
  void initState() {
    fetchCheck();
    super.initState();
  }

  var authCode;
  var checkDetails;
  var check;
  fetchCheck() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    authCode = sharedPreferences.getString('authCode');
    var check =
        await UserAPI().checkApi(sharedPreferences.getString('authCode')!);
    if (check != null && check['status'] == 'OK') {
      setState(() {
        checkDetails = check['detail'];
        print('checkDetailsgggggggggg');
        print(checkDetails);
        print('checkDetailsffffffffffffff');
      });
    }
  }

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
      body: WillPopScope(
        onWillPop: () {
          return Twl.willpopAlert(context);
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
                                    "your_profile_is_under_reviewing".tr,
                                    style: GoogleFonts.mulish(
                                        color: tSecondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            isTab(context) ? 11.sp : 13.sp),
                                  ),
                                  Text(
                                    "process._please_wait_2_to_4_days".tr,
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
                      await launchURL(CHAT_LINK);
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
                    bottonText: 'Check Status'.tr,
                    onTap: (startLoading, stopLoading, btnState) async {
                      startLoading();
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      var check = await UserAPI()
                          .checkApi(sharedPreferences.getString('authCode')!);
                      if (check != null && check['status'] == 'OK') {
                        stopLoading();
                        if (check['detail']['profile_verified'] ==
                            profile_verified_yes) {
                          print('im here');
                          print('object');
                          print(check['detail']['profile_verified'].toString());

                          print('object');
                          stopLoading();
                          Twl.forceNavigateTo(
                              context, VerificationSucessPage());
                        } else if (check['detail']['profile_verified'] ==
                            profile_verified_no) {
                          print('im hereeee');
                          print('object');
                          print(check['detail']['profile_verified'].toString());
                          print('object');
                          stopLoading();
                          Twl.forceNavigateTo(
                              context,
                              ApplicationStatusPage(
                                  profiledetails:
                                      checkDetails['rejection_reason'],
                                  profileStatus: check['detail']
                                      ['profile_verified']));
                        } else if (check['detail']['profile_verified'] ==
                            profile_verified_rejected) {
                          print('im heresssss');
                          print('object');
                          print(check['detail']['profile_verified'].toString());

                          print('object');
                          stopLoading();
                          Twl.forceNavigateTo(
                            context,
                            ApplicationStatusPage(
                              profileStatus: check['detail']
                                  ['profile_verified'],
                              profiledetails: checkDetails['rejection_reason'],
                            ),
                          );
                        } else {
                          stopLoading();
                          Twl.createAlert(context, 'Oops',
                              'Something went worng while verifying docuents try again after sometime');
                        }
                      } else {
                        stopLoading();
                        Twl.createAlert(context, 'Oops',
                            'Something went worng try again after sometime');
                      }
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
