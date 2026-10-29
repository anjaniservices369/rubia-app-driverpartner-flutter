// ----------------------------------------------------------------------
// Wallet widgets & top-up
//
// Balance card, add-money flow (Cashfree) and withdraw button.
//
// Developer note: Cashfree mode comes from cashfreeProduction in apiConstants.dart.
// Withdrawal is manual: the app tells the driver to visit the office.
// ----------------------------------------------------------------------
import 'package:base_project_flutter/constants/apiConstants.dart';
import 'dart:io';
import 'package:base_project_flutter/api_services/DriverDetailApis.dart';
import 'package:base_project_flutter/api_services/rideBookingsApi.dart';
import 'package:base_project_flutter/globalFuctions/globalFunctions.dart';
import 'package:base_project_flutter/globalWidgets/button.dart';
import 'package:base_project_flutter/globalWidgets/customTextFiled.dart';
import 'package:base_project_flutter/views/bottomNavigation.dart/bottomNavigation.dart';
import 'package:base_project_flutter/views/wallet/wallet_topup.dart';
import 'package:base_project_flutter/views/wallet/wallet_withdraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/constants.dart';
import '../../../constants/imageConstant.dart';

import '../../../responsive.dart';

// >>> START  class WalletCardWidget
class WalletCardWidget extends StatefulWidget {
  const WalletCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WalletCardWidget> createState() => _WalletCardWidgetState();
}
// <<< END    class WalletCardWidget

// >>> START  class _WalletCardWidgetState
class _WalletCardWidgetState extends State<WalletCardWidget> {
  final TextEditingController _amountController = TextEditingController();


