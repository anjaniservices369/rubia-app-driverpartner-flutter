// ----------------------------------------------------------------------
// Pay joining fee
//
// The driver pays the one-time joining fee through Cashfree.
//
// Developer note: Cashfree mode comes from cashfreeProduction in apiConstants.dart
// (build with --dart-define=CASHFREE_PRODUCTION=true for real money).
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/views/joiningfees/qr_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants.dart';
import '../../globalFuctions/globalFunctions.dart';
import '../../globalWidgets/button.dart';
import '../../globalWidgets/leadingbackbtn.dart';
import '../../responsive.dart';
import '../profile_review/profile_review.dart';

// >>> START  class JoiningFees
class JoiningFees extends StatefulWidget {
  const JoiningFees({Key? key}) : super(key: key);

  @override
  State<JoiningFees> createState() => _JoiningFeesState();
}
// <<< END    class JoiningFees

// >>> START  class _JoiningFeesState
class _JoiningFeesState extends State<JoiningFees> {
  bool ischeckbox = false;
  // >>> START  _JoiningFeesState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: tWhite,
        leading: BackButtonLeading(
          onTap: () {
            Twl.navigateBack(context);
          },
        ),
        // centerTitle: false,
        title: Text('Joining_fees'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 11.sp : 14.sp,
                color: tSecondaryColor,
                fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: tDefaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    height: 30.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [tBoxShadow],
                        image: DecorationImage(
                            image: AssetImage(Images.JOININGIMGBACK),
                            fit: BoxFit.contain)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text('Joining_fees'.tr,
                      style: GoogleFonts.mulish(
                          fontSize: isTab(context) ? 11.sp : 14.sp,
                          color: tSecondaryColor,
                          fontWeight: FontWeight.w700)),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: tWhite,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [tBoxShadow]),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: Checkbox(
                              checkColor: Colors.white,
                              activeColor: tPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: ischeckbox == true
                                          ? tPrimaryColor
                                          : tPrimaryColor,
                                      width: 0.6)),
                              value: ischeckbox,
                              onChanged: (bool? value) {
                                setState(() {
                                  ischeckbox = value!;
                                });
                              }),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              'Pay_₹500_Joining_fees'.tr,
                              style: GoogleFonts.mulish(
                                  fontSize: isTab(context) ? 10.sp : 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: tSecondaryColor),
                            ),
                            Container(
                              width: 70.w,
                              child: Text(
                                "the_joining_fees _for_drivers_is_collected_to_cover_any_potential_damages,_violations,_orvunpaid_fees."
                                    .tr,
                                maxLines: 3,
                                style: GoogleFonts.mulish(
                                    fontSize: isTab(context) ? 8.sp : 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: tbrown),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Button(
                textcolor: tWhite,
                bottonText: 'submit'.tr,
                borderSide: BorderSide(
                  color: tPrimaryColor,
                ),
                onTap: (startLoading, stopLoading, btnState) async {
                  if (ischeckbox == true) {
                    startLoading();
                    Twl.forceNavigateTo(context, QRPage());

                    // Map<String, String> param = {
                    //   'order_amount': '500',
                    // };
                    // var res =
                    //     await DriverDetailsApi().createOrderApi(context, param);
                    // if (res != null && res['status'] == 'OK') {
                    //   stopLoading();
                    //   cfPaymentGatewayService.setCallback(
                    //     verifyPayment,
                    //     onError,
                    //   );
                    //   pay(res['details']['order_id'].toString(),
                    //       res['details']['payment_session_id']);
                    // } else {
                    //   stopLoading();
                    //   Twl.createAlert(context, 'Oops', res['error'].toString());
                    //   stopLoading();
                    // }
                  } else {
                    Twl.createAlert(
                        context, 'Alert', 'Joining fee is manditory');
                  }
                }),
            SizedBox(
              height: 2.h,
            ),
            Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "by_submission_you_agree_to_our".tr + " ",
                      style: GoogleFonts.mulish(
                        color: tSecondaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: isTab(context) ? 8.sp : 10.sp,
                      ),
                    ),
                  ]),
            ),
            Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "terms_&_conditions".tr ,
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
                Text(
                  "and".tr + " ",
                  style: GoogleFonts.mulish(
                    color: tSecondaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
                Text(
                  "privacy_policy".tr,
                  style: GoogleFonts.mulish(
                    color: tPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: isTab(context) ? 8.sp : 10.sp,
                  ),
                ),
              ],
            )),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
      ),
    );
  }
  // <<< END    _JoiningFeesState.build()

  // >>> START  _JoiningFeesState.verifyPayment()  -  verify payment
  void verifyPayment(String orderId) async {
    print("Verify Payment/...........");
    print("Verify Payment.........");
    Map<String, String> param = {
      'orderId': orderId,
    };
    var res = await DriverDetailsApi().fetchJoiningFeeStatus(context, param);
    if (res != null && res['status'] == 'OK') {
      Twl.forceNavigateTo(context, ProfileReview());
      print(param);
    } else {
      Twl.createAlert(context, 'Oops', res['error'].toString());
    }
    print("Verify Payment");
  }
  // <<< END    _JoiningFeesState.verifyPayment()

  // >>> START  _JoiningFeesState.onError()  -  on error
  void onError(CFErrorResponse errorResponse, String orderId) async {
    print(errorResponse.getMessage());
    print(errorResponse.getStatus().toString());
    print(errorResponse.getCode().toString());
    print("Error while making payment");
    return Twl.createAlert(context, errorResponse.getStatus().toString(),
        errorResponse.getMessage().toString());
  }
  // <<< END    _JoiningFeesState.onError()

  // >>> START  _JoiningFeesState.receivedEvent()  -  received event
  void receivedEvent(String event_name, Map<dynamic, dynamic> meta_data) {
    print(event_name);
    print(meta_data);
  }
  // <<< END    _JoiningFeesState.receivedEvent()

  var cfPaymentGatewayService = CFPaymentGatewayService();
  CFEnvironment environment =
      cashfreeProduction ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX;

  // >>> START  _JoiningFeesState.createSession()  -  create session
  CFSession? createSession(orderId, sessionID) {
    print(orderId);
    print('sessionID');
    print(sessionID);
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(sessionID)
          .build();
      return session;
    } on CFException catch (e) {
      print("e.createSession");
      print(e.message);
    }
    return null;
  }
  // <<< END    _JoiningFeesState.createSession()

  // >>> START  _JoiningFeesState.pay()
  pay(orderId, sessionId) async {
    print(orderId);
    print('sessionID');
    print(sessionId);
    try {
      var session = createSession(orderId, sessionId);
      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#FF0000")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();

      var cfWebCheckoutPayment = CFWebCheckoutPaymentBuilder()
          .setSession(session!)
          .setTheme(theme)
          .build();

      cfPaymentGatewayService.doPayment(cfWebCheckoutPayment);
    } on CFException catch (e) {
      print("e.pay");
      print(e.message);
    }
  }
  // <<< END    _JoiningFeesState.pay()
}
// <<< END    class _JoiningFeesState
