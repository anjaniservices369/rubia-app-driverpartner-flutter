// ----------------------------------------------------------------------
// Profile under review
//
// Shown while your team checks the documents.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/userApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/stetuesConstant.dart';
import 'package:base_project_flutter/views/profile_review/ApplicationStatus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/imageConstant.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';


// >>> START  class ProfileReview
class ProfileReview extends StatefulWidget {
  const ProfileReview({Key? key}) : super(key: key);

  @override
  State<ProfileReview> createState() => _ProfileReviewState();
}
// <<< END    class ProfileReview

// >>> START  class _ProfileReviewState
class _ProfileReviewState extends State<ProfileReview> {
  // >>> START  _ProfileReviewState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchCheck();
    super.initState();
  }
  // <<< END    _ProfileReviewState.initState()

  var authCode;
  var checkDetails;
  var check;
  // >>> START  _ProfileReviewState.fetchCheck()  -  fetch check
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
  // <<< END    _ProfileReviewState.fetchCheck()


  // >>> START  _ProfileReviewState._showContactInfoDialog()  -  show contact info dialog
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
  // <<< END    _ProfileReviewState._showContactInfoDialog()


  // Future<void> launchURL(String url,) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(
  //       Uri.parse(url),
  //     );
  //   } else {
  //     print('Could not launch $url');
  //   }
  // }

  // >>> START  _ProfileReviewState.build()  -  draws this screen / widget (its layout)
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
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.willpopAlert(context);
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
                                    "process. Please Visit our office.".tr,
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
                    // onTap: (startLoading, stopLoading, btnState) async {
                    //   await launchURL(CHAT_LINK);
                    // },
                    onTap: (startLoading, stopLoading, btnState) async{
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
  // <<< END    _ProfileReviewState.build()
}
// <<< END    class _ProfileReviewState
