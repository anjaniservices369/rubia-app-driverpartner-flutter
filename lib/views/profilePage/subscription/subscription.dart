// ----------------------------------------------------------------------
// Subscription plans
//
// Paid membership plans the driver can buy.
//
// Developer note: Cashfree mode comes from cashfreeProduction in apiConstants.dart.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/constants/constants.dart';
import 'package:base_project_flutter/constants/imageConstant.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/responsive.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../globalFuctions/globalFunctions.dart';
import 'QR_subscription.dart';

// >>> START  class Subscription
class Subscription extends StatefulWidget {
  const Subscription({Key? key}) : super(key: key);

  @override
  _SubscriptionState createState() => _SubscriptionState();
}
// <<< END    class Subscription

// >>> START  class _SubscriptionState
class _SubscriptionState extends State<Subscription> {
  var planDetails;
  var resNok;
  DateTime d1 = DateTime.now();
  DateTime d2 = DateTime.now().add(Duration(days: 30));
  late Duration difference = d1.difference(d2);

  // >>> START  _SubscriptionState.parseDate()  -  parse date
  DateTime parseDate(String dateString) {
    // Parse your date string into a DateTime object
    // Assuming dateString is in the format 'dd-MM-yyyy'
    List<String> parts = dateString.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);
    DateTime parsedDate = DateTime(year, month, day, 23, 59, 59);
    return parsedDate;
  }
  // <<< END    _SubscriptionState.parseDate()


  // >>> START  _SubscriptionState.fetchDriverPlans()  -  fetch driver plans
  fetchDriverPlans() async {
    var res = await DriverDetailsApi().getDriverPlans(context);
    if (res != null && res['status'] == 'OK') {
      setState(() {
        planDetails = res['details'];
        print(d2);
        if(planDetails['end_date']!=''){
          d2 = parseDate(planDetails['end_date']);
          // print(planDetails['end_date']);
          print(d2);
          difference = d2.difference(d1);
        }

      });
    } else {
      setState(() {
        resNok = res['status'];
      });
    }
  }
  // <<< END    _SubscriptionState.fetchDriverPlans()

  // >>> START  _SubscriptionState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    fetchDriverPlans();
    super.initState();
  }
  // <<< END    _SubscriptionState.initState()

  // >>> START  _SubscriptionState.build()  -  draws this screen / widget (its layout)
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
              color: tPrimaryColor,
              size: 16,
            ),
          ),
        ),
        centerTitle: false,
        title: Text('subscription_plan'.tr,
            style: TextStyle(
                fontSize: isTab(context) ? 14.sp : 16.sp,
                color: tBlue,
                fontWeight: FontWeight.w700)),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 3));
        },
        child: planDetails == null
            ? resNok == 'NOK'
                ? Align(
                    alignment: Alignment.center,
                    child: Text('No data found',
                        style: TextStyle(
                            fontSize: isTab(context) ? 10.sp : 14.sp,
                            color: tBlue,
                            fontWeight: FontWeight.w800)),
                  )
                : Container(
                    padding: EdgeInsets.all(10),
                    child: SpinKitRotatingCircle(color: tAppbarColor),
                  )
            : RefreshIndicator(
              onRefresh: () {
                return fetchDriverPlans();
              },
              backgroundColor: tAppbarColor,
              color: tWhite,
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: tDefaultPadding),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 3.h,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: isTab(context) ? 30.h : 20.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(17),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            Images.DRIVER,
                                          ),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Text('Driver Prime Membership',
                                      style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 10.sp : 14.sp,
                                          color: tBlue,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Text('Elevate Your Driving Experience with',
                                      style: TextStyle(
                                          fontSize: isTab(context) ? 7.sp : 10.sp,
                                          color: tLightBrown,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(
                                    height: 0.5.h,
                                  ),
                                  Center(
                                    child: Text('Premium Features!',
                                        style: TextStyle(
                                            fontSize:
                                                isTab(context) ? 7.sp : 10.sp,
                                            color: tLightBrown,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 30),
                                    child: Divider(
                                      color: tGray,
                                      height: 2.h,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 1.h,
                                          width: 1.h,
                                          decoration: BoxDecoration(
                                              color: tBlue,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                            'Premium Features for Enhanced Driving',
                                            style: TextStyle(
                                                fontSize:
                                                    isTab(context) ? 7.sp : 10.sp,
                                                color: tBlue,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 1.h,
                                          width: 1.h,
                                          decoration: BoxDecoration(
                                              color: tBlue,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2,
                                          child: Text(
                                              'Elevate Your Experience with Prime Membership',
                                              style: TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  fontSize: isTab(context)
                                                      ? 7.sp
                                                      : 10.sp,
                                                  color: tBlue,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 1.h,
                                          width: 1.h,
                                          decoration: BoxDecoration(
                                              color: tBlue,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                            'Exclusive Benefits for Prime Drivers',
                                            style: TextStyle(
                                                fontSize:
                                                    isTab(context) ? 7.sp : 10.sp,
                                                color: tBlue,
                                                fontWeight: FontWeight.w600))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 1.h,
                                          width: 1.h,
                                          decoration: BoxDecoration(
                                              color: tBlue,
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2,
                                          child: Text(
                                              'Unlock Premium Features for Better Driving',
                                              style: TextStyle(
                                                  overflow: TextOverflow.clip,
                                                  fontSize: isTab(context)
                                                      ? 7.sp
                                                      : 10.sp,
                                                  color: tBlue,
                                                  fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        planDetails['plan_activated'] == false
                            ? Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text('Only at just ',
                                          style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 10.sp : 14.sp,
                                              color: tBlue,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                          currencySymbol +
                                              planDetails['price'].toString() +
                                              ' /-',
                                          style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 12.sp : 16.sp,
                                              color: tPrimaryColor,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(
                                        height: 2.h,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            child: Text(planDetails['description'],
                                                style: TextStyle(
                                                    fontSize: isTab(context)
                                                        ? 10.sp
                                                        : 12.sp,
                                                    color: tLightBrown,
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17)),
                                elevation: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text('Plan expires in',
                                          style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 10.sp : 14.sp,
                                              color: tBlue,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Text(
                                          difference.inDays.toString() +
                                              ' days',
                                          style: TextStyle(
                                              fontSize:
                                                  isTab(context) ? 12.sp : 16.sp,
                                              color: tPrimaryColor,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(height: 2.h),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 3.w),
                                        decoration: BoxDecoration(
                                            color: tWhite,
                                            borderRadius: BorderRadius.circular(10),
                                            boxShadow: [tBoxShadow]),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  Images.CALENDER,
                                                  scale: 3,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Start Date',
                                                      style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontSize: isTab(context)
                                                            ? 12.sp
                                                            : 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                        planDetails['start_date'].toString(),
                                                      style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontSize: isTab(context)
                                                            ? 12.sp
                                                            : 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 8.h,
                                              width: 0.4.w,
                                              color: tSecondaryColor,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  Images.CALENDER,
                                                  scale: 3,
                                                ),
                                                SizedBox(
                                                  width: 3.w,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'End Date',
                                                      style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontSize: isTab(context)
                                                            ? 12.sp
                                                            : 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 1.h,
                                                    ),
                                                    Text(
                                                      planDetails['end_date'].toString(),
                                                      style: GoogleFonts.mulish(
                                                        color: tSecondaryColor,
                                                        fontSize: isTab(context)
                                                            ? 12.sp
                                                            : 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(height: 3.h),
                        planDetails['plan_activated'] == false
                            ? Button(
                                textcolor: tWhite,
                                bottonText: 'subscribe_now'.tr,
                                borderSide: BorderSide(
                                  color: tPrimaryColor,
                                ),
                                onTap:
                                    (startLoading, stopLoading, btnState) async {
                                      Twl.forceNavigateTo(
                                          context, QRSubscriptionPage(price:planDetails['price'].toString()));
                                },
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 6.w,
                                    color: tBlue,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text('Subscribed',
                                      style: TextStyle(
                                          fontSize:
                                              isTab(context) ? 10.sp : 14.sp,
                                          color: tBlue,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
            ),
      ),
    );
  }
  // <<< END    _SubscriptionState.build()

  // >>> START  _SubscriptionState.verifyPayment()  -  verify payment
  void verifyPayment(String orderId) async {
    print("Verify Payment/...........");
    print("Verify Payment.........");
    Map<String, String> param = {
      'orderId': orderId,
    };
    //Api hit here
    var res = await DriverDetailsApi().getDriverSubscription(context, param);
    if (res != null && res['status'] == 'OK') {
      Twl.forceNavigateTo(context, Subscription());
    } else {
      Twl.createAlert(context, 'Oops', res['error'].toString());
    }
  }
  // <<< END    _SubscriptionState.verifyPayment()

  // >>> START  _SubscriptionState.onError()  -  on error
  void onError(CFErrorResponse errorResponse, String orderId) async {
    print(errorResponse.getMessage());
    print(errorResponse.getStatus().toString());
    print(errorResponse.getCode().toString());
    print("Error while making payment");
    return Twl.createAlert(context, errorResponse.getStatus().toString(),
        errorResponse.getMessage().toString());
  }
  // <<< END    _SubscriptionState.onError()

  // >>> START  _SubscriptionState.receivedEvent()  -  received event
  void receivedEvent(String event_name, Map<dynamic, dynamic> meta_data) {
    print(event_name);
    print(meta_data);
  }
  // <<< END    _SubscriptionState.receivedEvent()

  var cfPaymentGatewayService = CFPaymentGatewayService();
  CFEnvironment environment =
      cashfreeProduction ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX;

  // >>> START  _SubscriptionState.createSession()  -  create session
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
  // <<< END    _SubscriptionState.createSession()

  // >>> START  _SubscriptionState.pay()
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
  // <<< END    _SubscriptionState.pay()
}
// <<< END    class _SubscriptionState
