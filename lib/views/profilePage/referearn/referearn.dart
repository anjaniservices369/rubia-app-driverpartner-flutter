// ----------------------------------------------------------------------
// Refer & earn
//
// Share the app and see referral earnings.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

// >>> START  class ReferAndEarnView
class ReferAndEarnView extends StatefulWidget {
  @override
  State<ReferAndEarnView> createState() => _ReferAndEarnViewState();
}
// <<< END    class ReferAndEarnView

// >>> START  class _ReferAndEarnViewState
class _ReferAndEarnViewState extends State<ReferAndEarnView> {
  var authCode;
  var earningDetails;
  var resNOK;
  // >>> START  _ReferAndEarnViewState.fetchCheckDetails()  -  fetch check details
  fetchCheckDetails() async {
    var res = await RideBookingsApi().fetchMyReferalEarnings(context);
    if (res != null && res['status'] == 'OK') {
      setState(() {
        print('checkDetailsgggggggggg');
        earningDetails = res['details'];
        print('checkDetailsgggggggggg');
        print(earningDetails);
      });
    } else {
      setState(() {
        resNOK = res['status'];
      });
    }
  }
  // <<< END    _ReferAndEarnViewState.fetchCheckDetails()
  final Uri whatsappUrl = Uri.parse('https://api.whatsapp.com/send?phone=+917893653899&text=Hello%20there!');
  final Uri facebookUrl = Uri.parse('https://www.facebook.com/profile.php?id=61550853734341&mibextid=ZbWKwL');
  final Uri instagramUrl = Uri.parse('https://instagram.com/rubia.services?igshid=OGQ5ZDc2ODk2ZA==');
  final Uri twitterUrl = Uri.parse('https://x.com/RubiaServices?t=9Tr7ip8vD6euUPD5YfCSGQ&s=08');
  // >>> START  _ReferAndEarnViewState._launchUrl()  -  launch url
  // final uri TERMS_AND_CONDITIONS = Uri.parse(uri)
  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  // <<< END    _ReferAndEarnViewState._launchUrl()