  // >>> START  _WalletCardWidgetState.initState()  -  runs once when the screen opens
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchBalance();
    }
  }
  // <<< END    _WalletCardWidgetState.initState()

  String? result;
  bool isLoading = true;
  var walletAmount;
  var resNOK;
  // >>> START  _WalletCardWidgetState.fetchBalance()  -  fetch balance
  fetchBalance() async {
    var response = await RideBookingsApi().getAvailableBalance(context);
    if (response != null && response['status'] == 'OK') {
      setState(() {
        walletAmount = response['details'];
        print(walletAmount);
      });
    } else {
      resNOK = response['status'];
    }
  }
  // <<< END    _WalletCardWidgetState.fetchBalance()

  // >>> START  _WalletCardWidgetState.build()  -  draws this screen / widget (its layout)
  @override
  Widget build(BuildContext context) {
    return walletAmount == null
        ? resNOK == 'NOK'
            ? Align(
                alignment: Alignment.center,
                child: Text('No data found'),
              )
            : SpinKitThreeBounce(
                color: tPrimaryColor,
                size: 20.0,
              )
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
            child: Container(
              height: isTab(context) ? 55.h : 33.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
              ),
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                    child: Stack(
                      children: [
                        Container(
                          height: isTab(context) ? 30.h : 20.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: SvgPicture.asset(
                            "assets/Wallet.svg",
                            fit: BoxFit.fill,
                            height: 210,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              walletAmount == null
                                  ? Text(
                                      currencySymbol + '0',
                                      style: GoogleFonts.mulish(
                                          fontSize:
                                              isTab(context) ? 23.sp : 27.sp,
                                          fontWeight: FontWeight.w800,
                                          color: tWhite),
                                    )
                                  : Text(
                                      currencySymbol + walletAmount.toString(),
                                      style: GoogleFonts.mulish(
                                          fontSize:
                                              isTab(context) ? 23.sp : 27.sp,
                                          fontWeight: FontWeight.w800,
                                          color: tWhite),
                                    ),
                              Text(
                                "Available Balance",
                                style: GoogleFonts.mulish(
                                    fontSize: isTab(context) ? 10.sp : 13.sp,
                                    fontWeight: FontWeight.w800,
                                    color: tWhite),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: isTab(context) ? 4.h : 0,
                            right: isTab(context) ? 0 : 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 2.h, horizontal: 2.h),
                              child: Transform.scale(
                                scale: isTab(context) ? 1 : 1,
                                child: (Platform.isIOS)
                                    ? Container()
                                    : GestureDetector(
                                        onTap: () {
                                          showWalletTopUp(context);
                                        },
                                        child: Icon(
                                          Icons.add_circle,
                                          size: isTab(context) ? 50 : 35,
                                          color: tWhite,
                                        ),
                                      ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: isTab(context) ? 30.w : 40.w,
                        height: isTab(context) ? 5.h : 7.h,
                        child: ButtonWidget(
                            borderSide: BorderSide(
                              color: tWhite,
                            ),
                            color: tWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.ADD_BALANCE,
                                  scale: isTab(context) ? 3 : 4,
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Text(
                                  "Add Balance".tr,
                                  style: GoogleFonts.mulish(
                                    color: tBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTab(context) ? 6.sp : 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            borderRadius: 15.0,
                            onTap: (startLoading, stopLoading, btnState) async {
                              showWalletTopUp(context);
                            }
                            ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: isTab(context) ? 30.w : 40.w,
                        height: isTab(context) ? 5.h : 7.h,
                        child: ButtonWidget(
                            borderSide: BorderSide(
                              color: tWhite,
                            ),
                            color: tWhite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Images.WITHDRAW,
                                  scale: isTab(context) ? 3 : 4,
                                ),
                                SizedBox(
                                  width: 2.h,
                                ),
                                Text(
                                  "Withdraw".tr,
                                  style: GoogleFonts.mulish(
                                    color: tBlue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: isTab(context) ? 6.sp : 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            borderRadius: 15.0,
                            onTap: (startLoading, stopLoading, btnState) async {
                              showWalletWithdraw(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
  // <<< END    _WalletCardWidgetState.build()

  // >>> START  _WalletCardWidgetState.verifyPayment()  -  verify payment
  void verifyPayment(String orderId) async {
    print("Verify Payment/...........");
    print("Verify Payment.........");
    Map<String, String> param = {
      'orderId': orderId,
    };

    print(param);
    var res = await RideBookingsApi().getAddMoneyWallet(context, param);
    print(res);
    if (res != null && res['status'] == 'OK') {
      setState(() {
        walletAmount = res['details']['amount'];
      });
      Twl.forceNavigateTo(context, BottomNavigation(tabIndexId: 2));
    } else {
      Twl.createAlert(context, 'Oops', res['error'].toString());
    }
    print("Verify Payment");
  }
  // <<< END    _WalletCardWidgetState.verifyPayment()

  // >>> START  _WalletCardWidgetState.onError()  -  on error
  void onError(CFErrorResponse errorResponse, String orderId) async {
    print(errorResponse.getMessage());
    print(errorResponse.getStatus().toString());
    print(errorResponse.getCode().toString());
    print("Error while making payment");
    return 
    Twl.createAlert(context,errorResponse.getStatus().toString(),errorResponse.getMessage().toString());
    
  }
  // <<< END    _WalletCardWidgetState.onError()

  // >>> START  _WalletCardWidgetState.receivedEvent()  -  received event
  void receivedEvent(String event_name, Map<dynamic, dynamic> meta_data) {
    print(event_name);
    print(meta_data);
  }
  // <<< END    _WalletCardWidgetState.receivedEvent()

  var cfPaymentGatewayService = CFPaymentGatewayService();
  CFEnvironment environment =
      cashfreeProduction ? CFEnvironment.PRODUCTION : CFEnvironment.SANDBOX;

  // >>> START  _WalletCardWidgetState.createSession()  -  create session
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
  // <<< END    _WalletCardWidgetState.createSession()

  // >>> START  _WalletCardWidgetState.pay()
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
  // <<< END    _WalletCardWidgetState.pay()

  // >>> START  _WalletCardWidgetState.createAlert()  -  create alert
  createAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return
          AlertDialog(
          title: Center(child: Text('Enter amount ')),
          content: TextFormFieldWidgets(
            style:
                TextStyle(fontWeight: FontWeight.w600, color: tSecondaryColor),
            controller: _amountController,
            validator: (value) {
              if (value!.isEmpty) {
                return "amount can't be empty";
              } else {
                return null;
              }
            },
            keyboardTyp: TextInputType.number,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            fillcolor: tBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            hinttext: 'Enter amount',
            hintStyl: TextStyle(
                color: tGray,
                fontSize: isTab(context) ? 7.sp : 10.sp,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Twl.navigateBack(context);
                  },
                  child: Container(
                      width: 30.w,
                      padding: EdgeInsets.symmetric(
                        vertical: isTab(context) ? 8 : 5,
                      ),
                      decoration: BoxDecoration(
                          // color: tPrimaryColor,
                          // boxShadow: [tBackbtnBoxShadow],
                          border: Border.all(color: tPrimaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text('Cancel',
                            style: GoogleFonts.mulish(
                                color: tPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context) ? 10.sp : 13.sp)),
                      )),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  width: 30.w,
                  child: ButtonWidget(
                    borderSide: BorderSide(color: tPrimaryColor),
                    color: tPrimaryColor,
                    borderRadius: isTab(context) ? 25.0 : 15.0,
                    child: Text('Add',
                        style: GoogleFonts.mulish(
                            color: tWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: isTab(context) ? 10.sp : 13.sp)),
                    onTap: (startLoading, stopLoading, btnState) async {
                      startLoading();
                      Map<String, String> param = {
                        'order_amount': _amountController.text,
                      };
                      var res = await DriverDetailsApi()
                          .createOrderApi(context, param);
                      if (res != null && res['status'] == 'OK') {
                        stopLoading();
                        cfPaymentGatewayService.setCallback(
                          verifyPayment,
                          onError,
                        );
                        pay(res['details']['order_id'].toString(),
                            res['details']['payment_session_id']);
                        Twl.navigateBack(context);
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'Oops', res['error'].toString());
                        stopLoading();
                      }
                      stopLoading();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  // <<< END    _WalletCardWidgetState.createAlert()

  // >>> START  _WalletCardWidgetState.withDrawAlert()  -  with draw alert
  withDrawAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Withdraw amount ')),
          content: TextFormFieldWidgets(
            style:
                TextStyle(fontWeight: FontWeight.w600, color: tSecondaryColor),
            controller: _amountController,
            validator: (value) {
              if (value!.isEmpty) {
                return "amount can't be empty";
              } else {
                return null;
              }
            },
            keyboardTyp: TextInputType.number,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            fillcolor: tBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            hinttext: 'Enter amount',
            hintStyl: TextStyle(
                color: tGray,
                fontSize: isTab(context) ? 7.sp : 10.sp,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Twl.navigateBack(context);
                  },
                  child: Container(
                      width: 30.w,
                      padding: EdgeInsets.symmetric(
                        vertical: isTab(context) ? 8 : 5,
                      ),
                      decoration: BoxDecoration(
                          // color: tPrimaryColor,
                          // boxShadow: [tBackbtnBoxShadow],
                          border: Border.all(color: tPrimaryColor, width: 1.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text('Cancel',
                            style: GoogleFonts.mulish(
                                color: tPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: isTab(context) ? 10.sp : 13.sp)),
                      )),
                ),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  width: 30.w,
                  // height: 6.h,
                  child: ButtonWidget(
                    borderSide: BorderSide(color: tPrimaryColor),
                    color: tPrimaryColor,
                    borderRadius: isTab(context) ? 25.0 : 15.0,
                    child: Text('Withdraw',
                        style: GoogleFonts.mulish(
                            color: tWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: isTab(context) ? 10.sp : 13.sp)),
                    onTap: (startLoading, stopLoading, btnState) async {
                      startLoading();
                      Map<String, String> param = {
                        'amount': _amountController.text
                      };
                      print(param);
                      var res = await RideBookingsApi()
                          .getWithdrawMoneyWallet(context, param);
                      print(res);
                      if (res != null && res['status'] == 'OK') {
                        setState(() {
                          walletAmount = res['details']['amount'];
                        });
                        Twl.forceNavigateTo(
                            context, BottomNavigation(tabIndexId: 2));
                        stopLoading();
                      } else {
                        stopLoading();
                        Twl.createAlert(
                            context, 'Oops', res['error'].toString());
                        stopLoading();
                      }
                      stopLoading();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  // <<< END    _WalletCardWidgetState.withDrawAlert()

  // Future<void> onPaymentClick(paymentToekn) async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   OpenPaymentPayload openPaymentPayload = OpenPaymentPayload(
  //       accessToken: ACCESSTOKEN,
  //       paymentToken: paymentToekn,
  //       environment: PaymentEnvironment.live, //PaymentEnvironment.sandbox
  //       logoUrl: "assets/images/mainlogo.png",
  //       mainColor: "#83025c",
  //       errorColor: "#ff0000");

  //   await OpenPayment.initiatePayment(
  //       openPaymentPayload: openPaymentPayload,
  //       onTransactionComplete: (TransactionDetails transactionDetails) async {
  //         print('TransactionDetails');
  //         print(transactionDetails.status.toString());
  //         // Handle transaction result
  //         print('Sucessful completed trans..');
  //         print('result...');
  //         print(result);
  //         setState(() {
  //           result = transactionDetails.status;
  //         });
  //         setState(() {
  //           isLoading = false;
  //         });

  //         Map<String, String> param = {'payment_token': paymentToekn};
  //         print(param);
  //         if (transactionDetails.status != 'cancelled') {
  //           var res = await HomeApi().addToWallet(context, param);
  //           if (res != null && res['status'] == 'OK') {
  //             setState(() {
  //               Twl.forceNavigateTo(context, EasyGoWallet());
  //               setState(() {
  //                 isLoading = false;
  //               });
  //             });
  //           } else {
  //             setState(() {
  //               isLoading = false;
  //             });
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               behavior: SnackBarBehavior.floating,
  //               content: Text(res['error']),
  //             ));
  //           }
  //           print(result);
  //         }
  //       },
  //       onError: (String error) {
  //         // Handle integration error
  //         setState(() {
  //           result = error;
  //         });
  //         print('failed failed trans..');
  //         Twl.createAlert(context, 'Oops', error.toString());
  //         print(error.toString());
  //       });
  // }
}
// <<< END    class _WalletCardWidgetState