  // >>> START  _ReferAndEarnViewState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchCheckDetails();
    super.initState();
  }
  // <<< END    _ReferAndEarnViewState.initState()

  // >>> START  _ReferAndEarnViewState.build()  -  draws this screen / widget (its layout)
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
        title: Text('Refer & Earn'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: earningDetails == null
          ? resNOK == 'NOK'
              ? Align(
                  alignment: Alignment.center,
                  child: Text('Refer & Earn'.tr,
                      style: TextStyle(
                          fontSize: isTab(context) ? 14.sp : 16.sp,
                          color: tBlue,
                          fontWeight: FontWeight.w700)),
                )
              : Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: tSecondaryColor,
                  ))
          : PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                Twl.forceNavigateTo(
                    context, BottomNavigation(tabIndexId: 3));
              },
              child: RefreshIndicator(
                onRefresh: (){
                  return fetchCheckDetails();
                },
                backgroundColor: tAppbarColor,
                color: tWhite,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 0),
                        decoration: BoxDecoration(
                            boxShadow: [tBoxShadow],
                            borderRadius: BorderRadius.circular(20),
                            color: tWhite),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Image(
                                height: 20.h,
                                image: AssetImage(Images.REFER_EARNING),
                              ),
                            ),
                            Text(
                              'refer_friends'.tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: tBlue,
                                  fontFamily: "mulish",
                                  fontSize: isTab(context) ? 18.sp : 20.sp),
                            ),
                            SizedBox(height: 1.4.h),
                            Text(
                              "earn Upto ₹50 Per Friend You Invite".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: tBlue,
                                  fontFamily: "mulish",
                                  fontSize: isTab(context) ? 12.sp : 14.sp),
                            ),
                            SizedBox(height: 1.8.h),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: tYellow),
                                child: Row(children: [
                                  Image(
                                    height: 2.6.h,
                                    image: AssetImage(Images.REWARD),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    "my_rewards".tr,
                                    style: GoogleFonts.mulish(
                                        color: tBlue,
                                        fontWeight: FontWeight.w600,
                                        fontSize: isTab(context) ? 10.sp : 12.sp),
                                  ),
                                  Spacer(),
                                  Text(
                                    currencySymbol +
                                        earningDetails['earnings'].toString(),
                                    style: GoogleFonts.mulish(
                                        color: tBlue,
                                        fontWeight: FontWeight.w700,
                                        fontSize: isTab(context) ? 13.sp : 15.sp),
                                  )
                                ]))
                          ],
                        ),
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding:
                              EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(
                              boxShadow: [tBoxShadow],
                              borderRadius: BorderRadius.circular(8),
                              color: tWhite),
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                  child: Text(
                                    "share_Your_Invite_Code".tr,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: tBlue,
                                        fontFamily: "mulish",
                                        fontSize: isTab(context) ? 11.sp : 13.sp),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Terms & Conditions"),
                                          content: Text("After verifying your referral driver, the referral reward will be added to your wallet, You cannot withdraw referral amount it can only redeemed on rides"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("OK"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          Images.INFOICON,
                                          color: tPrimaryColor,
                                          scale: 2.5,
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Text("T&Cs",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: tPrimaryColor,
                                              fontFamily: "mulish",
                                              fontSize: isTab(context) ? 8.sp : 10.sp
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ]),
                              GestureDetector(
                                onTap: () async {
                                  print('object');
                                  await Clipboard.setData(ClipboardData(
                                    text: earningDetails['referral_code']
                                        .toString(),
                                  ));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(earningDetails['referral_code']
                                            .toString() +
                                        ' Copied sucessfully'),
                                  ));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 15),
                                  child: DottedBorder(
                                    color: tPrimaryColor,
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(12),
                                    strokeWidth: 1,
                                    dashPattern: [6],
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 19),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: tSecondaryOrange),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image(
                                              height: 2.5.h,
                                              image: AssetImage(Images.COPYIMG),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            GestureDetector(
                                              onTap: () async {},
                                              child: Text(
                                                earningDetails['referral_code']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: tPrimaryColor,
                                                    fontFamily: "mulish",
                                                    fontSize: isTab(context)
                                                        ? 12.sp
                                                        : 15.sp),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                child: Column(
                                  children: [
                                    Text(
                                      'when_Your_Friends_Sign_Up_This_Referral'
                                          .tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                          color: tGray,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 8.sp : 10.sp),
                                    ),
                                    Text(
                                      'Code,_You_Can_Received_A_Free_Ride'.tr,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.mulish(
                                          color: tGray,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              isTab(context) ? 8.sp : 10.sp),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: () {
                              _launchUrl(whatsappUrl);
                            },
                            child: Container(
                              height: 6.5 * MediaQuery.of(context).size.height / 100,
                              width: 6.5 * MediaQuery.of(context).size.height / 100,
                              child: Image.asset(
                                Images.WHATSAPP,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          InkWell(
                            onTap: () {
                              _launchUrl(facebookUrl);
                            },
                            child: Container(
                              height: 6.5 * MediaQuery.of(context).size.height / 100,
                              width: 6.5 * MediaQuery.of(context).size.height / 100,
                              child: Image.asset(
                                Images.FACEBOOK,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 4 * MediaQuery.of(context).size.width / 100),
                          InkWell(
                            onTap: () {
                              _launchUrl(instagramUrl);
                            },
                            child: Container(
                              height: 6.5 * MediaQuery.of(context).size.height / 100,
                              width: 6.5 * MediaQuery.of(context).size.height / 100,
                              child: Image.asset(
                                Images.INSTAGRAM,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          InkWell(
                            onTap: () {
                              _launchUrl(twitterUrl);
                            },
                            child: Container(
                              height: 6.5 * MediaQuery.of(context).size.height / 100,
                              width: 6.5 * MediaQuery.of(context).size.height / 100,
                              child: Image.asset(
                                Images.TWITTER,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),


                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Button(
                            color: tPrimaryColor,
                            bottonText: 'refer'.tr,
                            textcolor: tWhite,
                            borderSide: BorderSide(
                              color: tPrimaryColor,
                            ),
                            onTap: (startLoading, stopLoading, btnState) async {
                              startLoading();
                              SharePlus.instance.share(ShareParams(
                                  text: 'Here\'s my referral code ' +
                                      earningDetails['referral_code'].toString() +
                                      ' and refer your friend to get earnings \n https://play.google.com/store/apps/details?id=com.rubia.driver'));
                              stopLoading();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
  // <<< END    _ReferAndEarnViewState.build()
}
// <<< END    class _ReferAndEarnViewState
